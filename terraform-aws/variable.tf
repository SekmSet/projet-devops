variable "location" {
  type = string
  description = "Location to deploy Ex: eu-west-3c"
}

variable "port" {
  type = number
  description = "Using PORT Ex: 8000"
}

variable "image_name" {
  type = string
  description = "Name of your image"
}

variable "tf_version" {
  type = string
  description = "Version Terraform that you are using"
}

variable "access_key" {
  type = string
  description = ""
}

variable "secret_key" {
  type = string
  description = ""
}

variable "aws_instance_ami" {
  type = string
  description = ""
  default = "ami-00ac45f3035ff009e"
}

variable "aws_instance_name" {
  type = string
  description = "Name for your Virtual Machine (VM) | AWS EC2"
}

variable "aws_instance_type" {
  type = string
  description = "Instance type for your Virtual Machine (VM) | AWS EC2"
  default = "t2.micro"
}

variable "my_ip" {
  type = string
  description = "[NETWORK] Security group with your IP for your Virtual Machine (VM) | AWS EC2"
  default = "88.182.24.73/32"
}

variable "key_pair" {
  type = string
  description = "Name of your key pair for your Virtual Machine (VM) | AWS EC2"
}

variable "ssh_key_path" {
  type = string
  description = "Path to your SSH key file (.pub)"
}

