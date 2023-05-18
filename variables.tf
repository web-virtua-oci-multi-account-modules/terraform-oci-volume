variable "compartment_id" {
  description = "Compartment ID"
  type        = string
}

variable "name" {
  description = "Volume name"
  type        = string
}

variable "availability_domain" {
  description = "Availability domain"
  type        = string
  default     = null
}

variable "volume_size" {
  description = "Volume size"
  type        = number
  default     = 50
}

variable "vpus_per_gb" {
  description = "VPUS per Giga define the performance of the volume, 0 to lower cost, 10 to balanced, 20 to higher performance an from 30 up to 120 to ultra high performance, default is 10"
  type        = number
  default     = 10
}

variable "is_auto_tune_enabled" {
  description = "Specifies whether the auto-tune performance is enabled for this volume. This field is deprecated. Use the DetachedVolumeAutotunePolicy instead to enable the volume for detached autotune"
  type        = bool
  default     = null
}

variable "block_volume_replicas_deletion" {
  description = "Block volume replicas deletion, if true will be deleted the replicas from this volume"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "The OCID of the Vault service key to assign as the master encryption key for the volume"
  type        = string
  default     = null
}

variable "autotune_policies" {
  description = "Autotune policies to be enabled for this volume, autotune_type specifies the type of autotunes supported by OCI and max_vpus_per_gb is required if used PERFORMANCE_BASED, this will be the maximum VPUs/GB performance level that the volume will be auto-tuned temporarily based on performance monitoring"
  type = list(object({
    autotune_type   = string
    max_vpus_per_gb = optional(number)
  }))
  default = null
}

variable "block_volume_replicas" {
  description = "Block volume replicas to be enabled for this volume in the specified destination availability domains"
  type = list(object({
    availability_domain = string
    display_name        = optional(string)
  }))
  default = null
}

variable "source_details" {
  description = "This variable can be used for create the volume from other volume, replica or backp. Set the ID of resource and the type that can be volume, volumeBackup or blockVolumeReplica"
  type = object({
    id   = string
    type = string
  })
  default = null
}

variable "compartment_name" {
  description = "Compartment name"
  type        = string
  default     = null
}

variable "use_tags_default" {
  description = "If true will be use the tags default to resources"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to VCN"
  type        = map(any)
  default     = {}
}

variable "defined_tags" {
  description = "Defined tags to VCN"
  type        = map(any)
  default     = null
}
