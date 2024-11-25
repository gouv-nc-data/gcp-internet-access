variable "project_id" {
  type        = string
  description = "id du projet"
}

variable "region" {
  type    = string
  default = "europe-west1"
}

variable "network_name" {
  type        = string
  default     = "default"
  description = "Nom du réseau"
}

variable "subnetwork_name" {
  type        = string
  default     = "default"
  description = "Nom du sous-réseau"
}

variable "router_name" {
  type        = string
  default     = "default-router"
  description = "Nom du router"
}

variable "nat_name" {
  type        = string
  default     = "default-nat"
  description = "Nom du nat"
}

variable "ip_range" {
  type        = string
  default     = "10.0.0.0/24"
  description = "Range d'ip du sous-réseau"
}

variable "egress_ip_range" {
  type        = string
  default     = "61.5.212.17/32" # ip de jira
  description = "Range d'ip autorisée en egress"
}