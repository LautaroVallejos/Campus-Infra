output "user" {
    value = aws_iam_user.user.name
}

output "role" {
    value = aws_iam_role.role.name
}

output "group" {
    value = aws_iam_group.group.name
}

output "ec2_profile" {
    value = aws_iam_instance_profile.ec2_role.name
}