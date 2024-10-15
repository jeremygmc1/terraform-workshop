#!/bin/bash

# Enable error handling
set -o pipefail

# Variables for S3 backend configuration
AWS_BUCKET_NAME="aws-terraform-workshop-admin"
AWS_REGION="ap-southeast-1"
AWS_DYNAMODB_TABLE="itsa-workshop-admin-tf-statelock"

# Directory to store logs
LOG_DIR="./logs"
mkdir -p "${LOG_DIR}"

# Parent folder where working directories will be created
PARENT_FOLDER="test_dir"
mkdir -p "${PARENT_FOLDER}"

# Directory containing your Terraform configurations
TERRAFORM_CONFIG_DIR="./section3/answer3"

# Initialize Terraform in the configuration directory without the backend
cd "${TERRAFORM_CONFIG_DIR}"
terraform init -backend=false
cd -

# Maximum number of parallel jobs
# This is very important to prevent overwhelming your computer which may cause the tf script to fail
MAX_JOBS=10

# Function to check and wait if the number of background jobs reaches MAX_JOBS
function wait_for_jobs {
    while [ "$(jobs -p | wc -l)" -ge "$MAX_JOBS" ]; do
        # Wait for any job to finish
        sleep 1
        # Clean up completed jobs
        jobs > /dev/null
    done
}

# Array to hold PIDs
PIDS=()

# Loop to apply terraform-managed resources in parallel
for i in {1..30}
do
    # Call the function to check job limits
    wait_for_jobs

    (
    # Each iteration runs in a subshell

    # Unique state file key for each iteration
    AWS_BUCKET_KEY_NAME="statefile_${i}.tfstate"

    # Set the student_number variable
    export TF_VAR_student_id="student-${i}"

    # Create a unique working directory within PARENT_FOLDER
    WORK_DIR="${PARENT_FOLDER}/workdir_${i}"
    mkdir -p "${WORK_DIR}"

    # Copy Terraform configuration files into the working directory
    cp -r "${TERRAFORM_CONFIG_DIR}/." "${WORK_DIR}/"

    # Change to the working directory
    cd "${WORK_DIR}"

    echo "Running terraform init and apply for iteration ${i}"

    # Log files for this iteration (relative to the script's directory)
    INIT_LOG="../../${LOG_DIR}/terraform_init_student_${i}.log"
    APPLY_LOG="../../${LOG_DIR}/terraform_apply_student_${i}.log"

    # Initialize Terraform with unique backend configurations
    echo "Initializing Terraform for student number ${i}..."
    terraform init \
        -backend-config="bucket=${AWS_BUCKET_NAME}" \
        -backend-config="key=${AWS_BUCKET_KEY_NAME}" \
        -backend-config="region=${AWS_REGION}" \
        -backend-config="dynamodb_table=${AWS_DYNAMODB_TABLE}" \
        -reconfigure \
        > "${INIT_LOG}" 2>&1

    # Check if terraform init was successful
    if [ $? -ne 0 ]; then
        echo "Error: Terraform init failed for student number ${i}. Check log: ${INIT_LOG}"
        exit 1
    fi

    # Apply the Terraform configuration
    echo "Applying Terraform configuration for student number ${i}..."
    terraform apply -auto-approve -input=false \
        > "${APPLY_LOG}" 2>&1

    # Check if terraform apply was successful
    if [ $? -ne 0 ]; then
        echo "Error: Terraform apply failed for student number ${i}. Check log: ${APPLY_LOG}"
        exit 1
    fi

    # Optional: Unset the student_number variable
    unset TF_VAR_student_id

    echo "Completed Terraform run for student number ${i}."

    # Change back to the original directory
    cd ../../

    # Clean up the generated directory
    rm -rf "${WORK_DIR}"

    ) &
    PIDS+=($!) # Collect the PID of the background process
done

# Wait for all background processes to finish
FAIL=0
for pid in "${PIDS[@]}"; do
    wait $pid || ((FAIL++))
done

if [ "$FAIL" -ne 0 ]; then
    echo "$FAIL background job(s) failed."
else
    echo "All background jobs completed successfully."
fi
