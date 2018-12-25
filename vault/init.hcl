storage "file" {
  path = "/etc/vault.d/data"
}

ha_storage "mysql" {
  address = "127.0.0.1:3306"
  username = "vault"
  password = ""
  database = "vault"
  table = "vault"
  max_parallel = "128"
  ha_enabled = "true"
  lock_table = "vault_lock"
  tls_ca_file = ""
}

listener "tcp" {
  address = "127.0.0.1:8200"
  cluster_address = "127.0.0.1:8201"
  max_request_size = "33554432"
  max_request_duration = "90s"
  proxy_protocol_behavior = "allow_authorized"
  proxy_protocol_authorized_addrs = []
  tls_disable = true
}

cluster_name = "v1"
cache_size = "32000"
disable_cache = false
disable_mlock = false
plugin_directory = "/etc/vault.d/plugins"
telemetry {
  disable_hostname = true
}
log_level = "info"
default_lease_ttl = "768h"
max_lease_ttl = "768h"
default_max_request_duration = "90s"
raw_storage_endpoint = false
ui = true
pid_file = "/var/run/vault.pid"
api_addr = "http://127.0.0.1:8200"
cluster_addr = "http://127.0.0.1:8201"
disable_clustering = false