# AWS EC2 - Virtual Machine (VM)
resource "aws_instance" "aws_ec2" {
  ami           = var.aws_instance_ami
  instance_type = var.aws_instance_type

  vpc_security_group_ids = [aws_security_group.allow_ec2.id]
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.subnet_devops.id

  key_name = aws_key_pair.ec2_key_pair.key_name

  tags = {
    Name = var.aws_instance_name
  }
}

resource "aws_key_pair" "ec2_key_pair" {
  key_name = var.key_pair
  public_key = file(var.ssh_key_path)
}