variable "aws_region" {
  type    = string
  default = "eu-north-1"
}

variable "ubuntu_ami" {
  type        = string
  description = "Ubuntu Server 24.04 LTS"
  default     = "ami-084df9e6ad4622caf"
}

