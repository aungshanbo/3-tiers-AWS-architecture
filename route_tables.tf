# Public Route Table#

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.main_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
      Name = "public_default_route_table"
    }
}

# Private Route Table #

resource "aws_route_table" "private_rt_az1" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_1.id
  }
  tags = {
    Name = "private_default_route_table_az1"
  }
}

resource "aws_route_table" "private_rt_az2" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_2.id
  }
  tags = {
    Name = "private_default_route_table_az2"
  }
}


# associate public subnet with public route table #

resource "aws_route_table_association" "wt_pubs_1" {
  subnet_id = aws_subnet.wt_pubs_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "wt_pubs_2" {
  subnet_id = aws_subnet.wt_pubs_2.id
  route_table_id = aws_route_table.public_rt.id
}


#associate private subnet with private route table #

resource "aws_route_table_association" "appt_pris_1_rt1" {
  subnet_id = aws_subnet.appt_pris_1.id
  route_table_id = aws_route_table.private_rt_az1.id
}

resource "aws_route_table_association" "appt_pris_2_rt2" {
  subnet_id = aws_subnet.appt_pris_2.id
  route_table_id = aws_route_table.private_rt_az2.id
}

resource "aws_route_table_association" "dbt_pris_1_rt1" {
  subnet_id = aws_subnet.dbt_pris_1.id
  route_table_id = aws_route_table.private_rt_az1.id 
}

resource "aws_route_table_association" "dbt_pris_2_rt1" {
  subnet_id = aws_subnet.dbt_pris_2.id
  route_table_id = aws_route_table.private_rt_az2.id 
}

