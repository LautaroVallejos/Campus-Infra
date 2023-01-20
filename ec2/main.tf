# Modules Import
module "iam" {
  source = "../iam"
}

module "vpc" {
  source = "../vpc"
}


# AMI data
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}



# EC2 instance
resource "aws_instance" "web_server" {
  ami           = data.aws_ami.ubuntu.id
  key_name      = var.key_name
  instance_type = "t2.micro"

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

  #   # NGINX Installation
  #   provisioner "remote-exec" {
  #     inline = [
  #       "sudo apt -y update",
  #       "sudo apt -y install nginx",
  #       "sudo systemctl start nginx"
  #     ]
  #   }

}

# Key Pair SSH Connection
resource "aws_key_pair" "secret_key" {
  key_name   = var.key_name
  public_key = file(var.public_key)
}

# Outputs
output "public_dns" {
  value = aws_instance.web_server.*.public_dns
}
output "public_ip" {
  value = aws_instance.web_server.*.public_ip
}
