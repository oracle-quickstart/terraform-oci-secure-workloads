## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | 5.2.0 |
| <a name="provider_oci.block_volumes_replication_region"></a> [oci.block\_volumes\_replication\_region](#provider\_oci.block\_volumes\_replication\_region) | 5.2.0 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [oci_core_app_catalog_listing_resource_version_agreement.these](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_app_catalog_listing_resource_version_agreement) | resource |
| [oci_core_app_catalog_subscription.these](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_app_catalog_subscription) | resource |
| [oci_core_instance.these](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_instance) | resource |
| [oci_core_volume.these](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_volume) | resource |
| [oci_core_volume_attachment.these](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_volume_attachment) | resource |
| [oci_core_volume_backup_policy_assignment.these](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_volume_backup_policy_assignment) | resource |
| [oci_core_volume_backup_policy_assignment.these_boot_volumes](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_volume_backup_policy_assignment) | resource |
| [oci_file_storage_export.these](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/file_storage_export) | resource |
| [oci_file_storage_export_set.these](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/file_storage_export_set) | resource |
| [oci_file_storage_file_system.these](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/file_storage_file_system) | resource |
| [oci_file_storage_filesystem_snapshot_policy.defaults](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/file_storage_filesystem_snapshot_policy) | resource |
| [oci_file_storage_filesystem_snapshot_policy.these](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/file_storage_filesystem_snapshot_policy) | resource |
| [oci_file_storage_mount_target.these](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/file_storage_mount_target) | resource |
| [oci_file_storage_replication.these](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/file_storage_replication) | resource |
| [oci_core_app_catalog_listing_resource_versions.existing](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/core_app_catalog_listing_resource_versions) | data source |
| [oci_core_app_catalog_listings.existing](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/core_app_catalog_listings) | data source |
| [oci_identity_availability_domains.ads](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/identity_availability_domains) | data source |
| [oci_identity_availability_domains.bv_ads](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/identity_availability_domains) | data source |
| [oci_identity_availability_domains.bv_ads_replicas](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/identity_availability_domains) | data source |
| [oci_identity_availability_domains.fs_ads](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/identity_availability_domains) | data source |
| [oci_identity_availability_domains.mt_ads](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/identity_availability_domains) | data source |
| [oci_identity_availability_domains.snapshot_ads](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/identity_availability_domains) | data source |
| [template_cloudinit_config.config](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/cloudinit_config) | data source |
| [template_file.block_volumes_templates](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartments_dependency"></a> [compartments\_dependency](#input\_compartments\_dependency) | A map of objects containing the externally managed compartments this module may depend on. All map objects must have the same type and must contain at least an 'id' attribute (representing the compartment OCID) of string type. | `map(any)` | `null` | no |
| <a name="input_enable_output"></a> [enable\_output](#input\_enable\_output) | Whether Terraform should enable the module output. | `bool` | `true` | no |
| <a name="input_file_system_dependency"></a> [file\_system\_dependency](#input\_file\_system\_dependency) | A map of objects containing the externally managed file storage resources this module may depend on. This is used when setting file system replication using target file systems managed in another Terraform configuration. All map objects must have the same type and must contain at least an 'id' attribute (representing the file system OCID) of string type. | `map(any)` | `null` | no |
| <a name="input_instances_configuration"></a> [instances\_configuration](#input\_instances\_configuration) | Compute instances configuration attributes. | <pre>object({<br>    default_compartment_id      = string,                # the default compartment where all resources are defined. It's overriden by the compartment_ocid attribute within each object.<br>    default_subnet_id           = optional(string),      # the default subnet where all Compute instances are defined. It's overriden by the subnet_id attribute within each Compute instance.<br>    default_ssh_public_key_path = optional(string),      # the default ssh public key path used to access the Compute instance. It's overriden by the ssh_public_key attribute within each Compute instance.<br>    default_kms_key_id          = optional(string),      # the default KMS key to assign as the master encryption key. It's overriden by the kms_key_id attribute within each object.<br>    default_cis_level           = optional(string)       # The CIS OCI Benchmark profile level. Level "1" is be practical and prudent. Level "2" is intended for environments where security is more critical than manageability and usability. Default is "1".<br>    default_defined_tags        = optional(map(string)), # the default defined tags. It's overriden by the defined_tags attribute within each object.<br>    default_freeform_tags       = optional(map(string)), # the default freeform tags. It's overriden by the freeform_tags attribute within each object.<br><br>    instances = map(object({ # the instances to manage in this configuration.<br>      cis_level        = optional(string)<br>      compartment_id   = optional(string)           # the compartment where the instance is created. default_compartment_ocid is used if this is not defined.<br>      shape            = string                     # the instance shape.<br>      name             = string                     # the instance display name.<br>      image = object({ # the base image. You must provider either the id or (name and publisher name).<br>        id = optional(string) # the base image id for creating the instance. It takes precedence over name and publisher_name.<br>        name = optional(string) # the image name to search for in marketplace.<br>        publisher_name = optional(string) # the publisher name of the image name.<br>      })<br>      placement = optional(object({ # placement settings<br>        availability_domain  = optional(number,1) # the instance availability domain. Default is 1.<br>        fault_domain         = optional(number,1) # the instance fault domain. Default is 1.<br>      }))<br>      boot_volume = optional(object({ # boot volume settings<br>        type = optional(string,"PARAVIRTUALIZED") # boot volume emulation type. Valid values: "PARAVIRTUALIZED" (default for platform images), "SCSI", "ISCSI", "IDE", "VFIO".<br>        firmware = optional(string) # firmware used to boot the VM. Valid options: "BIOS" (compatible with both 32 bit and 64 bit operating systems that boot using MBR style bootloaders), "UEFI_64" (default for platform images).<br>        size = optional(number,50) # boot volume size. Default is 50GB (minimum allowed by OCI).<br>        preserve_on_instance_deletion = optional(bool,true) # whether to preserve boot volume after deletion. Default is true.<br>        backup_policy = optional(string,"bronze") # the Oracle managed backup policy. Valid values: "gold", "silver", "bronze". Default is "bronze".<br>      }))<br>      device_mounting = optional(object({ # storage settings. Attributes required by the cloud init script to attach block volumes.<br>        disk_mappings  = string # device mappings to mount block volumes. If providing multiple mapping, separate the mappings with a blank space.<br>        emulation_type = optional(string,"PARAVIRTUALIZED") # Emulation type for attached storage volumes. Valid values: "PARAVIRTUALIZED" (default for platform images), "SCSI", "ISCSI", "IDE", "VFIO". Module supported values for automated attachment: "PARAVIRTUALIZED", "ISCSI".<br>      }))<br>      networking = optional(object({ # networking settings<br>        type                    = optional(string,"PARAVIRTUALIZED") # emulation type for the physical network interface card (NIC). Valid values: "PARAVIRTUALIZED" (default), "E1000", "VFIO".<br>        hostname                = optional(string) # the instance hostname.<br>        assign_public_ip        = optional(bool,false)  # whether to assign the instance a public IP. Default is false.<br>        subnet_id               = optional(string)   # the subnet where the instance is created. default_subnet_id is used if this is not defined.<br>        network_security_groups = optional(list(string))  # list of network security groups the instance should be placed into.<br>      }))<br>      encryption = optional(object({ # encryption settings<br>        kms_key_id = optional(string) # the KMS key to assign as the master encryption key. default_kms_key_id is used if this is not defined.<br>        encrypt_in_transit_at_instance_creation = optional(bool,false) # whether to enable in-transit encryption for the data volume's paravirtualized attachment. Default is false. Applicable at instance creation time only.<br>        encrypt_in_transit_at_instance_update   = optional(bool,false) # whether to enable in-transit encryption for the data volume's paravirtualized attachment. Default is false. Applicable at instance update time only.<br>      }))<br>      flex_shape_settings = optional(object({ # flex shape settings<br>        memory = optional(number,16) # the instance memory for Flex shapes. Default is 16GB.<br>        ocpus  = optional(number,1)  # the instance ocpus number for Flex shapes. Default is 1.<br>      }))<br>      ssh_public_key_path = optional(string) # the SSH public key path used to access the instance.<br>      defined_tags        = optional(map(string)) # instances defined_tags. default_defined_tags is used if this is not defined.<br>      freeform_tags       = optional(map(string)) # instances freeform_tags. default_freeform_tags is used if this is not defined.<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_instances_dependency"></a> [instances\_dependency](#input\_instances\_dependency) | A map of objects containing the externally managed Compute instances this module may depend on. All map objects must have the same type and must contain at least an 'id' attribute (representing the instance OCID) of string type. | `map(any)` | `null` | no |
| <a name="input_kms_dependency"></a> [kms\_dependency](#input\_kms\_dependency) | A map of objects containing the externally managed encryption keys this module may depend on. All map objects must have the same type and must contain at least an 'id' attribute (representing the key OCID) of string type. | `map(any)` | `null` | no |
| <a name="input_module_name"></a> [module\_name](#input\_module\_name) | The module name. | `string` | `"cis-compute"` | no |
| <a name="input_network_dependency"></a> [network\_dependency](#input\_network\_dependency) | A map of objects containing the externally managed network resources this module may depend on. All map objects must have the same type and must contain at least an 'id' attribute (representing the network resource OCID) of string type. | `map(any)` | `null` | no |
| <a name="input_storage_configuration"></a> [storage\_configuration](#input\_storage\_configuration) | Storage configuration attributes. | <pre>object({<br>    default_compartment_id   = optional(string),      # the default compartment where all resources are defined. It's overriden by the compartment_id attribute within each object.<br>    default_kms_key_id       = optional(string),      # the default KMS key to assign as the master encryption key. It's overriden by the kms_key_id attribute within each object.<br>    default_cis_level        = optional(string,"1"),  # The CIS OCI Benchmark profile level. Level "1" is be practical and prudent. Level "2" is intended for environments where security is more critical than manageability and usability. Default is "1".<br>    default_defined_tags     = optional(map(string)), # the default defined tags. It's overriden by the defined_tags attribute within each object.<br>    default_freeform_tags    = optional(map(string)), # the default freeform tags. It's overriden by the frreform_tags attribute within each object.<br><br>    block_volumes = optional(map(object({    # the block volumes to manage in this configuration.<br>      cis_level           = optional(string,"1")<br>      compartment_id      = optional(string) # the compartment where the block volume is created. default_compartment_id is used if this is not defined.<br>      display_name        = string           # the name of the block volume.<br>      availability_domain = optional(number,1)  # the availability domain where to create the block volume.     <br>      volume_size         = optional(number,50) # the size of the block volume.<br>      vpus_per_gb         = optional(number,0)  # the number of vpus per gb. Values are 0(LOW), 10(BALANCE), 20(HIGH), 30-120(ULTRA HIGH)<br>      attach_to_instance = optional(object({ # map to where to attach the block volume.<br>        instance_id = string                # the instance that this volume will be attached to.<br>        device_name = optional(string)      # where to mount the block volume. Should be one of the values from disk_mappings in the instance_configuration.<br>      }))<br>      encryption = optional(object({ # encryption settings<br>        kms_key_id              = optional(string) # the KMS key to assign as the master encryption key. default_kms_key_id is used if this is not defined.<br>        encrypt_in_transit      = optional(bool,true)  # whether the block volume should encrypt traffic. Works only with paravirtualized attachment type. Default is true.<br>      }))<br>      replication = optional(object({ # replication settings<br>        availability_domain = number # the availability domain (AD) to replicate the volume. The AD is picked from the region specified by 'block_volumes_replication_region' variable if defined. Otherwise picked from the region specified by 'region' variable.<br>      }))<br>      backup_policy = optional(string,"bronze") # the Oracle managed backup policy. Valid values: "gold", "silver", "bronze". Default is "bronze".<br>      defined_tags  = optional(map(string))     # block volume defined_tags. default_defined_tags is used if this is not defined.<br>      freeform_tags = optional(map(string))     # block volume freeform_tags. default_freeform_tags is used if this is not defined.<br>    }))),<br><br>    file_storage = optional(object({ # file storage settings.<br>      default_subnet_id = optional(string), # the default subnet used for all file system mount targets. It's overriden by the subnet_id attribute within each mount_target object.<br>      file_systems = map(object({     # the file systems.<br>        cis_level           = optional(string,"1")<br>        compartment_id      = optional(string) # the file system compartment. default_compartment_id is used if this is not defined.<br>        file_system_name    = string           # the file_system name.<br>        availability_domain = optional(number,1)  # the file system availability domain..   <br>        kms_key_id          = optional(string) # the KMS key to assign as the master encryption key. default_kms_key_id is used if this is not defined.<br>        replication         = optional(object({ # replication settings<br>          file_system_target_id = string  # the file system replication target. It must be an existing unexported file system, in the same or in a different region than the source file system.<br>          interval_in_minutes = optional(number,60) # time interval (in minutes) between replication snapshots. Default is 60 minutes.<br>        })) <br>        snapshot_policy_id = optional(string) # the snapshot policy identifying key in the snapshots_policy map. A default snapshot policy is associated with file systems without a snapshot policy.<br>        defined_tags  = optional(map(string)) # file system defined_tags. default_defined_tags is used if this is not defined.<br>        freeform_tags = optional(map(string)) # file system freeform_tags. default_freeform_tags is used if this is not defined.<br>      }))<br>      mount_targets = optional(map(object({ # the mount targets.<br>        compartment_id      = optional(string) # the mount target compartment. default_compartment_id is used if this is not defined.<br>        mount_target_name   = string           # the mount target and export set name.<br>        availability_domain = optional(number,1) # the mount target availability domain.  <br>        subnet_id           = optional(string) # the mount target subnet. default_subnet_id is used if this is not defined.<br>        exports = optional(map(object({<br>          path = string<br>          file_system_id = string<br>          options = optional(list(object({ # optional export options.<br>            source   = string # the source IP or CIDR allowed to access the mount target.<br>            access   = optional(string, "READ_ONLY") # type of access grants. Valid values (case sensitive): READ_WRITE, READ_ONLY.<br>            identity = optional(string, "NONE") # UID and GID remapped to. Valid values(case sensitive): ALL, ROOT, NONE.<br>            use_privileged_source_port = optional(bool, true)   # If true, accessing the file system through this export must connect from a privileged source port.<br>          })))<br>        })))<br>      })))<br>      snapshot_policies = optional(map(object({<br>        name = string<br>        compartment_id = optional(string)<br>        availability_domain = optional(number,1)<br>        prefix = optional(string)<br>        schedules = optional(list(object({<br>          period = string # "DAILY", "WEEKLY", "MONTHLY", "YEARLY"<br>          prefix = optional(string)<br>          time_zone = optional(string,"UTC")<br>          hour_of_day = optional(number,23)<br>          day_of_week = optional(string)<br>          day_of_month = optional(number)<br>          month = optional(string)<br>          retention_in_seconds = optional(number)<br>          start_time = optional(string)<br>        })))<br>        defined_tags  = optional(map(string)) # snapshot policy defined_tags. default_defined_tags is used if this is not defined.<br>        freeform_tags = optional(map(string)) # snapshot policy freeform_tags. default_freeform_tags is used if this is not defined.<br>      })))<br>    }))<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_block_volumes"></a> [block\_volumes](#output\_block\_volumes) | The block volumes |
| <a name="output_file_systems"></a> [file\_systems](#output\_file\_systems) | The file systems |
| <a name="output_instances"></a> [instances](#output\_instances) | The Compute instances |