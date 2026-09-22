#####################################################################################
# Terraform module examples are meant to show an _example_ on how to use a module
# per use-case. The code below should not be copied directly but referenced in order
# to build your own root module that invokes this module.
#
# This example is self-contained and requires only `project_id`: it creates an
# anti-affinity group (typical HA use case — spread servers across compute nodes).
#####################################################################################

module "affinity_group" {
  source = "../.."

  project_id = var.project_id

  affinity_groups = {
    web_ha = {
      name   = "example-web-anti-affinity"
      policy = "soft-anti-affinity"
    }
  }
}
