resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_support   = true
    enable_dns_hostnames = true
    tags = {
        Name = "main"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
}

# Publics subnets
resource "aws_subnet" "public" {
    count = length(var.public_cidr)
    vpc_id = aws_vpc.vpc.id
    cidr_block =  element(var.public_cidr,count.index)
    availability_zone = element(var.azs,count.index)
    map_public_ip_on_launch = true

  tags = {
    Name = "Subnet-public-${count.index+1}"
  }

}

# Private subnets
resource "aws_subnet" "private" {
    count = length(var.private_cidr)
    vpc_id = aws_vpc.vpc.id
    cidr_block =  element(var.private_cidr,count.index)
    availability_zone = element(var.azs,count.index)
    map_public_ip_on_launch = true

  tags = {
    Name = "Subnet-private-${count.index+1}"
  }

}

# Public route table
resource "aws_route_table" "public-rt" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "Public route table"
    }
}

# Public Route Table association
resource "aws_route_table_association" "public" {
    count = length(var.public_cidr)
    subnet_id = element(aws_subnet.public.*.id,count.index)
    route_table_id = aws_route_table.public-rt.id
}

# create elastic IP (EIP) to assign it the NAT Gateway 
resource "aws_eip" "eip" {
  vpc      = true
}

# create NAT Gateway
resource "aws_nat_gateway" "nat_gw" {
    allocation_id = aws_eip.eip.id
    subnet_id = aws_subnet.public.0.id
    
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.vpc.id

  route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.nat_gw.id
  } 

  tags = { 
    Name = "private_subnet_route_table"
  }
}

resource "aws_route_table_association" "private-rt" {
    count = length(var.private_cidr)
    subnet_id = element(aws_subnet.private.*.id,count.index)
    route_table_id = aws_route_table.private-rt.id
}