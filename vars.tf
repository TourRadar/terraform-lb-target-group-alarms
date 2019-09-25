variable "actions" {
  description = "List of actions what should be executed"
  type        = list(string)
}
variable "loadbalancer_arn" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "alarm_prefix" {
  type = string
}

variable "tags" {
  default = {}
}

variable "http_code_target_5xx_count_checks" {
  type = map(number)
  default = {
    P1 = 6
    P2 = 5
    P3 = 4
    P4 = 3
    P5 = 2
  }
}

variable "http_code_target_5xx_count_periods" {
  type    = number
  default = 1
}

variable "http_code_target_5xx_count_period" {
  type    = number
  default = 60
}

variable "http_code_target_5xx_count_treat_missing_data" {
  type    = string
  default = "notBreaching"
}


variable "http_code_target_4xx_count_checks" {
  type = map(number)
  default = {
    P1 = 6
    P2 = 5
    P3 = 4
    P4 = 3
    P5 = 2
  }
}

variable "http_code_target_4xx_count_periods" {
  type    = number
  default = 1
}

variable "http_code_target_4xx_count_period" {
  type    = number
  default = 60
}

variable "http_code_target_4xx_count_treat_missing_data" {
  type    = string
  default = "notBreaching"
}


variable "target_response_time_checks" {
  type = map(number)
  default = {
    P1 = 0.7
    P2 = 0.6
    P3 = 0.5
    P4 = 0.4
    P5 = 0.3
  }
}

variable "target_response_time_periods" {
  type    = number
  default = 2
}

variable "target_response_time_period" {
  type    = number
  default = 60
}

variable "target_response_time_treat_missing_data" {
  type    = string
  default = "notBreaching"
}


variable "healthy_host_count_enabled" {
  type    = bool
  default = true
}

variable "healthy_host_count_threshold" {
  type    = number
  default = 1
}

variable "healthy_host_count_periods" {
  type    = number
  default = 1
}

variable "healthy_host_count_period" {
  type    = number
  default = 60
}

variable "healthy_host_count_treat_missing_data" {
  type    = string
  default = "breaching"
}