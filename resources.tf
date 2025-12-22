# Fetch AWS caller identity
data "aws_caller_identity" "current" {}

locals {
  # Extract IAM username from ARN
  created_by = element(
    split("/", data.aws_caller_identity.current.arn),
    length(split("/", data.aws_caller_identity.current.arn)) - 1
  )

  # UTC timestamp of resource creation

  created_on = timestamp()


  common_tags = {
    created-by = local.created_by
    created-on = local.created_on
    region     = "us-east-2"
  }
}


# Dev VPC
resource "aws_vpc" "dev_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    { Name = "dev-vpc" },
    local.common_tags
  )
}

# Dev Subnet 1
resource "aws_subnet" "dev_subnet_1" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-2a"

  tags = merge(
    { Name = "dev-subnet-1" },
    local.common_tags
  )
}

# Dev Subnet 2
resource "aws_subnet" "dev_subnet_2" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-2b"

  tags = merge(
    { Name = "dev-subnet-2" },
    local.common_tags
  )
}
