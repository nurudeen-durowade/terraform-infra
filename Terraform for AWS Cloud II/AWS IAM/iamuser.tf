resource "aws_iam_user" "adminuser1" {
  name = "adminuser1"

}


resource "aws_iam_user" "adminuser2" {
  name = "adminuser2"

}


#IAM Group TF Definition

resource "aws_iam_group" "admingroup" {
  name = "admingroup"

}


#Assign User to AWS Group


resource "aws_iam_group_membership" "admin-users" {

  name = "admin-users"

  users = [
    aws_iam_user.adminuser1.name,
    aws_iam_user.adminuser2.name
  ]
  group = aws_iam_group.admingroup.name

}

# Policy for AWS Group

resource "aws_iam_policy_attachment" "admin-user-policy" {
  name   = "admin-user-policy"
  groups = [aws_iam_group.admingroup.name]
  # I am defining administrator access on this particular group
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"

}
