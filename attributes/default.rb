include_attribute "hadoop"

default[:charon][:version]                 = "0.2.0"
default[:charon][:user]                    = "root"
default[:charon][:group]                   = "root"
default[:charon][:dir]                     = "/srv"
default[:charon][:home]                    = "#{node[:charon][:dir]}/Charon"
default[:charon][:logs_dir]                = "#{node[:charon][:home]}/logs"

default[:charon][:user_email]              = "tiago.m.o.89@gmail.com"
default[:charon][:mount_point]             = "#{node[:charon][:home]}/charon_fs"
default[:charon][:download_url]            = "https://dl.dropboxusercontent.com/u/2933066/charon-#{node[:charon][:version]}.tar.gz"

default[:charon][:debug]                   = "true"
default[:charon][:public_ip]               = ['10.0.2.15']

default[:charon][:use_only_aws]            = "false"

default[:charon][:aws][:access_key]        = ""
default[:charon][:aws][:secret_key]        = ""
default[:charon][:aws][:cannonical_id]     = ""

default[:charon][:google][:access_key]     = ""
default[:charon][:google][:secret_key]     = ""
default[:charon][:google][:email]          = ""

default[:charon][:rackspace][:access_key]  = ""
default[:charon][:rackspace][:secret_key]  = ""

default[:charon][:azure][:access_key]      = ""
default[:charon][:azure][:secret_key]      = ""

default[:charon][:hdfs][:repo_dir]         = "/charon-rep"
default[:charon][:hdfs][:conf_dir]         = "#{node[:hadoop][:conf_dir]}"
#default[:charon][:hdfs][:conf_dir]         = "/srv/hadoop/etc/hadoop"



