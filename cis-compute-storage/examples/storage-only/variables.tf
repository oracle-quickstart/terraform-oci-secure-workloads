# Copyright (c) 2023 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

variable "tenancy_ocid" {}
variable "region" { description = "Your tenancy region" }
variable "user_ocid" { default = "" }
variable "fingerprint" { default = "" }
variable "private_key_path" { default = "" }
variable "private_key_password" { default = "" }

variable "block_volumes_replication_region" { 
  description = "The replication region for block volumes. Leave unset if replication occurs to an availability domain within the block volume region."
  default = null
}

variable "storage_configuration" {
  description = "Storage configuration attributes."
  type = object({
    default_compartment_id   = optional(string),      # the default compartment where all resources are defined. It's overriden by the compartment_id attribute within each object.
    default_kms_key_id       = optional(string),      # the default KMS key to assign as the master encryption key. It's overriden by the kms_key_id attribute within each object.
    default_cis_level        = optional(string,"1"),  # The CIS OCI Benchmark profile level. Level "1" is be practical and prudent. Level "2" is intended for environments where security is more critical than manageability and usability. Default is "1".
    default_defined_tags     = optional(map(string)), # the default defined tags. It's overriden by the defined_tags attribute within each object.
    default_freeform_tags    = optional(map(string)), # the default freeform tags. It's overriden by the frreform_tags attribute within each object.

    block_volumes = optional(map(object({    # the block volumes to manage in this configuration.
      cis_level           = optional(string,"1")
      compartment_id      = optional(string) # the compartment where the block volume is created. default_compartment_id is used if this is not defined.
      display_name        = string           # the name of the block volume.
      availability_domain = optional(number,1)  # the availability domain where to create the block volume.     
      volume_size         = optional(number,50) # the size of the block volume.
      vpus_per_gb         = optional(number,0)  # the number of vpus per gb. Values are 0(LOW), 10(BALANCE), 20(HIGH), 30-120(ULTRA HIGH)
      attach_to_instances = optional(list(object({ # map to where to attach the block volume.
        instance_id = string      # the instance that this volume will be attached to.
        device_name = string      # where to mount the block volume. Should be one of the values from disk_mappings in the instance_configuration.
        attachment_type = optional(string,"paravirtualized") # the block volume attachment type. Valid values: "paravirtualized" (default), "iscsi".
        read_only = optional(bool,false) # whether the attachment is read_only or read/write. 
      })))
      encryption = optional(object({ # encryption settings
        kms_key_id              = optional(string) # the KMS key to assign as the master encryption key. default_kms_key_id is used if this is not defined.
        encrypt_in_transit      = optional(bool,false)  # whether the block volume should encrypt traffic. Works only with paravirtualized attachment type. Default is false.
      }))
      replication = optional(object({ # replication settings
        availability_domain = number # the availability domain (AD) to replicate the volume. The AD is picked from the region specified by 'block_volumes_replication_region' variable if defined. Otherwise picked from the region specified by 'region' variable.
      }))
      backup_policy = optional(string,"bronze") # the Oracle managed backup policy. Valid values: "gold", "silver", "bronze". Default is "bronze".
      defined_tags  = optional(map(string))     # block volume defined_tags. default_defined_tags is used if this is not defined.
      freeform_tags = optional(map(string))     # block volume freeform_tags. default_freeform_tags is used if this is not defined.
    }))),

    file_storage = optional(object({ # file storage settings.
      default_subnet_id = optional(string), # the default subnet used for all file system mount targets. It's overriden by the subnet_id attribute within each mount_target object.
      file_systems = map(object({     # the file systems.
        cis_level           = optional(string,"1")
        compartment_id      = optional(string) # the file system compartment. default_compartment_id is used if this is not defined.
        file_system_name    = string           # the file_system name.
        availability_domain = optional(number,1)  # the file system availability domain..   
        kms_key_id          = optional(string) # the KMS key to assign as the master encryption key. default_kms_key_id is used if this is not defined.
        replication         = optional(object({ # replication settings
          is_target         = optional(bool,false) # whether the file system is a replication target. Default is false
          file_system_target_id = optional(string)  # the file system replication target. It must be an existing unexported file system, in the same or in a different region than the source file system.
          interval_in_minutes = optional(number,60) # time interval (in minutes) between replication snapshots. Default is 60 minutes.
        })) 
        snapshot_policy_id = optional(string) # the snapshot policy identifying key in the snapshots_policy map. A default snapshot policy is associated with file systems without a snapshot policy.
        defined_tags  = optional(map(string)) # file system defined_tags. default_defined_tags is used if this is not defined.
        freeform_tags = optional(map(string)) # file system freeform_tags. default_freeform_tags is used if this is not defined.
      }))
      mount_targets = optional(map(object({ # the mount targets.
        compartment_id      = optional(string) # the mount target compartment. default_compartment_id is used if this is not defined.
        mount_target_name   = string           # the mount target and export set name.
        availability_domain = optional(number,1) # the mount target availability domain.  
        subnet_id           = optional(string) # the mount target subnet. default_subnet_id is used if this is not defined.
        exports = optional(list(object({
          path = string # export path. For example: /foo
          file_system_id = string # the file system identifying key the export applies to. It must be one of the keys in file_systems map of objects.
          options = optional(list(object({ # optional export options.
            source   = string # the source IP or CIDR allowed to access the mount target.
            access   = optional(string, "READ_ONLY") # type of access grants. Valid values (case sensitive): READ_WRITE, READ_ONLY.
            identity = optional(string, "NONE") # UID and GID remapped to. Valid values(case sensitive): ALL, ROOT, NONE.
            use_privileged_source_port = optional(bool, true)   # If true, accessing the file system through this export must connect from a privileged source port.
          })))
        })))
      })))
      snapshot_policies = optional(map(object({
        name = string
        compartment_id = optional(string)
        availability_domain = optional(number,1)
        prefix = optional(string)
        schedules = optional(list(object({
          period = string # "DAILY", "WEEKLY", "MONTHLY", "YEARLY"
          prefix = optional(string)
          time_zone = optional(string,"UTC")
          hour_of_day = optional(number,23)
          day_of_week = optional(string)
          day_of_month = optional(number)
          month = optional(string)
          retention_in_seconds = optional(number)
          start_time = optional(string)
        })))
        defined_tags  = optional(map(string)) # snapshot policy defined_tags. default_defined_tags is used if this is not defined.
        freeform_tags = optional(map(string)) # snapshot policy freeform_tags. default_freeform_tags is used if this is not defined.
      })))
    }))
  })
  default = null
}