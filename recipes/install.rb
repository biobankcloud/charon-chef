#
# Cookbook Name:: install_charon
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

#file "/tmp/keyfile" do
#  owner 'root'
#  group 'root'
#  mode '0755'
 # path "/home/ubuntu/keyfile"
#  action :create
#end

#bash "gen_key" do
#  user "root"
#  group "root"
#  cwd "/tmp"
#  code <<-EOH
#   openssl passwd -1 #{node[:charon][:password]} > keyfile
#  EOH
#end

 #key=IO.readlines("#{node['charon']['keyfile']}").first
 #key=IO.readlines("/tmp/keyfilee").first


group node[:charon][:group] do
  action :create
end

user node[:charon][:user] do
  supports :manage_home => true
  home "/home/#{node[:charon][:user]}"
  system true
  shell "/bin/bash"
  not_if "getent passwd #{node[:charon][:user]}"
end


group node[:charon][:group] do
  action :modify
  members node[:charon][:user] 
#  members [node[:charon][:user], 'nosudo']
  append true
end

directory node[:charon][:dir] do
  owner node[:charon][:user]
  group node[:charon][:group]
  mode "0774"
  recursive true
  action :create
  not_if { File.directory?("#{node[:charon][:dir]}") }
end

directory node[:charon][:home] do
  owner node[:charon][:user]
  group node[:charon][:group]
  mode "774"
  action :create
  recursive true
  not_if { File.directory?("#{node[:charon][:home]}") }
end



directory node[:charon][:mount_point] do
 owner node[:charon][:user]
 group node[:charon][:group]
 mode "0774"
 action :create
end

node.default['java']['jdk_version'] = 7
include_recipe "java"

package 'tar' do
    action :install
    options "--force-yes"
end

#package 'openjdk-7-jre-headless' do
#    action :install
#end

apt_package 'fuse' do
    action :install
    options "--force-yes"
end

package_url = node[:charon][:download_url]
Chef::Log.info "Downloading charon binaries from #{package_url}"
base_package_filename = File.basename(package_url)
cached_package_filename = "#{Chef::Config[:file_cache_path]}/#{base_package_filename}"

remote_file cached_package_filename do
  source package_url
  owner node[:charon][:user]
  group node[:charon][:group]
  mode "0755"
  # TODO - checksum
  action :create_if_missing
end


#hin = "#{node[:charon][:home]}/.#{base_package_filename}_downloaded"
hin = "#{node[:charon][:home]}/.charon_extracted_#{node[:charon][:version]}"
base_name = File.basename(base_package_filename, ".tar.gz")
bash 'extract-charon' do
#  guard_interpreter :bash
#  user node[:charon][:user]
#  group node[:charon][:group]
  user "root"
  code <<-EOH
	tar -zxzf #{cached_package_filename} -C #{node[:charon][:dir]}
	chown -RL #{node[:charon][:user]}:#{node[:charon][:group]} #{node[:charon][:home]}
        rm -f #{node[:charon][:home]}/config/charon.config
        rm -f #{node[:charon][:home]}/config/depsky.config
        rm -f #{node[:charon][:home]}/config/hopsfsRep.config
        rm -f #{node[:charon][:home]}/config/singleCloud.config
        rm -f #{node[:charon][:home]}/config/*.charon
        # remove the config files that we would otherwise overwrite
        touch #{hin}
#        chown -R #{node[:charon][:user]} #{node[:charon][:home]}
	EOH
  not_if { ::File.exist?("#{hin}") }
end

#link "#{node[:charon][:dir]}/charon" do
   # owner node[:charon][:user]
 # group node[:charon][:group]
 # to node[:charon][:home]
#end

bash "config_libjavafs" do
  user "#{node[:charon][:user]}"
  group "#{node[:charon][:group]}"
  cwd "#{node[:charon][:home]}"
  code <<-EOH
  sh configure_libjavafs.sh
  EOH
end

my_private_ip = my_private_ip()
my_public_ip = my_public_ip()
node_ip = node['ipaddress']

r = Random.new
random_id=r.rand(0..65635)

template "#{node[:charon][:home]}/config/charon.config" do
  source "charon.config.erb"
  owner node[:charon][:user]
  group node[:charon][:group]
  mode 0655
  variables({ :my_ip => node_ip ,
              :id => random_id
           })
end

template "#{node[:charon][:home]}/config/depsky.config" do
  source "depsky.config.erb"
  owner node[:charon][:user]
  group node[:charon][:group]
  mode 0655
end


template "#{node[:charon][:home]}/config/singleCloud.config" do
  source "singleCloud.config.erb"
  owner node[:charon][:user]
  group node[:charon][:group]
  mode 0655
end

template "#{node[:charon][:home]}/config/site-id.charon" do
  source "site-id.charon.erb"
  owner node[:charon][:user]
  group node[:charon][:group]
  mode 0655
  variables({ :my_ip => node_ip ,
            :id => random_id
         })
end

template "#{node[:charon][:home]}/config/credentials.charon" do
  source "credentials.charon.erb"
  owner node[:charon][:user]
  group node[:charon][:group]
  mode 0655
    variables({ :id => random_id
         })
end

template "#{node[:charon][:home]}/config/hopsfsRep.config" do
  source "hopsfsRep.config.erb"
  owner node[:charon][:user]
  group node[:charon][:group]
  mode 0655
end

use_coc = node[:charon][:locations][:use_coc] 
use_cloud = node[:charon][:locations][:use_cloud]

if node[:charon][:locations][:default_location] == "coc"
  use_coc = true
end

if node[:charon][:locations][:default_location] == "cloud"
  use_cloud = true
end

template "#{node[:charon][:home]}/config/locations.config" do
  source "locations.config.erb"
  owner node[:charon][:user]
  group node[:charon][:group]
  mode 0655
    variables({ :use_coc => use_coc ,
 	      :use_cloud => use_cloud
         })
end

file "/etc/fuse.conf" do
#  user node[:charon][:user]
#  user "root"
  mode 0644
end


bash "config_fuse_conf" do
  #user node[:charon][:user]
  user "root"
  #cwd "#{node[:charon][:home]}"
  code <<-EOH
  perl -p -i -e 's|#user_allow_other|user_allow_other|g;' /etc/fuse.conf
  EOH
end

directory node[:charon][:logs_dir] do
  owner node[:charon][:user]
  group node[:charon][:group]
  mode "770"
  action :create
  recursive true
  not_if { File.directory?("#{node[:charon][:logs_dir]}") }
end

