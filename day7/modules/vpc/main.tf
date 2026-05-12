// modules/vpc/main.tf

############################################
# VPC
############################################

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(var.tags, {
    Name        = "${var.project_name}-${var.environment}-vpc"
    Environment = var.environment
  })
}

############################################
# Internet Gateway
############################################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-igw"
  })
}

############################################
# Public Subnets
############################################

resource "aws_subnet" "public" {
  for_each = toset(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  availability_zone       = var.azs[index(var.public_subnet_cidrs, each.value)]
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-public-${each.key}"
  })
}

############################################
# Private App Subnets
############################################

resource "aws_subnet" "private_app" {
  for_each = toset(var.private_app_subnet_cidrs)

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = var.azs[index(var.private_app_subnet_cidrs, each.value)]

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-private-app-${each.key}"
  })
}

############################################
# Private DB Subnets
############################################

resource "aws_subnet" "private_db" {
  for_each = toset(var.private_db_subnet_cidrs)

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = var.azs[index(var.private_db_subnet_cidrs, each.value)]

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-private-db-${each.key}"
  })
}

############################################
# NAT Gateway (one per AZ)
############################################

resource "aws_eip" "nat" {
  count = var.enable_nat_gateway ? length(var.azs) : 0

  vpc = true

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-nat-eip-${count.index}"
  })
}

resource "aws_nat_gateway" "nat" {
  count = var.enable_nat_gateway ? length(var.azs) : 0

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = element(values(aws_subnet.public), count.index).id

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-nat-${count.index}"
  })
}

############################################
# Route Tables
############################################

# Public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-public-rt"
  })
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_assoc" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# Private app route tables (NAT)
resource "aws_route_table" "private_app" {
  for_each = aws_subnet.private_app

  vpc_id = aws_vpc.main.id

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-private-app-rt-${each.key}"
  })
}

resource "aws_route" "private_app_nat" {
  for_each = aws_route_table.private_app

  route_table_id         = each.value.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.nat[*].id, index(keys(aws_route_table.private_app), each.key))
}

resource "aws_route_table_association" "private_app_assoc" {
  for_each = aws_subnet.private_app

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_app[each.key].id
}

############################################
# DB Subnet Group
############################################

resource "aws_db_subnet_group" "db" {
  name       = "${var.project_name}-${var.environment}-db-subnet-group"
  subnet_ids = [for s in aws_subnet.private_db : s.id]

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-db-subnet-group"
  })
}

