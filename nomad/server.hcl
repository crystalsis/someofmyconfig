## General Parameters

##region (string: "global")
#Specifies the region the Nomad agent is a member of. 
#A region typically maps to a geographic region, for example us, with potentially multiple zones, 
#which map to datacenters such as us-west and us-east.
region    = "A1"

##datacenter (string: "dc1")
#Specifies the data center of the local agent. All members of a datacenter should share a local LAN connection.
datacenter = "ams"

##name (string: [hostname])
#Specifies the name of the local node. This value is used to identify individual agents. 
#When specified on a server, the name must be unique within the region.
name = "kcl"

##data_dir (string: required)
#Specifies a local directory used to store agent state. 
#Client nodes use this directory by default to store temporary allocation data as well as cluster information. 
#Server nodes use this directory to store cluster state, including the replicated log and snapshot data. 
#This must be specified as an absolute path.
#WARNING: This directory must not be set to a directory that is included in the chroot if you use the exec driver.
data_dir  = "/var/lib/nomad"

#bind_addr (string: "0.0.0.0")
#Specifies which address the Nomad agent should bind to for network services, 
#including the HTTP interface as well as the internal gossip protocol and RPC mechanism. 
#This should be specified in IP format, and can be used to easily bind all network services to the same address. 
#It is also possible to bind the individual services to different addresses using the addresses configuration option. 
#Dev mode (-dev) defaults to localhost. The value supports go-sockaddr/template format.
bind_addr = "0.0.0.0"

##addresses (Addresses: see below)
#Specifies the bind address for individual network services. 
#Any values configured in this stanza take precedence over the default bind_addr. 
#The values support go-sockaddr/template format.
addresses {
  #http - The address the HTTP server is bound to. This is the most common bind address to change.
  http = "1.2.3.4"
  #rpc - The address to bind the internal RPC interfaces to. Should be exposed only to other cluster members if possible.
  rpc  = "1.2.3.4"
  #serf - The address used to bind the gossip layer to. Both a TCP and UDP listener will be exposed on this address. 
  #Should be exposed only to other cluster members if possible.
  serf = "1.2.3.4:5648"
}

##advertise (Advertise: see below)
#Specifies the advertise address for individual network services. 
#This can be used to advertise a different address to the peers of a server or a client node to support more complex network configurations such as NAT. 
#This configuration is optional, and defaults to the bind address of the specific network service if it is not provided. 
#Any values configured in this stanza take precedence over the default bind_addr.
#
#If the bind address is 0.0.0.0 then the address private IP found is advertised. You may advertise an alternate port as well. 
#The values support go-sockaddr/template format.
#
advertise {
  #http - The address to advertise for the HTTP interface. 
  #This should be reachable by all the nodes from which end users are going to use the Nomad CLI tools.
  http = "1.2.3.4"
  #rpc - The address advertised to Nomad client nodes. 
  #This allows advertising a different RPC address than is used by Nomad Servers such that the clients can connect to the Nomad servers if they are behind a NAT.
  rpc  = "1.2.3.4"
  #serf - The address advertised for the gossip layer. 
  #This address must be reachable from all server nodes. It is not required that clients can reach this address. 
  #Nomad servers will communicate to each other over RPC using the advertised Serf IP and advertised RPC Port.
  serf = "1.2.3.4:5648"
}

##ports (Port: see below)
#Specifies the network ports used for different services required by the Nomad agent.
#The default values are:
#
#    ports {
#      http = 4646
#      rpc  = 4647
#      serf = 4648
#    }
ports {
  #http - The port used to run the HTTP server.
  http = 4646
  #rpc - The port used for internal RPC communication between agents and servers, 
  #and for inter-server traffic for the consensus algorithm (raft).
  rpc  = 4647
  #serf - The port used for the gossip protocol for cluster membership. 
  #Both TCP and UDP should be routable between the server nodes on this port.
  serf = 4648
}

##disable_anonymous_signature (bool: false)
#Specifies if Nomad should provide an anonymous signature for de-duplication with the update check.
disable_anonymous_signature = false

##disable_update_check (bool: false)
#Specifies if Nomad should not check for updates and security bulletins.
disable_update_check = false

##enable_debug (bool: false)
#Specifies if the debugging HTTP endpoints should be enabled. 
#These endpoints can be used with profiling tools to dump diagnostic information about Nomad's internals.
enable_debug = false

##enable_syslog (bool: false)
#Specifies if the agent should log to syslog. This option only works on Unix based systems.
enable_syslog = false

##syslog_facility (string: "LOCAL0")
#Specifies the syslog facility to write to. This has no effect unless enable_syslog is true.
syslog_facility = "LOCAL0"

##http_api_response_headers (map<string|string>: nil)
#Specifies user-defined headers to add to the HTTP API responses.

##leave_on_interrupt (bool: false)
#Specifies if the agent should gracefully leave when receiving the interrupt signal. 
#By default, the agent will exit forcefully on any signal. 
#This value should only be set to true on server agents if it is expected that a terminated server instance will never join the cluster again.
leave_on_interrupt = false

##leave_on_terminate (bool: false)
#Specifies if the agent should gracefully leave when receiving the terminate signal. 
#By default, the agent will exit forcefully on any signal. 
#This value should only be set to true on server agents if it is expected that a terminated server instance will never join the cluster again.
leave_on_terminate = false

##log_level (string: "INFO")
#Specifies the verbosity of logs the Nomad agent will output. 
#Valid log levels include WARN, INFO, or DEBUG in increasing order of verbosity.
log_level = WARN

##log_json (bool: false)
#Output logs in a JSON format.
log_json = false

##plugin_dir (string: "[data_dir]/plugins")
#Specifies the directory to use for looking up plugins. 
#By default, this is the top-level data_dir suffixed with "plugins", like "/opt/nomad/plugins". 
#This must be an absolute path.
plugin_dir = "[data_dir]/plugins"

##plugin (Plugin: nil)
#Specifies configuration for a specific plugin. 
#The plugin stanza may be repeated, once for each plugin being configured. 
#The key of the stanza is the plugin's executable name relative to the plugin_dir.

##acl (ACL: nil)
#Specifies configuration which is specific to ACLs.
#acl Stanza
#Placement	acl
#The acl stanza configures the Nomad agent to enable ACLs and tunes various ACL parameters.
#
# acl {
#   enabled = true
#   token_ttl = "30s"
#   policy_ttl = "60s"
# }
#
acl {
  #acl Parameters
  #enabled (bool: false) - Specifies if ACL enforcement is enabled. 
  #All other client configuration options depend on this value.
  enabled = true
  #token_ttl (string: "30s") - Specifies the maximum time-to-live (TTL) for cached ACL tokens. 
  #This does not affect servers, since they do not cache tokens. Setting this value lower reduces how stale a token can be, 
  #but increases the request load against servers. If a client cannot reach a server, for example because of an outage, 
  #the TTL will be ignored and the cached value used.
  token_ttl = "30s"
  #policy_ttl (string: "30s") - Specifies the maximum time-to-live (TTL) for cached ACL policies. 
  #This does not affect servers, since they do not cache policies. Setting this value lower reduces how stale a policy can be, 
  #but increases the request load against servers. If a client cannot reach a server, for example because of an outage, 
  #the TTL will be ignored and the cached value used.
  policy_ttl = "60s"
  #replication_token (string: "") - Specifies the Secret ID of the ACL token to use for replicating policies and tokens. 
  #This is used by servers in non-authoritative region to mirror the policies and tokens into the local region.
  replication_token = "foo-bar"
}

##sentinel (Sentinel: nil)
#Specifies configuration for Sentinel policies.

##server (Server: nil)
#Specifies configuration which is specific to the Nomad server.
##server Stanza
#Placement	server
#The server stanza configures the Nomad agent to operate in server mode to participate in scheduling decisions, 
#register with service discovery, handle join failures, and more.
#
#    server {
#      enabled          = true
#      bootstrap_expect = 3
#      server_join {
#        retry_join = [ "1.1.1.1", "2.2.2.2" ]
#        retry_max = 3
#        retry_interval = "15s"
#      }
#    }
server {
  #server Parameters
  ##enabled (bool: false)
  #Specifies if this agent should run in server mode. All other server options depend on this value being set.
  enabled          = true

  ##bootstrap_expect (int: required)
  #Specifies the number of server nodes to wait for before bootstrapping. 
  #It is most common to use the odd-numbered integers 3 or 5 for this value, depending on the cluster size. 
  #A value of 1 does not provide any fault tolerance and is not recommended for production use cases.
  bootstrap_expect = 3

  ##data_dir (string: "[data_dir]/server")
  #Specifies the directory to use - for server-specific data, including the replicated log. 
  #By default, this is - the top-level data_dir suffixed with "server", like "/opt/nomad/server". This must be an absolute path.
  data_dir = "[data_dir]/server"

  ##server_join (server_join: nil)
  #Specifies how the Nomad server will connect to other Nomad servers. 
  #The retry_join fields may directly specify the server address or use go-discover syntax for auto-discovery. 
  #See the server_join documentation for more detail.
  
  ##enabled_schedulers (array<string>: [all])
  #Specifies which sub-schedulers this server will handle. 
  #This can be used to restrict the evaluations that worker threads will dequeue for processing.

  ##authoritative_region (string: "")
  #Specifies the authoritative region, which provides a single source of truth for global configurations 
  #such as ACL Policies and global ACL tokens. 
  #Non-authoritative regions will replicate from the authoritative to act as a mirror. 
  #By default, the local region is assumed to be authoritative.

  ##encrypt (string: "")
  #Specifies the secret key to use for encryption of Nomad server's gossip network traffic. 
  #This key must be 16 bytes that are base64-encoded. 
  #The provided key is automatically persisted to the data directory and loaded automatically whenever the agent is restarted. 
  #This means that to encrypt Nomad server's gossip protocol, 
  #this option only needs to be provided once on each agent's initial startup sequence. 
  #If it is provided after Nomad has been initialized with an encryption key, 
  #then the provided key is ignored and a warning will be displayed. 
  #See the encryption documentation for more details on this option and its impact on the cluster.
  
  ##node_gc_threshold (string: "24h")
  #Specifies how long a node must be in a terminal state before it is garbage collected and purged from the system. 
  #This is specified using a label suffix like "30s" or "1h".

  ##job_gc_threshold (string: "4h")
  #Specifies the minimum time a job must be in the terminal state before it is eligible for garbage collection. 
  #This is specified using a label suffix like "30s" or "1h".

  ##eval_gc_threshold (string: "1h")
  #Specifies the minimum time an evaluation must be in the terminal state before it is eligible for garbage collection. 
  #This is specified using a label suffix like "30s" or "1h".

  ##deployment_gc_threshold (string: "1h")
  #Specifies the minimum time a deployment must be in the terminal state before it is eligible for garbage collection. 
  #This is specified using a label suffix like "30s" or "1h".

  ##heartbeat_grace (string: "10s")
  #Specifies the additional time given as a grace period beyond the heartbeat TTL of nodes to account for network 
  #and processing delays as well as clock skew. This is specified using a label suffix like "30s" or "1h".

  ##min_heartbeat_ttl (string: "10s")
  #Specifies the minimum time between node heartbeats. This is used as a floor to prevent excessive updates. 
  #This is specified using a label suffix like "30s" or "1h". 
  #Lowering the minimum TTL is a tradeoff as it lowers failure detection time of nodes at the tradeoff of false positives 
  #and increased load on the leader.

  ##max_heartbeats_per_second (float: 50.0)
  #Specifies the maximum target rate of heartbeats being processed per second. 
  #This allows the TTL to be increased to meet the target rate. 
  #Increasing the maximum heartbeats per second is a tradeoff as it lowers failure detection time of nodes at 
  #the tradeoff of false positives and increased load on the leader.

  ##non_voting_server (bool: false)
  #(Enterprise-only) Specifies whether this server will act as a non-voting member of the cluster to help provide read scalability.

  ##num_schedulers (int: [num-cores])
  #Specifies the number of parallel scheduler threads to run. 
  #This can be as many as one per core, or 0 to disallow this server from making any scheduling decisions. 
  #This defaults to the number of CPU cores.

  ##protocol_version (int: 1)
  #Specifies the Nomad protocol version to use when communicating with other Nomad servers. 
  #This value is typically not required as the agent internally knows the latest version, but may be useful in some upgrade scenarios.

  ##raft_protocol (int: 2)
  #Specifies the Raft protocol version to use when communicating with other Nomad servers. 
  #This affects available Autopilot features and is typically not required as the agent internally knows the latest version, 
  #but may be useful in some upgrade scenarios.

  ##redundancy_zone (string: "")
  #(Enterprise-only) Specifies the redundancy zone that this server will be a part of for Autopilot management. 
  #For more information, see the Autopilot Guide.

  ##rejoin_after_leave (bool: false)
  #Specifies if Nomad will ignore a previous leave and attempt to rejoin the cluster when starting. 
  #By default, Nomad treats leave as a permanent intent and does not attempt to join the cluster again when starting. 
  #This flag allows the previous state to be used to rejoin the cluster.

  ##upgrade_version (string: "")
  #A custom version of the format X.Y.Z to use in place of the Nomad version when custom upgrades are enabled in Autopilot. 
  #For more information, see the Autopilot Guide.
}

##client (Client: nil)
#Specifies configuration which is specific to the Nomad client.
#client Stanza
#Placement	client
#The client stanza configures the Nomad agent to accept jobs as assigned by the Nomad server, 
#join the cluster, and specify driver-specific configuration.
#
#    client {
#      enabled = true
#      servers = ["1.2.3.4:4647", "5.6.7.8:4647"]
#    }
#Plugin Options
#Nomad 0.9 now supports pluggable drivers. Operators should use the new plugin syntax to modify driver configuration. 
#To find the plugin options supported by each individual Nomad driver, please see the drivers documentation. 
#The pre-0.9 client.options stanza will be supported in 0.9 for backward compatibility (except for the lxc driver) 
#but will be removed in a future release.
client {
  #client Parameters
  ##enabled (bool: false)
  #Specifies if client mode is enabled. All other client configuration options depend on this value.
  enabled       = true
  ##alloc_dir (string: "[data_dir]/alloc")
  #Specifies the directory to use for allocation data. By default, this is the top-level data_dir suffixed with "alloc", 
  #like "/opt/nomad/alloc". This must be an absolute path.
  alloc_dir = "[data_dir]/alloc"

  ##chroot_env (ChrootEnv: nil)
  #Specifies a key-value mapping that defines the chroot environment for jobs using the Exec and Java drivers.
  #chroot_env Parameters
  #Drivers based on isolated fork/exec implement file system isolation using chroot on Linux. 
  #The chroot_env map allows the chroot environment to be configured using source paths on the host operating system. 
  #The mapping format is:
  #
  #source_path -> dest_path
  #The following example specifies a chroot which contains just enough to run the ls utility:
  #
  #    client {
  #      chroot_env {
  #        "/bin/ls"           = "/bin/ls"
  #        "/etc/ld.so.cache"  = "/etc/ld.so.cache"
  #        "/etc/ld.so.conf"   = "/etc/ld.so.conf"
  #        "/etc/ld.so.conf.d" = "/etc/ld.so.conf.d"
  #        "/lib"              = "/lib"
  #        "/lib64"            = "/lib64"
  #      }
  #    }
  #When chroot_env is unspecified, the exec driver will use a default chroot environment with the most commonly used parts of the operating system. 
  #Please see the Nomad exec driver documentation for the full list.

  chroot_env {
    "/bin/ls"           = "/bin/ls"
    "/etc/ld.so.cache"  = "/etc/ld.so.cache"
    "/etc/ld.so.conf"   = "/etc/ld.so.conf"
    "/etc/ld.so.conf.d" = "/etc/ld.so.conf.d"
    "/lib"              = "/lib"
    "/lib64"            = "/lib64"
  }

  ##max_kill_timeout (string: "30s")
  #Specifies the maximum amount of time a job is allowed to wait to exit. Individual jobs may customize their own kill timeout, 
  #but it may not exceed this value.
  max_kill_timeout = "30s"

  ##disable_remote_exec (bool: false)
  #Specifies if the client should disable remote task execution to tasks running on this client.
  disable_remote_exec = true

  ##meta (map[string]string: nil)
  #Specifies a key-value map that annotates with user-defined metadata.
  meta {

  }

  ##network_interface (string: varied)
  #Specifies the name of the interface to force network fingerprinting on. When run in dev mode, 
  #this defaults to the loopback interface. When not in dev mode, the interface attached to the default route is used. 
  #All IP addresses except those scoped local for IPV6 on the chosen interface are fingerprinted. 
  #The scheduler chooses from those IP addresses when allocating ports for tasks.
  network_interface = "enp3s0"

  ##network_speed (int: 0)
  #Specifies an override for the network link speed. This value, if set, overrides any detected or defaulted link speed. 
  #Most clients can determine their speed automatically, and thus in most cases this should be left unset.
  network_speed = 1000
 
  ##cpu_total_compute (int: 0)
  #Specifies an override for the total CPU compute. This value should be set to # Cores * Core MHz. For example, 
  #a quad-core running at 2 GHz would have a total compute of 8000 (4 * 2000). 
  #Most clients can determine their total CPU compute automatically, and thus in most cases this should be left unset.
  cpu_total_compute = 2000

  ##memory_total_mb (int:0)
  #Specifies an override for the total memory. If set, this value overrides any detected memory.
  memory_total_mb = 12000

  ##node_class (string: "")
  #Specifies an arbitrary string used to logically group client nodes by user-defined class. 
  #This can be used during job placement as a filter.
  node_class = ""

  ##options (Options: nil)
  #Specifies a key-value mapping of internal configuration for clients, such as for driver configuration.
  ##options Parameters
  #Note: client configuration options for drivers will soon be deprecated. See the plugin stanza documentation for more information.
  #
  #The following is not an exhaustive list of options for only the Nomad client. 
  #To find the options supported by each individual Nomad driver, please see the drivers documentation.
  options = {
  }

  ##reserved (Reserved: nil)
  #Specifies that Nomad should reserve a portion of the node's resources from receiving tasks. 
  #This can be used to target a certain capacity usage for the node. For example, 
  #20% of the node's CPU could be reserved to target a CPU utilization of 80%.
  reserved {
    #reserved Parameters
    ##cpu (int: 0) - Specifies the amount of CPU to reserve, in MHz.
    cpu = 1000

    ##memory (int: 0) - Specifies the amount of memory to reserve, in MB.
    memory = 1000

    ##disk (int: 0) - Specifies the amount of disk to reserve, in MB.
    disk = 1000

    ##reserved_ports (string: "") - Specifies a comma-separated list of ports to reserve on all fingerprinted network devices. 
    #Ranges can be specified by using a hyphen separated the two inclusive ends.
    reserved_ports = ""
  }
 
  ##servers (array<string>: [])
  #Specifies an array of addresses to the Nomad servers this client should join. 
  #This list is used to register the client with the server nodes and advertise the available resources so that 
  #the agent can receive work. This may be specified as an IP address or DNS, with or without the port. If the port is omitted, 
  #the default port of 4647 is used.
  servers = ["1.2.3.4:4647", "5.6.7.8:4647"]

  ##server_join (server_join: nil)
  #Specifies how the Nomad client will connect to Nomad servers. The start_join field is not supported on the client. 
  #The retry_join fields may directly specify the server address or use go-discover syntax for auto-discovery. 
  #See the documentation for more detail.
  server_join {

  }

  ##state_dir (string: "[data_dir]/client")
  #Specifies the directory to use to store client state. By default, this is - the top-level data_dir suffixed with "client", 
  #like "/opt/nomad/client". This must be an absolute path.
  state_dir = "[data_dir]/client"

  ##gc_interval (string: "1m")
  #Specifies the interval at which Nomad attempts to garbage collect terminal allocation directories.
  gc_interval = "1m"

  ##gc_disk_usage_threshold (float: 80)
  #Specifies the disk usage percent which Nomad tries to maintain by garbage collecting terminal allocations.
  gc_disk_usage_threshold = 80

  ##gc_inode_usage_threshold (float: 70)
  #Specifies the inode usage percent which Nomad tries to maintain by garbage collecting terminal allocations.
  gc_inode_usage_threshold = 70

  ##gc_max_allocs (int: 50)
  #Specifies the maximum number of allocations which a client will track before triggering a garbage collection of terminal allocations. 
  #This will not limit the number of allocations a node can run at a time, 
  #however after gc_max_allocs every new allocation will cause terminal allocations to be GC'd.
  gc_max_allocs = 50

  ##gc_parallel_destroys (int: 2)
  #Specifies the maximum number of parallel destroys allowed by the garbage collector. 
  #This value should be relatively low to avoid high resource usage during garbage collections.
  gc_parallel_destroys = 2

  ##no_host_uuid (bool: true)
  #By default a random node UUID will be generated, but setting this to false will use the system's UUID. 
  #Before Nomad 0.6 the default was to use the system UUID.
  no_host_uuid = true
}

##consul (Consul: nil)
#Specifies configuration for connecting to Consul.
##consul Stanza
#Placement	consul
#The consul stanza configures the Nomad agent's communication with Consul for service discovery and key-value integration. 
#When configured, tasks can register themselves with Consul, and the Nomad cluster can automatically bootstrap itself.
#
#    consul {
#      address = "127.0.0.1:8500"
#      auth    = "admin:password"
#      token   = "abcd1234"
#    }
#A default consul stanza is automatically merged with all Nomad agent configurations. 
#These sane defaults automatically enable Consul integration if Consul is detected on the system. 
#This allows for seamless bootstrapping of the cluster with zero configuration. 
#To put it another way: 
#if you have a Consul agent running on the same host as the Nomad agent with the default configuration, 
#Nomad will automatically connect and configure with Consul.
#
#An important requirement is that each Nomad agent talks to a unique Consul agent. 
#Nomad agents should be configured to talk to Consul agents and not Consul servers. 
#If you are observing flapping services, you may have have multiple Nomad agents talking to the same Consul agent. 
#As such avoid configuring Nomad to talk to Consul via DNS such as consul.service.consul
#
#If the local Consul agent is configured and accessible by the Nomad agents, 
#the Nomad cluster will automatically bootstrap provided server_auto_join, client_auto_join, and auto_advertise are all enabled (which is the default).
consul {
  #consul Parameters
  ##address (string: "127.0.0.1:8500")
  #Specifies the address to the local Consul agent, given in the format host:port. 
  #Supports Unix sockets with the format: unix:///tmp/consul/consul.sock
  address = "1.2.3.4:8500"

  ##auth (string: "")
  #Specifies the HTTP Basic Authentication information to use for access to the Consul Agent, 
  #given in the format username:password.
  auth = "foo|bar"

  ##auto_advertise (bool: true)
  #Specifies if Nomad should advertise its services in Consul. 
  #The services are named according to server_service_name and client_service_name. 
  #Nomad servers and clients advertise their respective services, each tagged appropriately with either http or rpc tag. 
  #Nomad servers also advertise a serf tagged service.
  auto_advertise = true

  ##ca_file (string: "")
  #Specifies an optional path to the CA certificate used for Consul communication. 
  #This defaults to the system bundle if unspecified.

  ##cert_file (string: "")
  #Specifies the path to the certificate used for Consul communication. If this is set then you need to also set key_file.

  ##checks_use_advertise (bool: false)
  #Specifies if Consul health checks should bind to the advertise address. By default, this is the bind address.
  checks_use_advertise = false
  
  ##client_auto_join (bool: true)
  #Specifies if the Nomad clients should automatically discover servers in the same region by searching for 
  #the Consul service name defined in the server_service_name option. 
  #The search occurs if the client is not registered with any servers or it is unable to heartbeat to the leader of the region, 
  #in which case it may be partitioned and searches for other servers.
  client_auto_join = true

  ##client_service_name (string: "nomad-client")
  #Specifies the name of the service in Consul for the Nomad clients.
  client_service_name = "n1"

  ##client_http_check_name (string: "Nomad Client HTTP Check")
  #Specifies the HTTP health check name in Consul for the Nomad clients.
  client_http_check_name = "n1"

  ##key_file (string: "")
  #Specifies the path to the private key used for Consul communication. If this is set then you need to also set cert_file.

  ##server_service_name (string: "nomad")
  #Specifies the name of the service in Consul for the Nomad servers.
  server_service_name = "n1"

  ##server_http_check_name (string: "Nomad Server HTTP Check")
  #Specifies the HTTP health check name in Consul for the Nomad servers.
  server_http_check_name = "n1"

  ##server_serf_check_name (string: "Nomad Server Serf Check")
  #Specifies the Serf health check name in Consul for the Nomad servers.
  server_serf_check_name = "n1"

  ##server_rpc_check_name (string: "Nomad Server RPC Check")
  #Specifies the RPC health check name in Consul for the Nomad servers.
  server_rpc_check_name = "n1"

  ##server_auto_join (bool: true)
  #Specifies if the Nomad servers should automatically discover and join other Nomad servers by searching for 
  #the Consul service name defined in the server_service_name option. 
  #This search only happens if the server does not have a leader.
  server_auto_join = true

  ##ssl (bool: false)
  #Specifies if the transport scheme should use HTTPS to communicate with the Consul agent.
  ssl = false

  ##token (string: "")
  #Specifies the token used to provide a per-request ACL token. This option overrides the Consul Agent's default token. 
  #If the token is not set here or on the Consul agent, it will default to Consul's anonymous policy, which may or may not allow writes.
  token = ""

  ##verify_ssl (bool: true)
  #Specifies if SSL peer verification should be used when communicating to the Consul API client over HTTPS
  verify_ssl = true
}

##tls (TLS: nil)
#Specifies configuration for TLS.

##vault (Vault: nil)
#Specifies configuration for connecting to Vault.

##autopilot Stanza
#Placement	autopilot
#The autopilot stanza configures the Nomad agent to configure Autopilot behavior. 
#For more information about Autopilot, see the Autopilot Guide.
#
#    autopilot {
#        cleanup_dead_servers = true
#        last_contact_threshold = "200ms"
#        max_trailing_logs = 250
#        server_stabilization_time = "10s"
#        enable_redundancy_zones = false
#        disable_upgrade_migration = false
#        enable_custom_upgrades = false
#    }
autopilot {
  ##»autopilot Parameters
  ##cleanup_dead_servers (bool: true)
  #Specifies automatic removal of dead server nodes periodically and whenever a new server is added to the cluster.
  cleanup_dead_servers = true

  ##last_contact_threshold (string: "200ms")
  #Specifies the maximum amount of time a server can go without contact from the leader before being considered unhealthy. 
  #Must be a duration value such as 10s.
  last_contact_threshold = "200ms"

  ##max_trailing_logs (int: 250)
  #specifies the maximum number of log entries that a server can trail the leader by before being considered unhealthy.
  max_trailing_logs = 250

  ##server_stabilization_time (string: "10s")
  #Specifies the minimum amount of time a server must be stable in the 'healthy' state before being added to the cluster. 
  #Only takes effect if all servers are running Raft protocol version 3 or higher. Must be a duration value such as 30s.
  server_stabilization_time = "10s"

  ##enable_redundancy_zones (bool: false)
  #(Enterprise-only) Controls whether Autopilot separates servers into zones for redundancy, 
  #in conjunction with the redundancy_zone parameter. Only one server in each zone can be a voting member at one time.
  enable_redundancy_zones = false

  ##disable_upgrade_migration (bool: false)
  #(Enterprise-only) Disables Autopilot's upgrade migration strategy in Nomad Enterprise of waiting until 
  #enough newer-versioned servers have been added to the cluster before promoting any of them to voters.
  disable_upgrade_migration = false

  ##enable_custom_upgrades (bool: false)
  #(Enterprise-only) Specifies whether to enable using custom upgrade versions when performing migrations, 
  #in conjunction with the upgrade_version parameter.
  enable_custom_upgrades = false
}