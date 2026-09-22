output "affinity_group_ids" {
  description = "Map of affinity group key to created affinity group ID (pass to a server's `affinity_group` input)."
  value       = { for k, g in stackit_affinity_group.this : k => g.affinity_group_id }
}

output "affinity_group_members" {
  description = "Map of affinity group key to the list of server IDs currently in the group."
  value       = { for k, g in stackit_affinity_group.this : k => g.members }
}
