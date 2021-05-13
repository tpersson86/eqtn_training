#
# DO NOT DELETE THESE LINES UNTIL INSTRUCTED TO!
#
# Your AMI ID is:
#
#     ami-0ee02acd56a52998e
#
# Your subnet ID is:
#
#     subnet-05406accbde7265ca
#
# Your VPC security group ID is:
#
#     sg-0c7da1ad8460a858a
#
# Your Identity is:
#
#     terraform-training-catfish
#

terraform {
  backend "remote" {
    organization = "tpersson-test"

    workspaces {
      name = "tpersson-etrn"
    }
  }
}


provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}


module "server" {
  source = "${path.root}server"

  ami                    = var.ami
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  identity               = var.identity
  key_name               = module.keypair.key_name
  private_key            = module.keypair.private_key_pem
}

module "keypair" {
  source  = "mitchellh/dynamic-keys/aws"
  version = "2.0.0"
  path    = "${path.root}/keys"
  name    = "${var.identity}-key"
}