resource "aws_security_group" "rds_sg" {
  name        = "rds_hybrid_sg"
  description = "Allow access to RDS from approved public IPs / networks"
  vpc_id      = aws_vpc.rds_hybrid_vpc.id

  ingress {
    description = "PostgreSQL access from allowed CIDR"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.public_db_allowed_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, { Name = "rds_hybrid_sg" })
}
