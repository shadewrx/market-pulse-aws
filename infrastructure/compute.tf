data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-kernel-6.1-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_instance" "vm_private_ec2" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  private_ip             = "10.10.2.4"
  subnet_id              = aws_subnet.market_pulse_sbnt_private.id
  vpc_security_group_ids = [aws_security_group.sg_private.id]
  key_name               = aws_key_pair.lab_key.key_name
  root_block_device {
    volume_size           = 10
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }
  tags = {
    "Name" = "private"
  }
}

resource "aws_instance" "vm_public_ec2" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  private_ip             = "10.10.1.4"
  subnet_id              = aws_subnet.market_pulse_sbnt_public.id
  vpc_security_group_ids = [aws_security_group.sg_public.id]
  key_name               = aws_key_pair.lab_key.key_name
  root_block_device {
    volume_size           = 10
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }
  tags = {
    "Name" = "public"
  }
}

resource "aws_key_pair" "lab_key" {
  key_name   = "lab-key"
  public_key = file(pathexpand("~/.ssh/id_ed25519.pub"))
}