# Elastic IP for NAT Gateway — static public IP
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.project_name}-nat-eip-${var.environment}"
  }

  depends_on = [data.aws_vpc.main]
}

# NAT Gateway — placed in first public subnet
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = data.aws_subnets.public.ids[0]

  tags = {
    Name = "${var.project_name}-nat-gw-${var.environment}"
  }

  depends_on = [aws_eip.nat]
}

# Add NAT Gateway route to private route table
resource "aws_route" "private_nat" {
  route_table_id         = data.aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}

# Read existing private route table
data "aws_route_table" "private" {
  filter {
    name   = "tag:Name"
    values = ["talium-private-rt-dev"]
  }
}
