# Modules
module "iam" {
  source = "./iam"
}

module "vpc" {
  source = "./vpc"
}

module "ec2" {
  source = "./ec2"

  depends_on = [
    module.iam,
    module.vpc
  ]
}

# EC2 instance
resource "aws_instance" "web_server" {
  ami           = module.ec2.ami_name.id
  key_name      = var.key_name
  instance_type = "t2.micro"
  user_data = "${file("./provisioner.sh")}"

  iam_instance_profile   = module.iam.ec2_profile
  subnet_id              = module.vpc.public_subnet
  vpc_security_group_ids = [module.vpc.firewall]

  tags = {
    Name = "Campus-JH-${var.environment}"
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file(var.key_name)
  }
}

# Outputs
output "public_dns" {
  value = aws_instance.web_server.*.public_dns
}
output "public_ip" {
  value = aws_instance.web_server.*.public_ip
}