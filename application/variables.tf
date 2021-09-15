variable "application_name" {
  type = string
}

variable "cluster" {
  type = object({
    id  = string
    arn = string
  })
}

variable "vpc" {
  type = object({
    id = string
  })
}

variable "container_port" {
  type = number
}

variable "desired_count" {
  type = number
}