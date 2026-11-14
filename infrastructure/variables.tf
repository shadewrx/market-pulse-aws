variable "aws_region" {
  type    = string
  default = "eu-north-1"
}

variable "ubuntu_ami" {
  type        = string
  description = "Ubuntu Server 26.04 LTS"
  default     = "ami-04bd74efcade5de13"
}

