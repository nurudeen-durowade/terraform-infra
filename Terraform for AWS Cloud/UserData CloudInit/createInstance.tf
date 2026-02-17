resource "aws_key_pair" "custom_vpc_key" {
  key_name   = "custom_vpc_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}


# Create AWS Instance

resource "aws_instance" "JumpboxInstance" {
  ami               = lookup(var.AMIS, var.AWS_REGION)
  instance_type     = "t3.micro"
  key_name          = aws_key_pair.custom_vpc_key.key_name
  availability_zone = "us-east-1c"

  user_data = data.template_cloudinit_config.install_apache_config.rendered


  tags = {
    Name = "jumpbox_instance"
  }


}

output "public_ip" {
  value = aws_instance.JumpboxInstance.public_ip
}


