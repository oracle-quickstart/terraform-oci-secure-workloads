# Copyright (c) 2023 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      configuration_aliases = [ oci, oci.block_volumes_replication_region ]
    }
  }
}

