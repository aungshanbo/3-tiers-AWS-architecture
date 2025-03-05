variable "region" {
  type = string
  default = "us-east-1"
}

variable "main_vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "WT_pubs_1_cidr" {
  type = string
  default = "10.0.0.0/20"
}

variable "WT_pubs_2_cidr" {
  type = string
  default = "10.0.16.0/20"
}

variable "APPT_pris_1_cidr" {
  type = string
  default = "10.0.128.0/20"
}

variable "APPT_pris_2_cidr" {
  type = string
  default = "10.0.144.0/20"
}

variable "DBT_pris_1_cidr" {
  type = string
  default = "10.0.160.0/20"
}

variable "DBT_pris_2_cidr" {
  type = string
  default = "10.0.176.0/20"
}

variable "az_1" {
  type = string
  default = "us-east-1a"
}

variable "az_2" {
  type = string
  default = "us-east-1b"
}


variable "ssh_key_name" {
  type = string
  default = "server_ssh_key"
}

variable "web_security_group" {
  type = string
  default = "web_tier_sg"
}

variable "app_security_group" {
  type = string
  default = "app_tier_sg"
}

variable "db_security_group" {
  type = string
  default = "db_tier_sg"
}

variable "web_server_lt" {
  type = string
  default = "web_server_lt-"
}

variable "app_server_lt" {
  type = string
  default = "app_server_lt-"
}

variable "server_ami" {
  type = string
  default = "ami-04b4f1a9cf54c11d0"
}

variable "server_instance_type" {
  type = string
  default = "t2.nano"
}

variable "db_identifier" {
  type = string
  default = "web-app-db"
}

variable "db_storage_type" {
  type = string
  default = "gp2"
}

variable "db_size" {
  type = number
  default = 20
}

variable "db_type" {
  type = string
  default = "mysql"
}

variable "db_version" {
  type = string
  default = "8.0"
}

variable "db_instance_class" {
  type = string
  default = "db.t3.micro"
}

variable "db_username" {
  type = string
  default = "admin"
}

variable "db_password" {
  type = string
  default = "admin123123"
}

