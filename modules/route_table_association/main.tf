resource "aws_route_table_association" "rta" {
  subnet_id      = var.subnet_id
  route_table_id = var.route_table_id
}

output "rta_id" {
  value = aws_route_table_association.rta.id
}
