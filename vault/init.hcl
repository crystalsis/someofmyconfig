ui = true

listener "tcp" {
  address = "127.0.0.1:8200"
  cluster_address = "127.0.0.1:8201"
  max_request_size = "33554432"
  max_request_duration = "90s"
  proxy_protocol_behavior = "allow_authorized"
  proxy_protocol_authorized_addrs = []
  tls_disable = true
}