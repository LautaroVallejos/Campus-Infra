# IAM Settings
resource "aws_iam_user" "user" {
  name = "Campus-Admin"
}

# Role
resource "aws_iam_role" "role" {
  name = "Campus-Admin-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    description = "role for Campus JH"
  }
}

# Group
resource "aws_iam_group" "group" {
  name = "Campus-Master"
}

# Policy
resource "aws_iam_policy" "policy" {
  name        = "campus-admin-policy"
  description = "Campus JH policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:DescribeTable",
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:DeleteItem",
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

# Policy Attachment
resource "aws_iam_policy_attachment" "campus-attach" {
  name       = "campus-admin-attachment"
  users      = [aws_iam_user.user.name]
  roles      = [aws_iam_role.role.name]
  groups     = [aws_iam_group.group.name]
  policy_arn = aws_iam_policy.policy.arn
}

# Profile for EC2 instance
resource "aws_iam_instance_profile" "ec2_role" {
    name = "ec2-campus-master"
    role = aws_iam_role.role.name
}
