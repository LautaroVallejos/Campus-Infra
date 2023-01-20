# module "iam"{
#     source = "./iam"

# }

# module "dynamodb" {
#     source = "./module/dynamodb"
# }

module "ec2" {
  source = "./ec2"

  # iam_instance_profile = module.iam.ec2

  # aws_iam_instance_profile = module.iam.ec2_profile
  # iam_instance_profile = module.iam.ec2_profile
  # firewall = modules.vpc.aws_security_group.firewall.id
  # subnet  = modules.vpc.aws_subnet.public_subnet.id

  # depends_on = [
  #   module.iam,
  #   module.vpc
  # ]
}

# module "vpc" {
#     source = "./vpc"
# }