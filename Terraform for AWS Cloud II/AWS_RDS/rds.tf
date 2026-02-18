#RDS Resources

# RDS requires at least 2 subnets in different AZs.

resource "aws_db_subnet_group" "mariadb-subnets" {
  name        = "mariadb-subnet"
  description = "Amazon RDS Subnte group"
  subnet_ids  = [aws_subnet.custom_vpc-private-1.id, aws_subnet.custom_vpc-private-2.id]
}

resource "aws_db_parameter_group" "custom-mariadb-parameters" {
  name        = "custom-mariadb-parameters"
  family      = "mariadb10.6"
  description = "MariaDB parameter group"

  parameter {
    name  = "max_connections"
    value = "200"
  }

  parameter {

    name  = "max_allowed_packet"
    value = "16777216"

  }

  parameter {
    name  = "slow_query_log"
    value = "1"
  }

  parameter {
    name  = "long_query_time"
    value = "2"
  }

}



resource "aws_db_instance" "custom-mariadb" {
  allocated_storage       = 20
  engine                  = "mariadb"
  engine_version          = "10.4.8"
  instance_class          = "db.t3.micro"
  identifier              = "mariadb"
  username                = "root"
  password                = "mariadb141"
  db_subnet_group_name    = aws_db_subnet_group.mariadb-subnets.name
  parameter_group_name    = aws_db_parameter_group.custom-mariadb-parameters.name
  multi_az                = false
  vpc_security_group_ids  = [aws_security_group.allow_mariadb.id]
  storage_type            = "gp2"
  backup_retention_period = 30
  availability_zone       = aws_subnet.custom_vpc-private-1.availability_zone
  skip_final_snapshot     = true

  tags = {
    Name = "custom-mariadb"
  }

}


output "rds" {
  value = aws_db_instance.custom-mariadb.endpoint
}
