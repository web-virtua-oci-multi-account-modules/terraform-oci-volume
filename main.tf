locals {
  tags_volume = {
    "tf-name"        = var.name
    "tf-type"        = "subnet"
    "tf-compartment" = var.compartment_name
  }
}

resource "oci_core_volume" "create_volume" {
  compartment_id                 = var.compartment_id
  display_name                   = var.name
  availability_domain            = var.availability_domain
  size_in_gbs                    = var.volume_size
  vpus_per_gb                    = var.vpus_per_gb
  defined_tags                   = var.defined_tags
  freeform_tags                  = merge(var.tags, var.use_tags_default ? local.tags_volume : {})
  is_auto_tune_enabled           = var.is_auto_tune_enabled
  block_volume_replicas_deletion = var.block_volume_replicas_deletion
  kms_key_id                     = var.kms_key_id

  dynamic "autotune_policies" {
    for_each = var.autotune_policies != null ? { for index, autotune_policy in var.autotune_policies : index => autotune_policy } : {}

    content {
      autotune_type   = autotune_policies.value.autotune_type
      max_vpus_per_gb = autotune_policies.value.max_vpus_per_gb
    }
  }

  dynamic "block_volume_replicas" {
    for_each = var.block_volume_replicas != null ? { for index, block_volume_replica in var.block_volume_replicas : index => block_volume_replica } : {}

    content {
      availability_domain = block_volume_replicas.value.availability_domain
      display_name        = block_volume_replicas.value.display_name
    }
  }

  dynamic "source_details" {
    for_each = var.source_details != null ? [1] : []

    content {
      id   = var.source_details.id
      type = var.source_details.type
    }
  }
}
