//public ins Key

resource "aws_key_pair" "EC2-pubIns-key" {
  key_name   = "EC2-pubINS-key" //dep
  public_key = tls_private_key.ec2-publicINS-priv-key.public_key_openssh
}

resource "tls_private_key" "ec2-publicINS-priv-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "pem_file_pub" {
  content  = tls_private_key.ec2-publicINS-priv-key.private_key_pem
  filename = "publicINS-priv-key"
}

//private ins Key

resource "aws_key_pair" "EC2-privINS-key" {
  key_name   = "EC2-privINS-key"
  public_key = tls_private_key.ec2-privateINS-priv-key.public_key_openssh
}

resource "tls_private_key" "ec2-privateINS-priv-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "pem_file_priv" {
  content  = tls_private_key.ec2-privateINS-priv-key.private_key_pem
  filename = "privateINS-priv-key"
}