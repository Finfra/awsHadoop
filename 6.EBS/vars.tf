variable "AWS_REGION" {
  default = "ap-northeast-2"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "~/.ssh/id_rsa"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "~/.ssh/id_rsa.pub"
}
variable "AMIS" {
  default = {
    eu-west-1      = "ami-0dad359ff462124ca"
    ap-northeast-2 = "ami-00edfb46b107f643c"
    us-east-1      = "ami-085925f297f89fce1"
  }
}
