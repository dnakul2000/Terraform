variable "region" {
 description = "AWS region for hosting our your network\"
 default = "us-east-1"
}
variable "public_key_path" {
 description = "Enter the path to the SSH Public Key to add to AWS."
 default = "/g/aws/keypair_name.pem"
}
variable "key_name" {
 description = "ssh into key"
 default = "key"
}
variable "ami" {
 description = "Base AMI to launch the instances"
 default = {
    us-east-1 = "ami-8da8d2e2"
  }
}

data "aws_availability_zones" "all" {}
