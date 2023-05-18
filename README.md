# OCI Volume for multiples accounts with Terraform module
* This module simplifies creating and configuring of Volume across multiple accounts on OCI

* Is possible use this module with one account using the standard profile or multi account using multiple profiles setting in the modules.

## Actions necessary to use this module:

* Criate file provider.tf with the exemple code below:
```hcl
provider "oci" {
  alias   = "alias_profile_a"
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.ssh_private_key_path
  region           = var.region
}

provider "oci" {
  alias   = "alias_profile_b"
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.ssh_private_key_path
  region           = var.region
}
```


## Features enable of Volume configurations for this module:

- Volume

## Usage exemples


### Create subnet with DNS label and one security list

```hcl
module "volume_test" {
  source = "web-virtua-oci-multi-account-modules/volume/oci"

  name                = "tf-volume-test"
  volume_size         = 50
  compartment_id      = var.compartment_id
  availability_domain = "Uocm:PHX-AD-1"

  autotune_policies = [
    {
      autotune_type = "PERFORMANCE_BASED"
		  max_vpus_per_gb = "120"
    }
  ]

  providers = {
    oci = oci.alias_profile_a
  }
}
```


## Variables

| Name | Type | Default | Required | Description | Options |
|------|-------------|------|---------|:--------:|:--------|
| compartment_id | `string` | `-` | yes | Compartment ID | `-` |
| name | `string` | `-` | yes | Volume name | `-` |
| availability_domain | `string` | `null` | no | Availability domain | `-` |
| volume_size | `number` | `50` | no | Volume size" | `-` |
| vpus_per_gb | `number` | `10` | no | VPUS per Giga define the performance of the volume, 0 to lower cost, 10 to balanced, 20 to higher performance an from 30 up to 120 to ultra high performance, default is 10 | `-` |
| is_auto_tune_enabled | `bool` | `null` | no | Specifies whether the auto-tune performance is enabled for this volume. This field is deprecated. Use the DetachedVolumeAutotunePolicy instead to enable the volume for detached autotune | `*`false <br> `*`true |
| block_volume_replicas_deletion | `bool` | `true` | no | Block volume replicas deletion, if true will be deleted the replicas from this volume | `*`false <br> `*`true |
| kms_key_id | `string` | `null` | no | The OCID of the Vault service key to assign as the master encryption key for the volume | `-` |
| autotune_policies | `list(object)` | `null` | no | Autotune policies to be enabled for this volume, autotune_type specifies the type of autotunes supported by OCI and max_vpus_per_gb is required if used PERFORMANCE_BASED, this will be the maximum VPUs/GB performance level that the volume will be auto-tuned temporarily based on performance monitoring | `-` |
| block_volume_replicas | `list(object)` | `null` | no | Block volume replicas to be enabled for this volume in the specified destination availability domains | `-` |
| source_details | `object` | `null` | no | This variable can be used for create the volume from other volume, replica or backp. Set the ID of resource and the type that can be volume, volumeBackup or blockVolumeReplica | `-` |
| compartment_name | `string` | `-` | no | Compartment name | `-` |
| use_tags_default | `bool` | `true` | no | If true will be use the tags default to resources | `*`false <br> `*`true |
| tags | `map(any)` | `{}` | no | Tags to subnet | `-` |
| defined_tags | `map(any)` | `{}` | no | Defined tags to subnet | `-` |

* Default autotune_policies variable
```hcl
variable "autotune_policies" {
  description = "Autotune policies to be enabled for this volume, autotune_type specifies the type of autotunes supported by OCI and max_vpus_per_gb is required if used PERFORMANCE_BASED, this will be the maximum VPUs/GB performance level that the volume will be auto-tuned temporarily based on performance monitoring"
  type = list(object({
    autotune_type   = string
    max_vpus_per_gb = optional(number)
  }))
  default = [
    {
      autotune_type = "PERFORMANCE_BASED"
		  max_vpus_per_gb = "120"
    }
  ]
}
```

* Default block_volume_replicas variable
```hcl
variable "block_volume_replicas" {
  description = "Block volume replicas to be enabled for this volume in the specified destination availability domains"
  type = list(object({
    availability_domain = string
    display_name        = optional(string)
  }))
  default = []
}
```

* Default source_details variable
```hcl
variable "source_details" {
  description = "This variable can be used for create the volume from other volume, replica or backp. Set the ID of resource and the type that can be volume, volumeBackup or blockVolumeReplica"
  type = object({
    id   = string
    type = string
  })
  default = {}
}
```


## Resources

| Name | Type |
|------|------|
| [oci_core_volume.create_volume](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_volume) | resource |

## Outputs

| Name | Description |
|------|-------------|
| `volume` | Volume |
| `volume_id` | Volume ID |
