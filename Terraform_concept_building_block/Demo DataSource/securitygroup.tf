data "aws_ip_ranges" "useast_ip_range" {

  regions  = ["us-east-1", "us-east-2"]
  services = ["ec2"]

}

data "aws_prefix_list" "s3" {
  name = "com.amazonaws.us-east-1.s3"
}

resource "aws_security_group" "custom-us-east-sg" {
  name        = "custom-us-east-sg"
  description = "Custom Security Group"

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    prefix_list_ids = [data.aws_prefix_list.s3.id]
  }

  tags = {
    CreateDate = data.aws_ip_ranges.useast_ip_range.create_date
    SyncToken  = data.aws_ip_ranges.useast_ip_range.sync_token

  }
}
