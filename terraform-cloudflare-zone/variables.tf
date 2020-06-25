variable "zone" {
  type        = string
  description = "doamin name"
}

variable "ttl" {
  description = "TTL to be used for www record - 1 for automatic"
  type        = number
  default     = 1
}

variable "proxied" {
  description = "If www record shoud be proxied or not"
  type        = bool
  default     = true
}

variable "mx_provider" {
  description = "Name of mail server provider - only Google"
  type        = string
  default     = "none"
}

variable "custom_mx_servers" {
  description = "List of mailservers for this domain"
  type        = (map(number))
  default     = {}
}
