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

variable "task_definition" {
  type = object({
    arn = string
  })
}

variable "ecs_execution_role" {
  type = object({
    arn = string
  })
}

variable "desired_count" {
  type = number
}

variable "container_name" {
  type = string
}

variable "container_port" {
  type = number
}
