#Elastic IP for NAT Gateway#

resource "aws_eip" "nat_gw1_eip" {
    domain = "vpc"
    tags = {
      Name = "nat_gw1_eip"
    }
}

resource "aws_eip" "nat_gw2_eip" {
    domain = "vpc"
    tags = {
      Name = "nat_gw2_eip"
    }
}

#NAT Gateway for the private subnet#
resource "aws_nat_gateway" "nat_gw_1" {
    allocation_id = aws_eip.nat_gw1_eip.id
    subnet_id = aws_subnet.wt_pubs_1.id
    tags = {
      Name = "main_vpc_nat_gw_1"
    }
}

resource "aws_nat_gateway" "nat_gw_2" {
    allocation_id = aws_eip.nat_gw2_eip.id
    subnet_id = aws_subnet.wt_pubs_2.id
    tags = {
      Name = "main_vpc_nat_gw_2"
    }
}


