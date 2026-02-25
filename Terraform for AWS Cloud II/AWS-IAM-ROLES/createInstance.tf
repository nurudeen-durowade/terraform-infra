resource "aws_key_pair" "levelup_key" {
  key_name   = "levelup_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}


# Create AWS Instance

resource "aws_instance" "JumpboxInstance" {
  ami                  = lookup(var.AMIS, var.AWS_REGION)
  instance_type        = "t3.micro"
  key_name             = aws_key_pair.levelup_key.key_name
  availability_zone    = aws_subnet.custom_vpc-public-1.availability_zone
  iam_instance_profile = aws_iam_instance_profile.s3-apiboxbucket-role-instanceprofile.name


  tags = {
    Name = "jumpbox_instance"
  }


}

output "public_ip" {
  value = aws_instance.JumpboxInstance.public_ip
}


