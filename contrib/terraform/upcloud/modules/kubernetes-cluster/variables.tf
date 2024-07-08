variable "prefix" {
  type = string
}

variable "zone" {
  type = string
}

variable "private_cloud" {
  type = bool
}

variable "public_zone" {
  type = string
}

variable "template_name" {}

variable "username" {}

variable "private_network_cidr" {}

variable "machines" {
  description = "Cluster machines"
  type = map(object({
    node_type = string
    plan      = string
    cpu       = string
    mem       = string
    disk_size = number
    server_group : string
    additional_disks = map(object({
      size = number
      tier = string
    }))
  }))
}

variable "ssh_public_keys" {
  type = list(string)
}

variable "firewall_enabled" {
  type = bool
}

variable "master_allowed_remote_ips" {
  type = list(object({
    start_address = string
    end_address   = string
  }))
}

variable "k8s_allowed_remote_ips" {
  type = list(object({
    start_address = string
    end_address   = string
  }))
}

variable "master_allowed_ports" {
  type = list(object({
    protocol       = string
    port_range_min = number
    port_range_max = number
    start_address  = string
    end_address    = string
  }))
}

variable "worker_allowed_ports" {
  type = list(object({
    protocol       = string
    port_range_min = number
    port_range_max = number
    start_address  = string
    end_address    = string
  }))
}

variable "firewall_default_deny_in" {
  type = bool
}

variable "firewall_default_deny_out" {
  type = bool
}

variable "loadbalancer_enabled" {
  type = bool
}

variable "loadbalancer_plan" {
  type = string
}

variable "loadbalancer_outbound_proxy_protocol" {
  type = string
}

variable "loadbalancers" {
  description = "Load balancers"

  type = map(object({
    port                    = number
    target_port             = number
    allow_internal_frontend = optional(bool)
    backend_servers         = list(string)
  }))
}

variable "server_groups" {
  description = "Server groups"

  type = map(object({
    anti_affinity_policy = string
  }))
}

variable "router_enable" {
  description = "If a router should be enabled and connected to the private network or not"

  type = bool
}

variable "gateways" {
  description = "Gateways that should be connected to the router, requires router_enable is set to true"

  type = map(object({
    features = list(string)
    plan = optional(string)
    connections = optional(map(object({
      type = string
      local_routes = optional(map(object({
        type = string
        static_network = string
      })))
      remote_routes = optional(map(object({
        type = string
        static_network = string
      })))
      remote_address = string
    })))
  }))
}

variable "gateway_vpn_psks" {
  description = "Separate variable for providing psks for connection tunnels"

  type = map(object({
    psk = string
  }))
  default = {}
  sensitive = true
}

variable "static_routes" {
  description = "Static routes to apply to the router, requires router_enable is set to true"

  type = map(object({
    nexthop = string
    route = string
  }))
}

variable "network_peerings" {
  description = "Other UpCloud private networks to peer with, requires router_enable is set to true"

  type = map(object({
    remote_network = string
  }))
}
