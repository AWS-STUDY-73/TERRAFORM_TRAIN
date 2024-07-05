output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_az1_id" {
    value = aws_subnet.public_web_subnet_1_az1.id
}

output "public_subnet_az2_id" {
    value = aws_subnet.public_web_subnet_2_az2.id
}

output "private_app_subnet_az1_id" {
    value = aws_subnet.private_app_subnet_1_az1.id
}

output "private_app_subnet_az2_id" {
    value = aws_subnet.private_app_subnet_2_az2.id
}

output "private_data_subnet_az1_id" {
    value = aws_subnet.private_data_subnet_1_az1.id
}

output "private_data_subnet_az2_id" {
    value = aws_subnet.private_data_subnet_2_az2.id
}

output "internet_gateway" {
    value = aws_internet_gateway.igw.id
}

output "availability_zone" {
    value = data.aws_availability_zones.azs.names  
}
