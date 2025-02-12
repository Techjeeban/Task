variable "ami" {
  description = "The AMI ID for the EC2 instance"
  default     = "ami-0c50b6f7dc3701ddd"
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "The ID of the subnet"
}

variable "key_name" {
  description = "The key name for the EC2 instance"
  default     = "taskkey"
}

variable "associate_public_ip_address" {
  description = "Associate public IP address"
  default     = true
}

variable "instance_name" {
  description = "The name of the EC2 instance"
  default     = "TerraformTask"
}
