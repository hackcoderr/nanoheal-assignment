resource "aws_vpc" "vpc" {
  cidr_block = "10.0.10.0/24"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "myvpc"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "10.0.10.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "my-subnet-1"
  }


}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    gateway_id = aws_internet_gateway.igw.id
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igw"
  }
}
resource "aws_route_table_association" "public" {

  subnet_id      = aws_subnet.subnet.id
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_security_group" "sg" {
  vpc_id = "${aws_vpc.vpc.id}"
  ingress {
    description = "from my ip range"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    to_port     = "0"
  }
  tags ={
    Name= "my-security-grp"
  }
}