## Public Subnet for web tier ##
resource "aws_subnet" "wt_pubs_1" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.WT_pubs_1_cidr
  availability_zone = var.az_1
  map_public_ip_on_launch = true
  tags = {
    Name = "web_tier_public_subnet_1"
  }
}

resource "aws_subnet" "wt_pubs_2" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.WT_pubs_2_cidr
  availability_zone = var.az_2
  map_public_ip_on_launch = true
  tags = {
    Name = "web_tier_public_subnet_2"
  }
}

## Private Subnet for application tier ##
resource "aws_subnet" "appt_pris_1" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.APPT_pris_1_cidr
  availability_zone = var.az_1
  tags = {
    Name = "app_tier_private_subnet_1"
  }
}

resource "aws_subnet" "appt_pris_2" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.APPT_pris_2_cidr
  availability_zone = var.az_2
  tags = {
    Name = "app_tier_private_subnet_2"
  }
}

## Private Subnet for the Database tier ##

resource "aws_subnet" "dbt_pris_1" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.DBT_pris_1_cidr
  availability_zone = var.az_1
  tags = {
    Name = "database_tier_private_subnet_1"
  }
}

resource "aws_subnet" "dbt_pris_2" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.DBT_pris_2_cidr
  availability_zone = var.az_2
  tags = {
    Name = "database_tier_private_subnet_2"
  }
}


## Subnet Group for Database Subnet ##

resource "aws_db_subnet_group" "db_subnet_group" {
  name = "database_subnet_group"
  subnet_ids = [aws_subnet.dbt_pris_1.id,aws_subnet.dbt_pris_2.id]
  tags = {
    Name = "database_subnet_group"
  }
  
}