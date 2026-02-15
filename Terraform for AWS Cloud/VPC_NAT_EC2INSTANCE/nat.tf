# Define External IP
resource "aws_eip" "custom-nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "custom-nat-gw" {
  allocation_id = aws_eip.custom-nat.id

  subnet_id  = aws_subnet.custom_vpc-public-1.id
  depends_on = [aws_internet_gateway.custom_vpc-gw]
}


resource "aws_route_table" "custom-private" {
  vpc_id = aws_vpc.custom_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.custom-nat-gw.id
  }

  tags = {
    Name = "custom-private"
  }
}

resource "aws_route_table_association" "custom_private-1-a" {
  subnet_id      = aws_subnet.custom_vpc-private-1.id
  route_table_id = aws_route_table.custom-private.id

}
resource "aws_route_table_association" "custom_private-1-b" {
  subnet_id      = aws_subnet.custom_vpc-private-2.id
  route_table_id = aws_route_table.custom-private.id

}
resource "aws_route_table_association" "custom_private-1-c" {
  subnet_id      = aws_subnet.custom_vpc-private-3.id
  route_table_id = aws_route_table.custom-private.id

}
