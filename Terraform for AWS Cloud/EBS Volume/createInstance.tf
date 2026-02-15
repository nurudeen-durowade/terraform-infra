locals {
  path_to_public_key = "${path.module}/custom_vpc_key.pub"
}
resource "aws_key_pair" "custom_vpc_key" {
  key_name   = "custom_vpc_key"
  public_key = file(local.path_to_public_key)
}


# Create AWS Instance

resource "aws_instance" "StagingIstance" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t3.micro"
  key_name      = aws_key_pair.custom_vpc_key.key_name



  tags = {
    Name = "staging_instance"
  }


}

#EBS resource creation

resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = "us-east-1a"
  size              = 50
  type              = "gp2"
  tags = {
    Name = "Secondary Volume Disk"
  }
}


#Attach EBS volume with AWS Instance

resource "aws_volume_attachment" "ebs-volume-1-attachment" {

  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.ebs-volume-1.id
  instance_id = aws_instance.StagingIstance.id

}
