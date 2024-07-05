# VPC For Application Deployment

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support     = true
  enable_dns_hostnames   = true
  tags = {
    Name = "${var.project}-VPC"
  }
}

# Availability Zone
data "aws_availability_zones" "azs" {}

# Create Public Subnet 1
resource "aws_subnet" "public_web_subnet_1_az1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_web_1_cidr
  availability_zone       = data.aws_availability_zones.azs.names[0]
  map_public_ip_on_launch = true
  
  tags = {
    Name = "${var.project}-Public-Subnet-Web-1"
  }
 }

 # Create Public Subnet 2
 resource "aws_subnet" "public_web_subnet_2_az2"{
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = var.public_web_2_cidr
    availability_zone       = data.aws_availability_zones.azs.names[1]
    map_public_ip_on_launch = true
  
    tags = {
        Name = "${var.project}-Public-Subnet-Web-2"
    }
 }

 # Create Private Subnet App 1
 resource "aws_subnet" "private_app_subnet_1_az1"{ 
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = var.private_app_1_cidr
    availability_zone       = data.aws_availability_zones.azs.names[0]
    map_public_ip_on_launch = false
    tags = {
        Name = "${var.project}-Private-Subnet-App-1"
    }
 }

 # Create Private Subnet App 2
 resource "aws_subnet" "private_app_subnet_2_az2"{
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_app_2_cidr
    availability_zone = data.aws_availability_zones.azs.names[1]
    map_public_ip_on_launch = false
    tags = {
        Name = "${var.project}-Private-Subnet-App-2"
    } 
 }

 # Create Private Subnet DB 1
 resource "aws_subnet" "private_data_subnet_1_az1"{
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = var.private_data_1_cidr
    availability_zone       = data.aws_availability_zones.azs.names[0]
    map_public_ip_on_launch = false
    tags = {
        Name = "${var.project}-Private-Subnet-DB-1"
    } 
 }

 # Create Private Subnet DB 2
 resource "aws_subnet" "private_data_subnet_2_az2"{
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = var.private_data_2_cidr
    availability_zone       = data.aws_availability_zones.azs.names[1]
    map_public_ip_on_launch = false
    tags = {
        Name = "${var.project}-Private-Subnet-DB-2"
    } 
 }

 # Create Internet Gateway
 resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project}-IGW"
  }
 }

 # Create Route Table For Public Subnet
 resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.project}-Public-RT"
  }
 }

 # Create Public Route Table Association
 resource "aws_route_table_association" "public_1_association" {
    subnet_id = aws_subnet.public_web_subnet_1_az1.id
    route_table_id = aws_route_table.public_route_table.id
 } 

 resource "aws_route_table_association" "public_2_association" {
    subnet_id = aws_subnet.public_web_subnet_2_az2.id
    route_table_id = aws_route_table.public_route_table.id
 }

 # Create Private Route Table
 resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name = "${var.project}-Private-RT"
  }
 }

 # Create Private Route Table Association
 resource "aws_route_table_association" "private_1_association" {
    subnet_id = aws_subnet.private_app_subnet_1_az1.id
    route_table_id = aws_route_table.private_route_table.id
 }

 resource "aws_route_table_association" "private_2_association" {
    subnet_id = aws_subnet.private_app_subnet_2_az2.id
    route_table_id = aws_route_table.private_route_table.id
 }

 resource "aws_route_table_association" "private_3_association" {
    subnet_id = aws_subnet.private_data_subnet_1_az1.id
    route_table_id = aws_route_table.private_route_table.id
 }

 resource "aws_route_table_association" "private_4_association" {
    subnet_id = aws_subnet.private_data_subnet_2_az2.id
    route_table_id = aws_route_table.private_route_table.id
 }


# Create Elastic IP
 resource "aws_eip" "eip" {
  tags = {
    Name = "${var.project}-EIP"
  }
}

# Create NAT Gateway
 resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_web_subnet_1_az1.id
  tags = {
    Name = "${var.project}-NGW"
  }
}