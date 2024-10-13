# note: k8s tags are necessary for k8s to manage the subnets
# format: kubernetes.io/role/{role-name} (elb, internal-elb, etc)
# format: kubernetes.io/cluster/{cluster-name} (owned, shared, etc)
# owned means the k8s has full control over the subnet
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-southeast-1a"
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 4, 1)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.prefix}-public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-southeast-1b"
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 4, 2)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.prefix}-public-subnet-2"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-southeast-1a"
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 4, 3)
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.prefix}-private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-southeast-1b"
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 4, 4)
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.prefix}-private-subnet-2"
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name = "db-subnet-group"
  subnet_ids = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id
  ]

  tags = {
    Name = "db-subnet-group"
  }
}
