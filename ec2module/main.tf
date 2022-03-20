locals {
  cars = ["maruti","nissan","fiat"]
}

resource "aws_instance" "ec2instance" {
  ami                         = data.aws_ami.myamiid.id
  instance_type               = var.instancetype
  subnet_id                   = data.aws_subnet.mysubnet.id
  associate_public_ip_address = var.publicip
  availability_zone           = var.az
  tags                        = var.tag
  vpc_security_group_ids      = var.securitygroups

}


data "aws_ami" "myamiid" {
  owners = ["amazon"]
  filter {
    name   = "name"
    values = var.ami_name
  }
  filter {
    name   = "virtualization-type"
    values = var.virtualizationtype
  }
}

data "aws_subnet" "mysubnet" {
  availability_zone = var.az
  filter {
    name   = "vpc-id"
    values = [var.vpcid]
  }
}

