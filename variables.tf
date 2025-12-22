variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "db_username" {
  description = "Master username for the RDS instance"
  type        = string
  default     = "hr_admin"  # Can override per environment
}

variable "db_password" {
  description = "Master password for the RDS instance"
  type        = string
  sensitive   = true
}
