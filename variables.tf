variable "instance_name" {
  type = set (string)
  default = ["web01", "web02", "web03", "web04"]
}
variable "prefix" {
  default = "Terraform-PoC-9-ec2foreach"
}
variable "region" {
  default = "ap-noatheast-2"
}
variable "vpc_id" {
  default = "vpc-09cd62d218db5f3a5"
}
variable "subnet_id" {
  default = "subnet-012d3f9fd2ab6b143"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "key_pair" {
  default = "Terraform-PoV"
}
