resource "aws_security_group" "allow_custom-vpc-ssh" {
  name        = "allow_custom-vpc-ssh"
  description = "security group that allows ssh connections"
  vpc_id      = aws_vpc.custom_vpc.id

  tags = {
    Name = "allow_custom-vpc-ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_custom-vpc-ssh_ipv4" {
  security_group_id = aws_security_group.allow_custom-vpc-ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}



resource "aws_vpc_security_group_egress_rule" "allow_custom-vpc-ssh_ipv4" {
  security_group_id = aws_security_group.allow_custom-vpc-ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

}


