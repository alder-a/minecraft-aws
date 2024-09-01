provider "aws" {
  region = "us-east-1"
}

variable "ec2_instance_type" {
  type        = string
  description = "ec2 instance type, recommend at least t2.small"
}

data "aws_vpc" "default" {
 default = true
}

resource "aws_security_group" "minecraft_sg" {
 name        = "minecraft-sg"
 description = "Allow minecraft port"
 vpc_id      = data.aws_vpc.default.id

ingress {
   description = "Minecraft"
   from_port   = 25565
   to_port     = 25565
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }

egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "aws_instance" "minecraft_server" {
  ami           = "ami-066784287e358dad1"
  tags          = {
    Name        = "minecraft-server"
  }
  instance_type = var.ec2_instance_type
  vpc_security_group_ids      = [aws_security_group.minecraft_sg.id]
  root_block_device {
    volume_type           = "gp3"
    volume_size           = "16"
    delete_on_termination = true
  }
  user_data = file("${path.module}/init-minecraft.sh")
}

output "ec2_global_ips" {
  value = ["${aws_instance.minecraft_server.*.public_ip}"]
}
