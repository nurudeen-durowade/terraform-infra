resource "aws_key_pair" "levelup_key" {
  key_name   = "levelup_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}


# Create AWS Instance

resource "aws_instance" "JumpboxInstance" {
  ami                    = lookup(var.AMIS, var.AWS_REGION)
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.levelup_key.key_name
  vpc_security_group_ids = [aws_security_group.allow_custom-vpc-ssh.id]
  subnet_id              = aws_subnet.custom_vpc-public-1.id
  availability_zone      = aws_subnet.custom_vpc-public-1.availability_zone



  tags = {
    Name = "jumpbox_instance"
  }


}

output "public_ip" {
  value = aws_instance.JumpboxInstance.public_ip
}


