#!/bin/bash
sudo yum update
sudo yum install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo chkconfig docker on
sudo docker run --restart always -d -p 25565:25565 -e EULA=true --name mc itzg/minecraft-server
