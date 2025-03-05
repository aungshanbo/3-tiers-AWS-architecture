resource "aws_db_instance" "database" {
    identifier = var.db_identifier
    allocated_storage = var.db_size
    storage_type = var.db_storage_type
    engine = var.db_type
    engine_version = var.db_version
    instance_class = var.db_instance_class
    username = var.db_username
    password = var.db_password
    parameter_group_name = "default.mysql8.0"
    db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
    vpc_security_group_ids = [aws_security_group.db_tier_sg.id]
    publicly_accessible = false 
    multi_az = false # Please change true for HA mode in production
    skip_final_snapshot = true 

    tags = {
      Name = "web_app_db"
    }
}