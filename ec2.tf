data "aws_ami" "latest_amazon_linux2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

resource "aws_instance" "fazle_ec2_pub" {
  ami           = data.aws_ami.latest_amazon_linux2.id //dep
  instance_type = "t2.micro"



  subnet_id                   = aws_subnet.Public_Sub.id
  vpc_security_group_ids      = [aws_security_group.fazle_SG_EC2.id]
  key_name                    = "EC2-pubINS-key"
  associate_public_ip_address = "true"
  count                       = 1
  tags = {
    Name  = "fazle_ec2_pub ${count.index + 1}"
    Owner = "fazle"
  }
}

resource "aws_instance" "fazle_ec2_priv" {
  ami           = data.aws_ami.latest_amazon_linux2.id //dep
  instance_type = "t2.micro"



  subnet_id                   = aws_subnet.Private_Sub.id
  associate_public_ip_address = "false"

  vpc_security_group_ids = [aws_security_group.fazle_SG_EC2.id]
  key_name               = "EC2-pubINS-key"
  count                  = 1
  tags = {
    Name  = "fazle_ec2_priv ${count.index + 1}"
    Owner = "fazle"
  }
}


