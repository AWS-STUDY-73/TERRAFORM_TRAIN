# Create Modules for Each Resource
module "vpc" {
    source              = "../modules/vpc"
    project             = var.project
    vpc_cidr            = var.vpc_cidr
    public_web_1_cidr   = var.public_web_1_cidr
    public_web_2_cidr   = var.public_web_2_cidr
    private_data_1_cidr = var.private_data_1_cidr
    private_data_2_cidr = var.private_data_2_cidr
    private_app_1_cidr  = var.private_app_1_cidr
    private_app_2_cidr  = var.private_app_2_cidr
}

module "auto-scaling-group" {
   source                   = "../modules/auto-scaling-group"
   ami_id                   = var.ami_id
   instance_type            = var.instance_type
   key_name                 = var.key_name
}

module "aws_security_group" {
   source = "../modules/security-group"
   project = var.project
   vpc_id = module.vpc.vpc_id
  
}