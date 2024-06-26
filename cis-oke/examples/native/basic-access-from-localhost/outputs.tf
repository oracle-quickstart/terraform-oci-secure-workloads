
# Copyright (c) 2023, Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


output "clusters" {
  value = module.oke.clusters
}

output "node_pools" {
  value = module.oke.node_pools
}

output "sessions" {
  value = module.bastion.sessions
}
