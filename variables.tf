variable "region" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "environment" {
  type = string
}

variable "key_name" {
  type = string
}

variable "public_key" {
  type = string
}

variable "availability_zone" {
  type = list(string)
}

variable "db_instance" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "db_name" {
  type = string
}

# variable "vpc_id" {}