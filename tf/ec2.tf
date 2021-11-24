resource "aws_instance" "ec2_node" {
  count                       = "1"
  ami                         = var.node_config["ami"]
  instance_type               = var.node_config["instance"]
  key_name		                = aws_key_pair.ssh_key_pair.key_name
  subnet_id                   = aws_subnet.main.id
  vpc_security_group_ids      = [aws_security_group.vm_sg.id]
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp2"
    volume_size = var.node_config["root_volume_size"]
  }


  tags = {
           "stage" = "test"
         }
}

