#################
### Variables ###
#################

# variable "access_key" {
#   type        = "string"
#   description = "AWS Access Key."
# }

# variable "secret_key" {
#   type        = "string"
#   description = "Your AWS Secret Key."
# }


variable "node_config" {
  type        = map(string)
  description = "Configurable parameters specific to ec2 instance"

  default = {
    "instance"         = "t2.medium"    # 1 vCPU & 1 GB RAM
    "ami"              = "ami-0e554a91eb4e7b6d7"
    "root_volume_size" = 8
  }
}


#######################
### Additional Vars ###
#######################

variable "region" {
  default = "ap-southeast-2"
}

variable "availability_zones" {
  default = ["ap-southeast-2"]
}

variable "ssh_public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6MD5iF0vhqUuAmBbAUhUa7VjudqFJ2fuNbub/+MlWM721elFhn+tFh9Mj/3nWgMVRUy1fC79unZUFO5z693tYmctULLydTgYxpLoZa1gYcD5dWnXj0AAe8lxQwaTUZLcGBpBXSUxWhfGIX+67USg1gFDxjOwu/CztZK+LRN6g6wuZvwkX/L7VQ5HbWJpPSsU3Y/4eN7h2KtRUOa51NJa+iVZaBZlWtnhw8Uq/IG/5nZfrILmVIlMJGG9j7Kjkvtx9NCwUzBsphnS69GKfC8OlTUidC9ZZKkSJXQgeRM6MXCSrir6GjPfJRayo9VGzmNfXkDYSXFDBuPPAt06kTQpYqHNqqO8QKcbhkws8h65S4bEkdURyC0ew92KC5wQLZDG87W4p0n2oYW3m5fr+XmSo6F7SLMFeo2puLELoe5/KGofI/v13PZEATTahSKTpD/4Rr6xKcw4kVlwdPN5Kx2ClwusmSsN3FV59kS67P+PgBjEcHflZqDrNde39540rzHk= samuelhornby@Samuels-MacBook-Pro.local"
}

