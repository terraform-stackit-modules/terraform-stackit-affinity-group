resource "stackit_affinity_group" "this" {
  for_each = var.affinity_groups

  project_id = var.project_id
  region     = var.region
  name       = each.value.name
  policy     = each.value.policy
}
