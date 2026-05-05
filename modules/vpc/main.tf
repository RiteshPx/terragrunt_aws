terraform {
  backend "s3" {}
}

resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags = { Name = "Terragrunt-VPC" }
}

# Public Subnet
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.this.id
  cidr_block = var.public_subnet
  map_public_ip_on_launch = true
  availability_zone = var.az
}

# Private Subnet
resource "aws_subnet" "private" {
  vpc_id = aws_vpc.this.id
  cidr_block = var.private_subnet
  availability_zone = var.az
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
}

# Route Table (Public)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# Associate public subnet
resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}