variable "AWS_ACCESS_KEY" {
  
}

variable "AWS_SECRET_KEY" {
  
}


variable "AWS_REGION"{
    type = string
    default = "us-east-1"
}

variable "Security_Group" {
  type = list(string)
  default = ["sg-24076", "sg-90890", "sg-456789"]
}

variable "AMIS" {
    type = map(string)

    default = {
      "us-east-1" = "ami-0059b7cd9f67d8050"
      "us-east-2" = "ami-05803413c51f242b7"
      "us-west-2" = "ami-08305dd8ab642ad8c"
      "us-west-1" = "ami-0c86d2a7a5239e6d7"

      
      
    }

  
}