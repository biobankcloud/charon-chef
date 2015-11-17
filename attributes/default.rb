default[:charon][:version]                 = "0.2.0"
default[:charon][:user]                    = "root"
default[:charon][:group]                   = "root"
default[:charon][:dir]                     = "/srv"
default[:charon][:home]                    = "#{node[:charon][:dir]}/Charon"
default[:charon][:logs_dir]                = "#{node[:charon][:home]}/logs"

default[:charon][:user_email]              = "tiago.m.o.89@gmail.com"
default[:charon][:mount_point]             = "#{node[:charon][:dir]}/charon_fs"
default[:charon][:download_url]            = "https://dl.dropboxusercontent.com/u/2933066/charon-#{node[:charon][:version]}.tar.gz"

default[:charon][:debug]                   = "true"
default[:charon][:public_ip]               = ['10.0.2.15']

default[:aws][:access_key]                 = ""
default[:aws][:secret_key]                 = ""
default[:aws][:cannonical_id]              = ""

default[:google][:access_key]              = ""
default[:google][:secret_key]              = ""
default[:google][:email]                   = ""

default[:rackspace][:access_key]           = ""
default[:rackspace][:secret_key]           = ""

default[:azure][:access_key]               = ""
default[:azure][:secret_key]               = ""

default[:charon][:public_ips]              = ['10.0.2.15']
default[:charon][:private_ips]             = ['10.0.2.15']

default[:hdfs][:folder]               	   = "/charon-rep"
default[:hdfs][:ip]               	   = "localhost"
default[:hdfs][:port]               	   = 9000
default[:hdfs][:conf_dir]                  = ""

default[:hadoop][:yarn][:user]             = "yarn"
default[:hadoop][:yarn][:nm][:memory_mbs]  = 3584
default[:hadoop][:yarn][:ps_port]          = 20888
default[:hadoop][:yarn][:vpmem_ratio]      = 4.1
