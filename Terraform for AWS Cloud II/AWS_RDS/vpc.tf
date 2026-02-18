#Create AWS VPC
resource "aws_vpc" "custom_vpc" {
  cidr_block                           = "10.0.0.0/16"
  instance_tenancy                     = "default"
  enable_dns_support                   = true
  enable_dns_hostnames                 = true
  enable_network_address_usage_metrics = false

  tags = {
    Name = "custom_vpc"
  }
}

#Create Public Subnets in Custom VPC

resource "aws_subnet" "custom_vpc-public-1" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "custom_vpc-public-1"
  }
}

resource "aws_subnet" "custom_vpc-public-2" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name = "custom_vpc-public-2"
  }
}

resource "aws_subnet" "custom_vpc-public-3" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1c"

  tags = {
    Name = "custom_vpc-public-3"
  }
}


#Create Private Subnets in Custom VPC

resource "aws_subnet" "custom_vpc-private-1" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"

  tags = {
    Name = "custom_vpc-private-1"
  }
}

resource "aws_subnet" "custom_vpc-private-2" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1b"

  tags = {
    Name = "custom_vpc-private-2"
  }
}

resource "aws_subnet" "custom_vpc-private-3" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1c"

  tags = {
    Name = "custom_vpc-private-3"
  }
}

# custom internet gateway


resource "aws_internet_gateway" "custom_vpc-gw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "custom_vpc-gw"
  }
}


#Route table for Custom VPC

resource "aws_route_table" "custom-public" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.custom_vpc-gw.id
  }



  tags = {
    Name = "custom-public"
  }
}

# Associate a subnet to the Route Table

resource "aws_route_table_association" "custom_public-1-a" {
  subnet_id      = aws_subnet.custom_vpc-public-1.id
  route_table_id = aws_route_table.custom-public.id

}
resource "aws_route_table_association" "custom_public-2-a" {
  subnet_id      = aws_subnet.custom_vpc-public-2.id
  route_table_id = aws_route_table.custom-public.id

}
resource "aws_route_table_association" "custom_public-3-a" {
  subnet_id      = aws_subnet.custom_vpc-public-3.id
  route_table_id = aws_route_table.custom-public.id

}
