variable "project_id" {
  description = "STACKIT project ID in which the affinity groups are created."
  type        = string
}

variable "region" {
  description = "The resource region. If not defined, the provider region is used."
  type        = string
  default     = null
}

variable "affinity_groups" {
  description = <<-EOT
    Map of affinity groups to create, keyed by a stable identifier. Each value:
      - `name`   (required) : the name of the affinity group.
      - `policy` (required) : placement policy. One of:
          - `hard-affinity`       : all servers in the group MUST share the same compute node.
          - `hard-anti-affinity`  : all servers in the group MUST be on different compute nodes.
          - `soft-affinity`       : prefer the same compute node, but schedule anyway if not possible.
          - `soft-anti-affinity`  : prefer different compute nodes, but schedule anyway if not possible.

    An affinity group is inherently MULTI-server: create it here, then pass its ID
    (`affinity_group_ids["<key>"]`) to the `affinity_group` input of several compute servers.
  EOT
  type = map(object({
    name   = string
    policy = string
  }))
  default = {}

  validation {
    condition = alltrue([
      for g in values(var.affinity_groups) :
      contains(["hard-affinity", "hard-anti-affinity", "soft-affinity", "soft-anti-affinity"], g.policy)
    ])
    error_message = "affinity_groups[*].policy must be one of: hard-affinity, hard-anti-affinity, soft-affinity, soft-anti-affinity."
  }
}
