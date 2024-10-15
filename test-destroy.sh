#!/bin/bash

set -o pipefail

AWS_BUCKET_NAME="aws-terraform-workshop-admin"
AWS_REGION="ap-southeast-1"
AWS_DYNAMODB_TABLE="itsa-workshop-admin-tf-statelock"

LOG_DIR="./logs_destroy"
mkdir -p "${LOG_DIR}"

PARENT_FOLDER="test_dir"
mkdir -p "${PARENT_FOLDER}"

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

PIDS=()

for i in {1..30}
do
    # Call the function to check job limits
    wait_for_jobs

    (
    AWS_BUCKET_KEY_NAME="statefile_${i}.tfstate"
    export TF_VAR_student_number="student-${i}"

    WORK_DIR="${PARENT_FOLDER}/workdir_${i}"
    mkdir -p "${WORK_DIR}"

    # Copy Terraform configuration files and .terraform.lock.hcl into the working directory
    cp -r "${TERRAFORM_CONFIG_DIR}/." "${WORK_DIR}/"

    cd "${WORK_DIR}"

    echo "Running terraform init and destroy for iteration ${i}"

    INIT_LOG="../../${LOG_DIR}/terraform_init_destroy_student_${i}.log"
    DESTROY_LOG="../../${LOG_DIR}/terraform_destroy_student_${i}.log"

    echo "Initializing Terraform for student number ${i}..."
    terraform init \
        -backend-config="bucket=${AWS_BUCKET_NAME}" \
        -backend-config="key=${AWS_BUCKET_KEY_NAME}" \
        -backend-config="region=${AWS_REGION}" \
        -backend-config="dynamodb_table=${AWS_DYNAMODB_TABLE}" \
        -reconfigure \
        > "${INIT_LOG}" 2>&1

    if [ $? -ne 0 ]; then
        echo "Error: Terraform init failed for student number ${i}. Check log: ${INIT_LOG}"
        exit 1
    fi
 
    echo "Destroying Terraform-managed infrastructure for student number ${i}..."
    terraform destroy -auto-approve -input=false \
        > "${DESTROY_LOG}" 2>&1

    if [ $? -ne 0 ]; then
        echo "Error: Terraform destroy failed for student number ${i}. Check log: ${DESTROY_LOG}"
        exit 1
    fi

    unset TF_VAR_student_number

    echo "Completed Terraform destroy for student number ${i}."

    cd ../../

    # Clean up the generated directory
    rm -rf "${WORK_DIR}"

    ) &

    PIDS+=($!)
done

# Wait for all background jobs to finish
FAIL=0
for pid in "${PIDS[@]}"; do
    wait $pid || ((FAIL++))
done

if [ "$FAIL" -ne 0 ]; then
    echo "$FAIL background job(s) failed during destroy."
else
    echo "All destroy operations completed successfully."
fi
