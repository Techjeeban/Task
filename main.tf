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

module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
}

module "subnet" {
  source                  = "./modules/subnet"
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

module "internet_gateway" {
  source = "./modules/internet_gateway"
  vpc_id = module.vpc.vpc_id
}

module "route_table" {
  source     = "./modules/route_table"
  vpc_id     = module.vpc.vpc_id
  gateway_id = module.internet_gateway.igw_id
}

module "route_table_association" {
  source         = "./modules/route_table_association"
  subnet_id      = module.subnet.subnet_id
  route_table_id = module.route_table.rt_id
}

module "ec2" {
  source                     = "./modules/ec2"
  ami                        = "ami-0c50b6f7dc3701ddd"
  instance_type              = "t2.micro"
  subnet_id                  = module.subnet.subnet_id
  key_name                   = "taskkey"
  associate_public_ip_address = true
  instance_name              = "TerraformTask"
}
