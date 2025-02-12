resource "aws_route_table" "rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id
  }
}

output "rt_id" {
  value = aws_route_table.rt.id
}
