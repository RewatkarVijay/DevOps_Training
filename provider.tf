terraform{
  required_providers{
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
    region  = "us-east-1" # Region - N Virginia - Default provide, alias is not required
    #access_key = "AWS_ACCESS_KEY_ID"         ## access_key call from terraform
    #secret_key = "AWS_SECRET_ACCESS_KEY"     ## secret_key call from terraform
  }

# provider "aws" {
#     region  = "ap-south-1" # Region - ap-south-1 (Asia Pacific) - Mumbai
#     alias = "ap-south-1"
#     #access_key = "AWS_ACCESS_KEY_ID"         ## access_key call from terraform
#     #secret_key = "AWS_SECRET_ACCESS_KEY"     ## secret_key call from terraform
#   }