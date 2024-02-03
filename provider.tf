###### Configure the AWS Provider  ###
terraform {
    required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = "~> 4.0"
    }
    }
}

#provider "aws" {
# region     = "ap-south-1"
# access_key = "AKIAVUR7QIEYIKC6Z3VO" 
# secret_key = "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"
#}
# or
## aws configure --profile test