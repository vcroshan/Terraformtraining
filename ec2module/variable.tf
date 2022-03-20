/*variable "instance_count" {
  type        = number
  default     = 2
  description = "Number of Instances"
}*/

variable "ami_name" {
  type        = list(string)
  default     = ["amzn2-ami-kernel-5.10-hvm-2.0.20220218.3-x86_64-gp2"]
  description = "Name of the AMI given in AWS"
}
variable "virtualizationtype" {
  type        = list(string)
  default     = ["hvm"]
  description = "Type of Virtualization of the VM"
}
variable "instancetype" {
  type        = string
  default     = "t2.micro"
  description = "Instance type"
}
variable "publicip" {
  type        = bool
  default     = true
  description = "Assign Public IP to instances"

}

variable "az" {
  type        = string
  default     = "us-east-1a"
  description = "Availabilty zone of the instances"
}

variable "tag" {
  type = map(string)
  default = {
    "Name" = "Terraform Demo"
  }
  description = "Tag values for instances"
}

variable "securitygroups" {
  type        = list(string)
  default     = ["sg-083a80f6919f9a2e1"]
  description = "Security group ID's that needs to be attached to the instances"
}

variable "vpcid" {
  type        = string
  default     = "vpc-565d352b"
  description = "VPC ID where the resources needs to be provisioned"
}

variable "region" {
    type = string
    default = "us-east-1"
    description = "Region where infrastructure has to be provisioned"
}

variable "accesskey" {
    type = string
    description  = "Access key to connect to AWS"
}

variable "secretkey" {
   type = string
   description = "Secret key to coneect to AWS"
}

