resource "aws_security_group" "rds_sg" {
  name        = "rds_hybrid_sg"
  description = "Allow access to RDS from app servers"
  vpc_id      = aws_vpc.rds_hybrid_vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.10.0/24"] # Replace with your app subnet/IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, { Name = "rds_hybrid_sg" })
}
