resource "aws_key_pair" "custom_vpc_key" {
  key_name   = "custom_vpc_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "PhoenixInstance" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t3.micro"
  key_name      = aws_key_pair.custom_vpc_key.key_name

  vpc_security_group_ids = [aws_security_group.allow_custom-vpc-ssh.id]

  subnet_id = aws_subnet.custom_vpc-public-1.id



  tags = {
    Name = "phoenix_instance"
  }


}
