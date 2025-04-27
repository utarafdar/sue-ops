terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.91.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = "sue-stg-account"
}

module "vpc" {
  source               = "../../modules/vpc"
  vpc_cidr             = "10.0.0.0/16"
  vpc_name             = "sue-main"
  azs                  = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  env                  = var.env
}

# Elastic beanstalk security groups
module "elastic_beanstalk_sg" {
  source = "../../modules/security_groups"
  vpc_id = module.vpc.vpc_id
  env    = var.env
}


# Elastic Beanstalk Application
module "elastic_beanstalk" {
  source                 = "../../modules/elastic_beanstalk"
  app_name               = "sue-stg-ha-app"
  app_description        = "Staging HA application"
  env_name               = "sue-stg-ha-env"
  solution_stack_name    = "64bit Amazon Linux 2023 v4.6.0 running PHP 8.1"
  beanstalk_service_role = "aws-elasticbeanstalk-service-role"
  ec2_instance_profile   = "aws-elasticbeanstalk-ec2-role"
  ec2_instance_sg_ids    = [module.elastic_beanstalk_sg.eb_instances_sg_id]
  load_balancer_sg_ids   = [module.elastic_beanstalk_sg.eb_load_balancer_sg_id]
  instance_type          = "t3.micro"
  vpc_id                 = module.vpc.vpc_id
  public_subnets         = module.vpc.public_subnets
  private_subnets        = module.vpc.private_subnets
  min_size               = 1
  max_size               = 2
  tags                   = { Name = "sue-stg-ha-app" }
}

# Bastion Host
module "bastion" {
  source           = "../../modules/bastion"
  name             = "sue-stg-bastion"
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnets[0] # Use the first public subnet
  ami_id           = "ami-0ce8c2b29fcc8a346"
  instance_type    = "t3.micro"
  key_name         = "bastion-key"
}

# RDS MariaDB
module "rds_mariadb" {
  source = "../../modules/rds_mariadb"

  name               = "sue-stg-db"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets
  bastion_sg_id      = module.bastion.bastion_security_group_id
  beanstalk_sg_id    = module.elastic_beanstalk_sg.eb_instances_sg_id

  db_username = var.mariadb_username
  db_password = var.mariadb_password

  allocated_storage = 20
  instance_class    = "db.t3.micro"
}

# WAF Module
module "waf" {
  source       = "../../modules/waf"
  name         = "sue-stg-waf"
  description  = "WAF to block bot traffic for staging environment"
  resource_arn = module.elastic_beanstalk.load_balancer_arn
}