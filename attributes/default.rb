default[:charon][:version]                 = "0.1.0"
default[:charon][:user]                    = "root"
default[:charon][:group]                   = "root"
default[:charon][:dir]                     = "/srv"
default[:charon][:home]                    = "#{node[:charon][:dir]}/charon-#{node[:charon][:version]}"
default[:charon][:logs_dir]                = "#{node[:charon][:home]}/logs"

default[:charon][:email]                   = ""
default[:charon][:mount_point]             = "charon_fs"
default[:charon][:download_url]            = "https://dl.dropboxusercontent.com/u/2933066/charon-#{node[:charon][:version]}.tar.gz"

default[:charon][:debug]                   = "false"

default[:aws][:access_key]                 = ""
default[:aws][:secret_key]                 = ""

default[:google][:access_key]              = ""
default[:google][:secret_key]              = ""

default[:rackspace][:access_key]           = ""
default[:rackspace][:secret_key]           = ""

default[:azure][:access_key]               = ""
default[:azure][:secret_key]               = ""

default[:charon][:public_ips]              = ['10.0.2.15']
default[:charon][:private_ips]             = ['10.0.2.15']


default[:hadoop][:yarn][:user]             = "yarn"
default[:hadoop][:yarn][:nm][:memory_mbs]  = 3584
default[:hadoop][:yarn][:ps_port]          = 20888
default[:hadoop][:yarn][:vpmem_ratio]      = 4.1