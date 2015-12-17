include_attribute "hadoop"

default[:charon][:version]                               = "0.2.0"
default[:charon][:user]                                  = "root"
default[:charon][:group]                                 = "root"
default[:charon][:site_id_name]                          = ""
default[:charon][:dir]                                   = "/srv"
default[:charon][:home]                                  = "#{node[:charon][:dir]}/Charon"
default[:charon][:logs_dir]                              = "#{node[:charon][:home]}/logs"

default[:charon][:user_email]                            = ""
default[:charon][:mount_point]                           = "#{node[:charon][:home]}/charon_fs"
default[:charon][:download_url]                          = "https://dl.dropboxusercontent.com/u/2933066/charon-#{node[:charon][:version]}.tar.gz"

default[:charon][:debug]                                 = "true"
default[:charon][:public_ip]                             = ['10.0.2.15']

# CLOUDS CREDENTIALS
default[:charon][:credentials][:aws][:access_key]        = ""
default[:charon][:credentials][:aws][:secret_key]        = ""

default[:charon][:credentials][:google][:access_key]     = ""
default[:charon][:credentials][:google][:secret_key]     = ""

default[:charon][:credentials][:rackspace][:access_key]  = ""
default[:charon][:credentials][:rackspace][:secret_key]  = ""

default[:charon][:credentials][:azure][:access_key]      = ""
default[:charon][:credentials][:azure][:secret_key]      = ""

# CANONICAL IDS
default[:charon][:cannonical_id][:aws_can_id]            = ""
default[:charon][:cannonical_id][:google_email]          = ""

# LOCATIONS
default[:charon][:locations][:default_location]          = "cloud"
default[:charon][:locations][:use_coc]                   = "false"
default[:charon][:locations][:use_cloud]                 = "true"


# HDFS
default[:charon][:hdfs][:repo_dir]                       = "/charon-rep"
default[:charon][:hdfs][:conf_dir]                       = node[:hadoop][:conf_dir]

