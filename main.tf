# Modules
module "iam" {
  source = "./iam"

  environment = var.environment
}

module "vpc" {
  source = "./vpc"

  environment = var.environment
  availability_zone = var.availability_zone
}

module "ec2" {
  source = "./ec2"

  key_name = var.key_name
  public_key = var.public_key

  depends_on = [
    module.iam,
    module.vpc
  ]
}

# EC2 instance
resource "aws_instance" "web_server" {
  ami           = module.ec2.ami_name.id
  key_name      = var.key_name
  instance_type = var.instance_type

  iam_instance_profile   = module.iam.ec2_profile
  subnet_id              = module.vpc.public_subnet
  vpc_security_group_ids = [module.vpc.firewall]

  tags = {
    Name = "Campus-JH-${var.environment}"
  }

  provisioner "file" {
    source      = "./install_nginx.sh"
    destination = "/tmp/install_nginx.sh"

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file(var.key_name)
    }
  }
  provisioner "file" {
    source      = "./main_script_1.sh"
    destination = "/tmp/main_script_1.sh"

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file(var.key_name)
    }
  }
  provisioner "file" {
    source = "./install_docker.sh"
    destination = "/tmp/install_docker.sh"

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file(var.key_name)
    }
  }

  provisioner "file" {
    source = "./install_jekins.sh"
    destination = "/tmp/install_jenkins.sh"

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file(var.key_name)
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/main_script_1.sh",
      "chmod +x /tmp/install_docker.sh",
      "chmod +x /tmp/install_nginx.sh",
      "chmod +x /tmp/install_jenkins.sh",
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file(var.key_name)
    }
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