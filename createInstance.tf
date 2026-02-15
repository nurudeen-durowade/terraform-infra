resource "aws_instance" "MyFirstInstance" {
  count = 3
  ami = "ami-0156001f0548e90b1"
  instance_type = "t3.micro"

  tags = {
    "Name" = "demoinstance-${count.index}" 
  }
}

