variable "vpc_id" {
  description = "The ID of the VPC"
}

variable "cidr_block" {
  description = "The CIDR block for the subnet"
  default     = "10.0.1.0/24"
}

variable "map_public_ip_on_launch" {
  description = "Map public IP on launch"
  default     = true
}
