
data "aws_vpc" "default" {
  id = var.vpc_id
}

data "aws_subnet" "default" {
  id = var.subnet_id
}

data "aws_key_pair" "hycho-demo-key" {
  key_name = var.key_pair

}
resource "aws_security_group" "hycho-demo-security" {
  name   = "${var.prefix}-security-group"
  vpc_id = data.aws_vpc.default.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.prefix}-security-group"
  }
}
data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20220426.0-x86_64-gp2"]
  }
  owners = ["137112412989"]
}
resource "aws_eip" "hycho-demo-eip" {
  for_each = toset (var.instance_name)
  domain      = "vpc"
  tags = {
    Name = each.key
  }
}
resource "aws_eip_association" "hycho-demo-asso" {
  for_each = toset (var.instance_name)
  instance_id   = aws_instance.hycho-demo-instance[each.key].id
  allocation_id = aws_eip.hycho-demo-eip[each.key].id
}

resource "aws_instance" "hycho-demo-instance" {
  for_each = toset (var.instance_name)
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  key_name                    = data.aws_key_pair.hycho-demo-key.key_name
  associate_public_ip_address = true
  subnet_id                   = data.aws_subnet.default.id
  vpc_security_group_ids      = [aws_security_group.hycho-demo-security.id]
  tags = {
    Name = each.key
  }
}