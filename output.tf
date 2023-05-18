output "volume" {
  description = "Volume"
  value       = oci_core_volume.create_volume
}

output "volume_id" {
  description = "Volume ID"
  value       = oci_core_volume.create_volume.id
}
