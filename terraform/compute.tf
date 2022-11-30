resource "aws_instance" "dev-server" {
  count = 1
  ami           = "ami-024c319d5d14b463e"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.sg.id}"]
  key_name = "nanoheal"
  user_data = <<-EOL
  #!/bin/bash -xe

  sudo apt-get update
  sudo apt-get install ca-certificates curl gnupg lsb-release -y
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg -y
  echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update  
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
  sudo usermod -aG docker $USER
  sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  EOL

 tags ={
    Name= "dev-server"
  }
}
