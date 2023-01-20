module "iam"{
    source = "./modules/iam"
}

# module "dynamodb" {
#     source = "./module/dynamodb"
# }

module "ec2" {
    source = "./modules/ec2"
    # project_name = var.project_name
    # environment = var.environment
}

module "vpc" {
    source = "./modules/vpc"
}