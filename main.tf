/*terraform {
  cloud {
    organization = "roshanorg"

    workspaces {
      name = "gitactions-demo"
    }
  }
}*/

provider "aws" {
  region     = var.region
  access_key = var.accesskey
  secret_key = var.secretkey
}

variable "accesskey" {
  type = string
}
variable "secretkey" {
  type = string
}
variable "region" {
  type    = string
  default = "us-east-1"
}
variable "instance_count" {
  type    = number
  default = 1
}

variable "ingressrule" {
  type = list(map(string))
  default = [
    {
      fromport  = "80"
      toport    = "80"
      protocol  = "tcp"
      cidrblock = "0.0.0.0/0"
    },
    {
      fromport  = "8080"
      toport    = "8080"
      protocol  = "tcp"
      cidrblock = "0.0.0.0/0"
    }
  ]
}

variable "egressrule" {
  type = list(map(string))
  default = [
    {
      fromport  = "0"
      toport    = "0"
      protocol  = "-1"
      cidrblock = "0.0.0.0/0"
    }
  ]
}

variable "vpcid" {
  type        = string
  default     = "vpc-565d352b"
  description = "VPC ID where the resources needs to be provisioned"
}
variable "tag" {
  type = map(string)
  default = {
    "Name" = "Terraform Demo"
  }
  description = "Tag values for instances"
}

module "ec2instance" {
  count          = var.instance_count
  source         = "./ec2module"
  accesskey      = var.accesskey
  secretkey      = var.secretkey
  securitygroups = ["${aws_security_group.mysecuritygroup.id}"]
}

resource "aws_security_group" "mysecuritygroup" {
  description = "MysecurityGroup"
  tags        = var.tag
  vpc_id      = var.vpcid
  dynamic "ingress" {
    for_each = var.ingressrule
    content {
      from_port   = ingress.value.fromport
      to_port     = ingress.value.toport
      cidr_blocks = [ingress.value.cidrblock]
      protocol    = ingress.value.protocol
    }
  }

  dynamic "egress" {
    for_each = var.egressrule
    content {
      from_port   = egress.value.fromport
      to_port     = egress.value.toport
      cidr_blocks = [egress.value.cidrblock]
      protocol    = egress.value.protocol
    }
  }

}

output "public_ip" {
  value = module.ec2instance.*.publicip
}
