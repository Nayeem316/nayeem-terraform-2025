# RDS instance with default PostgreSQL version
resource "aws_db_instance" "hr" {
  identifier             = "hr-database-1"
  allocated_storage      = 20
  instance_class         = "db.t3.medium"

  engine                 = "postgres"
  # engine_version omitted → AWS will pick the default for PostgreSQL

  db_subnet_group_name   = aws_db_subnet_group.rds_hybrid.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  multi_az               = true
  publicly_accessible    = false

  storage_encrypted       = true
  backup_retention_period = 7
  skip_final_snapshot     = false

  username = var.db_username
  password = var.db_password

  tags = merge(local.common_tags, { Name = "hr-database-1" })
}
