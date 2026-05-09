data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["talium-vpc-dev"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
  filter {
    name   = "tag:Tier"
    values = ["private"]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
  filter {
    name   = "tag:Tier"
    values = ["public"]
  }
}
