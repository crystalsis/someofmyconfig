## General Parameters

#region (string: "global")
#Specifies the region the Nomad agent is a member of. 
#A region typically maps to a geographic region, for example us, with potentially multiple zones, 
#which map to datacenters such as us-west and us-east.
region    = "A1"

#datacenter (string: "dc1")
#Specifies the data center of the local agent. All members of a datacenter should share a local LAN connection.
datacenter = "ams"

#data_dir (string: required)
#Specifies a local directory used to store agent state. 
#Client nodes use this directory by default to store temporary allocation data as well as cluster information. 
#Server nodes use this directory to store cluster state, including the replicated log and snapshot data. 
#This must be specified as an absolute path.
#WARNING: This directory must not be set to a directory that is included in the chroot if you use the exec driver.
data_dir  = "/var/lib/nomad"

bind_addr = "0.0.0.0" # the default

advertise {
  # Defaults to the first private IP address.
  http = "1.2.3.4"
  rpc  = "1.2.3.4"
  serf = "1.2.3.4:5648" # non-default ports may be specified
}

server {
  enabled          = true
  bootstrap_expect = 3
}

client {
  enabled       = true
  network_speed = 10
  options {
    "driver.raw_exec.enable" = "1"
  }
}

consul {
  address = "1.2.3.4:8500"
}