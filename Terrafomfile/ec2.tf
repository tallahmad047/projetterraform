
data "aws_key_pair" "existing_key_pair" {
  key_name = "namberpython"  # Replace with the name of your existing key pair
}

resource "aws_instance" "website" {
  ami           = "ami-0b8b44ec9a8f90422"
  instance_type = "t3.micro"
  vpc_security_group_ids = [ aws_security_group.my_instance_SG.id ]
  key_name = data.aws_key_pair.existing_key_pair.key_name  # Use the existing key pair name
  
  user_data = <<-EOF
              #!/bin/bash
              


              sudo apt-get update
              sudo apt install docker.io -y
              sudo apt install python3-pip -y
              sudo pip3 install psutil flask
              

              sudo systemctl restart docker
              sudo usermod -aG docker 
              sudo apt install git -y
              
              mkdir /home/ubuntu/tall
              cd /home/ubuntu/tall
              git clone https://github.com/tallahmad047/memoireApp.git  
              cd /home/ubuntu/tall/memoireApp
              sudo docker build -t myflaskappv1 .
              sudo docker run -p 5000:5000 myflaskappv1

              
              
              EOF

            

  tags = {
    Name = "memoire"
  }
}