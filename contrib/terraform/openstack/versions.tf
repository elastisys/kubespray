terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.17"
    }

    template = {
      source = "hashicorp/template"
      version = "2.2.0"
    }
  }
  experiments      = [module_variable_optional_attrs]
  required_version = ">= 0.14.0"
}
