resource "aws_instance" "market_pulse_control_plane" {
  ami                    = var.ubuntu_ami
  instance_type          = "t3.medium"
  private_ip             = "10.10.1.4"
  subnet_id              = aws_subnet.market_pulse_sbnt_public.id
  vpc_security_group_ids = [aws_security_group.sg_k8s_nodes.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  root_block_device {
    volume_size           = 30
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }
  tags = {
    "Name" = "${local.prefix}-control-plane"
  }
}


resource "aws_instance" "worker_vp" {
  ami                    = var.ubuntu_ami
  instance_type          = "t3.large"
  private_ip             = "10.10.1.5"
  subnet_id              = aws_subnet.market_pulse_sbnt_public.id
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  vpc_security_group_ids = [aws_security_group.sg_k8s_nodes.id]
  root_block_device {
    volume_size           = 30
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }
  tags = {
    "Name" = "${local.prefix}-worker-1"
  }
}