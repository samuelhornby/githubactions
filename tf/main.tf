#######################################################
### This TF file sets up all networking               #
#######################################################


terraform {  
  required_providers {    
    aws = {      
      source  = "hashicorp/aws"      
      version = "~> 3.27"    
    }  
  }
  required_version = ">= 0.14.9"

  backend "remote" {
       organization = "samuelhornby"
    workspaces {      
      name = "gh-actions-demo"    
      }  
    }
}

provider "aws" {
  profile = "default"
  region  = "${var.region}"
}


  

resource "aws_key_pair" "ssh_key_pair" {

  key_name	  = "ssh_key"
  public_key      = "${var.ssh_public_key}"
}

resource "aws_resourcegroups_group" "test" {
  name = "test-group"

  resource_query {
    query = <<JSON
      {
        "ResourceTypeFilters": [
          "AWS::AllSupported"
        ],
        "TagFilters": [
          {
            "Key": "stage",
            "Values": ["test"]
          }
        ]
      }
    JSON
  }
}

resource "aws_vpc" "test_vpc"{
  
	cidr_block           = "10.20.0.0/16"
	enable_dns_hostnames = true
  tags = {
    "stage" = "test"
  }
}

resource "aws_subnet" "main"{
	vpc_id     = "${aws_vpc.test_vpc.id}"
	cidr_block = "10.20.1.0/24"
}

resource "aws_internet_gateway" "gateway"{
	vpc_id     = "${aws_vpc.test_vpc.id}"
}

#Gateway with routing table
resource "aws_route_table" "public-rt"{
	vpc_id     = "${aws_vpc.test_vpc.id}"
	 route {
	   cidr_block = "0.0.0.0/0"
           gateway_id = "${aws_internet_gateway.gateway.id}"
        }
}

#Assign route table to subnet
resource "aws_route_table_association" "public-rt" {
  subnet_id      = "${aws_subnet.main.id}"
  route_table_id = "${aws_route_table.public-rt.id}"
}

# VM security group
resource "aws_security_group" "vm_sg" {
  name        = "vm_sgroup"
  description = "Allow certain inbound and all outbound traffic"
  vpc_id      = "${aws_vpc.test_vpc.id}"
  tags = {
    "stage" = "test"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["115.69.164.197/32"]
  }

  egress {
    # allow all outbound traffic ipv4
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
