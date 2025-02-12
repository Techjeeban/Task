terraform {
  backend "s3" {
    bucket = "taskbucket0956"
    key    = "statefile/terraform.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  region = "ap-south-1"
}
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true # Ensure instances in this subnet get a public IP
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.rt.id
}
resource "aws_instance" "web" {
  ami                         = "ami-0c50b6f7dc3701ddd"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet.id
  key_name                    = "taskkey"
  associate_public_ip_address = true # Ensure the instance gets a public IP

  tags = {
    Name = "TerraformTask"
  }
}
