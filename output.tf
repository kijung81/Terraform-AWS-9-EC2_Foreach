# Outputs file
output "vpc_id" {
  value = data.aws_vpc.default.id
}
output "subnet" {
  value = data.aws_subnet.default.arn
}
output "private_key" {
  value = var.key_pair
}
output "instance_eip" {
  value = [
        for k, v in aws_eip.hycho-demo-eip:
        v.public_ip
    ]
}
#EIP 구성 시 EIP의 DNS로 서비스 접속 필요
output "instance_eip_dns" {
  value = [
        for k, v in aws_eip.hycho-demo-eip:
        v.public_dns
    ]
}

