resource "aws_eip" "nat" {
  domain = "vpc"
  tags = {
    Name = "${var.prefix}-nat"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "${var.prefix}-nat"
  }

  depends_on = [
    aws_internet_gateway.igw]
}

