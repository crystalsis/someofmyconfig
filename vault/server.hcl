##Vault Configuration
#Outside of development mode, Vault servers are configured using a file. The format of this file is HCL
##Parameters

#listener (Listener: <required>)
#Configures how Vault is listening for API requests.

##listener Stanza
#The listener stanza configures the addresses and ports on which Vault will respond to requests.
#At this time, there is only one listener - TCP.

listener "tcp" {
  ##tcp Listener
  #The TCP listener configures Vault to listen on a TCP address/port.
  #
  #    listener "tcp" {
  #      address = "127.0.0.1:8200"
  #    }
  #
  #The listener stanza may be specified more than once to make Vault listen on multiple interfaces.
  #If you configure multiple listeners you also need to specify api_addr and cluster_addr so Vault will advertise the correct address to other nodes.

  ##tcp Listener Examples

  ##Configuring TLS
  #This example shows enabling a TLS listener.
  #
  #    listener "tcp" {
  #      tls_cert_file = "/etc/certs/vault.crt"
  #      tls_key_file  = "/etc/certs/vault.key"
  #    }
  #
  ##Listening on Multiple Interfaces
  #This example shows Vault listening on a private interface, as well as localhost.
  #
  #    listener "tcp" {
  #      address = "127.0.0.1:8200"
  #    }
  #
  #    listener "tcp" {
  #      address = "10.0.0.5:8200"
  #    }
  #

  #    # Advertise the non-loopback interface
  #    api_addr = "https://10.0.0.5:8200"
  #    cluster_addr = "https://10.0.0.5:8201"
  ##tcp Listener Parameters

  #address (string: "127.0.0.1:8200")
  #Specifies the address to bind to for listening.
  address = "127.0.0.1:8200"

  #cluster_address (string: "127.0.0.1:8201")
  #Specifies the address to bind to for cluster server-to-server requests.
  #This defaults to one port higher than the value of address.
  #This does not usually need to be set, but can be useful in case Vault servers are isolated from each other in such a way that they need to hop through a TCP load balancer or some other scheme in order to talk.
  cluster_address = "127.0.0.1:8201"

  #max_request_size (int: 33554432)
  #Specifies a hard maximum allowed request size, in bytes.
  #Defaults to 32 MB. Specifying a number less than or equal to 0 turns off limiting altogether.
  max_request_size = 33554432

  #max_request_duration (string: "90s")
  #Specifies the maximum request duration allowed before Vault cancels the request.
  #This overrides default_max_request_duration for this listener.
  max_request_duration = "90s"

  #proxy_protocol_behavior (string: "")
  #When specified, enables a PROXY protocol version 1 behavior for the listener. Accepted Values:
      #|use_always - The client's IP address will always be used.
      #|allow_authorized - If the source IP address is in the proxy_protocol_authorized_addrs list, the client's IP address will be used.
        #If the source IP is not in the list, the source IP address will be used.
      #|deny_unauthorized - The traffic will be rejected if the source IP address is not in the proxy_protocol_authorized_addrs list.
  proxy_protocol_behavior = "allow_authorized"

  #proxy_protocol_authorized_addrs (string: <required-if-enabled> or array: <required-if-enabled> )
  #Specifies the list of allowed source IP addresses to be used with the PROXY protocol.
  #Not required if proxy_protocol_behavior is set to use_always.
  #Source IPs should be comma-delimited if provided as a string.
  #At least one source IP must be provided, proxy_protocol_authorized_addrs cannot be an empty array or string.
  proxy_protocol_authorized_addrs = ["172.21.0.1"]

  #tls_disable (string: "false")
  #Specifies if TLS will be disabled. Vault assumes TLS by default, so you must explicitly disable TLS to opt-in to insecure communication.
  tls_disable = "true"

  #tls_cert_file (string: <required-if-enabled>, reloads-on-SIGHUP)
  #Specifies the path to the certificate for TLS.
  #To configure the listener to use a CA certificate, concatenate the primary certificate and the CA certificate together.
  #The primary certificate should appear first in the combined file.
  #On SIGHUP, the path set here at Vault startup will be used for reloading the certificate; modifying this value while Vault is running will have no effect for SIGHUPs.
  #tls_cert_file = "/opt/vault/cert"

  #tls_key_file (string: <required-if-enabled>, reloads-on-SIGHUP)
  #Specifies the path to the private key for the certificate.
  #If the key file is encrypted, you will be prompted to enter the passphrase on server startup.
  #The passphrase must stay the same between key files when reloading your configuration using SIGHUP.
  #On SIGHUP, the path set here at Vault startup will be used for reloading the certificate; modifying this value while Vault is running will have no effect for SIGHUPs.
  #tls_key_file = "/opt/vault/key"

  #tls_min_version (string: "tls12")
  #Specifies the minimum supported version of TLS. Accepted values are "tls10", "tls11" or "tls12".
    #Warning: TLS 1.1 and lower are generally considered insecure.
  #tls_min_version = "tls12"

  #tls_cipher_suites (string: "")
  #Specifies the list of supported ciphersuites as a comma-separated-list.
  #The list of all available ciphersuites is available in the Golang TLS documentation.
  #tls_cipher_suites = ""

  #tls_prefer_server_cipher_suites (string: "false")
  #Specifies to prefer the server's ciphersuite over the client ciphersuites.
  #tls_prefer_server_cipher_suites = "false"

  #tls_require_and_verify_client_cert (string: "false")
  #Turns on client authentication for this listener; the listener will require a presented client cert that successfully validates against system CAs.
  #tls_require_and_verify_client_cert = "false"

  #tls_client_ca_file (string: "")
  #PEM-encoded Certificate Authority file used for checking the authenticity of client.
  #tls_client_ca_file = "/opt/vault/ca"

  #tls_disable_client_certs (string: "false")
  #Turns off client authentication for this listener.
  #The default behavior (when this is false) is for Vault to request client certificates when available.
  #tls_disable_client_certs = "false"

  #x_forwarded_for_authorized_addrs (string: <required-to-enable>)
  #Specifies the list of source IP CIDRs for which an X-Forwarded-For header will be trusted.
  #Comma-separated list or JSON array. This turns on X-Forwarded-For support.
  #x_forwarded_for_authorized_addrs = ""

  #x_forwarded_for_hop_skips (string: "0")
  #The number of addresses that will be skipped from the rear of the set of hops.
  #For instance, for a header value of 1.2.3.4, 2.3.4.5, 3.4.5.6, if this value is set to "1", the address that will be used as the originating client IP is 2.3.4.5.
  #x_forwarded_for_hop_skips = "0"

  #x_forwarded_for_reject_not_authorized (string: "true")
  #If set false, if there is an X-Forwarded-For header in a connection from an unauthorized address, the header will be ignored and the client connection used as-is, rather than the client connection rejected.
  #x_forwarded_for_reject_not_authorized = "true"

  #x_forwarded_for_reject_not_present (string: "true")
  #If set false, if there is no X-Forwarded-For header or it is empty, the client address will be used as-is, rather than the client connection rejected.
  #x_forwarded_for_reject_not_present = "true"
}

#seal (Seal: nil)
#Configures the seal type to use for auto-unsealing, as well as for seal wrapping as an additional layer of data protection.

##seal Stanza
#The seal stanza configures the seal type to use for additional data protection, such as using HSM or Cloud KMS solutions to encrypt and decrypt the master key.
#This stanza is optional, and in the case of the master key, Vault will use the Shamir algorithm to cryptographically split the master key if this is not configured.

#As of Vault 0.9.0, the seal can also be used for seal wrapping to add an extra layer of protection and satisfy compliance and regulatory requirements.
#This feature is only available in Vault Enterprise.

#For more examples, please choose a specific auto unsealing technology from the sidebar.

##Configuration
#Seal configuration can be done through the Vault configuration file using the seal stanza:

#    seal [NAME] {
#      # ...
#    }
#For example:

#    seal "pkcs11" {
#      # ...
#    }
#For configuration options which also read an environment variable, the environment variable will take precedence over values in the configuration file.

##storage Stanza
#The storage stanza configures the storage backend, which represents the location for the durable storage of Vault's information.
#Each backend has pros, cons, advantages, and trade-offs.
#For example, some backends support high availability while others provide a more robust backup and restoration process.
#For information about a specific backend, choose one from the navigation on the left.

##Configuration
#Storage backend configuration is done through the Vault configuration file using the storage stanza:
#
#    storage [NAME] {
#      [PARAMETERS...]
#    }
#
#For example:
#
#    storage "file" {
#      path = "/mnt/vault/data"
#    }
#
#For configuration options which also read an environment variable, the environment variable will take precedence over values in the configuration file.

#storage (StorageBackend: <required>)
#Configures the storage backend where Vault data is stored.
#Please see the storage backends documentation for the full list of available storage backends.
#Running Vault in HA mode would require coordination semantics to be supported by the backend.
#If the storage backend supports HA coordination, HA backend options can also be specified in this parameter block.
#If not, a separate ha_storage parameter should be configured with a backend that supports HA, along with corresponding HA options.
storage "file" {
  path = "/etc/vault.d/data"
}

#ha_storage (StorageBackend: nil)
#Configures the storage backend where Vault HA coordination will take place.
#This must be an HA-supporting backend. If not set, HA will be attempted on the backend given in the storage parameter.
#This parameter is not required if the storage backend supports HA coordination and if HA specific options are already specified with storage parameter.
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

#telemetry (Telemetry: <none>)
#Specifies the telemetry reporting system.
telemetry {
  disable_hostname = true
}

#cluster_name (string: <generated>)
#Specifies the identifier for the Vault cluster.
#If omitted, Vault will generate a value. When connecting to Vault Enterprise, this value will be used in the interface.
cluster_name = "v1"

#cache_size (string: "32000")
#Specifies the size of the read cache used by the physical storage subsystem.
#The value is in number of entries, so the total cache size depends on the size of stored entries.
cache_size = "32000"

#disable_cache (bool: false)
#Disables all caches within Vault, including the read cache used by the physical storage subsystem.
#This will very significantly impact performance.
disable_cache = false

#disable_mlock (bool: false)
#Disables the server from executing the mlock syscall.
#mlock prevents memory from being swapped to disk.
#Disabling mlock is not recommended in production, but is fine for local development and testing.

#Disabling mlock is not recommended unless the systems running Vault only use encrypted swap or do not use swap at all.
#Vault only supports memory locking on UNIX-like systems that support the mlock() syscall (Linux, FreeBSD, etc).
#Non UNIX-like systems (e.g. Windows, NaCL, Android) lack the primitives to keep a process's entire memory address space from spilling to disk and is therefore automatically disabled on unsupported platforms.

#On Linux, to give the Vault executable the ability to use the mlock syscall without running the process as root, run:

#    [code]sudo setcap cap_ipc_lock=+ep $(readlink -f $(which vault))[code]

#Note: Since each plugin runs as a separate process, you need to do the same for each plugin in your plugins directory.

#If you use a Linux distribution with a modern version of systemd, you can add the following directive to the "[Service]" configuration section:

#   [code]LimitMEMLOCK=infinity[code]

disable_mlock = false

#plugin_directory (string: "")
#A directory from which plugins are allowed to be loaded.
#Vault must have permission to read files in this directory to successfully load plugins.
plugin_directory = "/etc/vault.d/plugins"

#log_level (string: "")
#Specifies the log level to use; overridden by CLI and env var parameters.
#On SIGHUP, Vault will update the log level to the current value specified here (including overriding the CLI/env var parameters).
#Not all parts of Vault's logging can have its level be changed dynamically this way; in particular, secrets/auth plugins are currently not updated dynamically.
#Supported log levels: Trace, Debug, Error, Warn, Info.
log_level = "info"

#default_lease_ttl (string: "768h")
#Specifies the default lease duration for tokens and secrets.
#This is specified using a label suffix like "30s" or "1h". This value cannot be larger than max_lease_ttl.
default_lease_ttl = "768h"

#max_lease_ttl (string: "768h")
#Specifies the maximum possible lease duration for tokens and secrets.
#This is specified using a label suffix like "30s" or "1h".
max_lease_ttl = "768h"

#default_max_request_duration (string: "90s")
#Specifies the default maximum request duration allowed before Vault cancels the request.
#This can be overridden per listener via the max_request_duration value.
default_max_request_duration = "90s"

#raw_storage_endpoint (bool: false)
#Enables the sys/raw endpoint which allows the decryption/encryption of raw data into and out of the security barrier.
#This is a highly privileged endpoint.
raw_storage_endpoint = false

#ui (bool: false)
#Enables the built-in web UI, which is available on all listeners (address + port) at the /ui path.
#Browsers accessing the standard Vault API address will automatically redirect there.
#This can also be provided via the environment variable VAULT_UI. For more information, please see the ui configuration documentation.
ui = true

#pid_file (string: "")
#Path to the file in which the Vault server's Process ID (PID) should be stored.
pid_file = "/var/run/vault.pid"

##High Availability Parameters
##The following parameters are used on backends that support high availability.

#api_addr (string: "")
#Specifies the address (full URL) to advertise to other Vault servers in the cluster for client redirection.
#This value is also used for plugin backends. This can also be provided via the environment variable VAULT_API_ADDR.
#In general this should be set as a full URL that points to the value of the listener address.
api_addr = "http://127.0.0.1:8200"

#cluster_addr (string: "")
#Specifies the address to advertise to other Vault servers in the cluster for request forwarding.
#This can also be provided via the environment variable VAULT_CLUSTER_ADDR. This is a full URL, like api_addr,but Vault will ignore the scheme (all cluster members always use TLS with a private key/certificate).
cluster_addr = "http://127.0.0.1:8201"

#disable_clustering (bool: false)
#Specifies whether clustering features such as request forwarding are enabled.
#Setting this to true on one Vault node will disable these features only when that node is the active node.
disable_clustering = false

##Vault Enterprise Parameters
##The following parameters are only used with Vault Enterprise

#disable_sealwrap (bool: false)
#Disables using seal wrapping for any value except the master key.
#If this value is toggled, the new behavior will happen lazily (as values are read or written).

#disable_performance_standby (bool: false)
#Specifies whether performance standbys should be disabled on this node.
#Setting this to true on one Vault node will disable this feature when this node is Active or Standby.
#It's recomended to sync this setting across all nodes in the cluster.