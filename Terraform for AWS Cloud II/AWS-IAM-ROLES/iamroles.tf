
#Roles to access the AWS S3 Bucket

#This role is for EC2 machines only.

resource "aws_iam_role" "s3-apiboxbucket-role" {

  name = "s3-apiboxbucket-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}


#Policy to attach the S3 Bucket Role

# What can this role actually do? 

# EC2 can do anything inside the bucket apibox_bucket-555.

resource "aws_iam_role_policy" "s3-apiboxbucket-role-policy" {
  name   = "s3-apiboxbucket-role-policy"
  role   = aws_iam_role.s3-apiboxbucket-role.id
  policy = <<EOF
  {
  
        "Version": "2012-10-17",
        "Statement": [
                
                {
                "Effect":"Allow",
                "Action": [
                    "s3:*"
                
                ],
                "Resource": [
                    "arn:aws:s3:::apibox_bucket-555",
                    "arn:aws:s3:::apibox_bucket-555/*"
                ]               
                
                }
        
        ]        
  
  }

  
EOF


}


#Instance Identifier

#  An EC2 machine cannot directly use a role.

#  Without instance profile → EC2 cannot receive the permission.

resource "aws_iam_instance_profile" "s3-apiboxbucket-role-instanceprofile" {
  name = "s3-apiboxbox-role"

  role = aws_iam_role.s3-apiboxbucket-role.name
}
