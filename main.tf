module "iam"{
    source = "./module/iam"
}

# module "dynamodb" {
#     source = "./module/dynamodb"
# }

module "EC2" {
    source = "./module/ec2"
    # project_name = var.project_name
    # environment = var.environment
}