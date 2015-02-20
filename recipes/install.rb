#
# Cookbook Name:: install_charon
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

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

hin = "#{node[:charon][:home]}/.#{base_package_filename}_downloaded"
base_name = File.basename(base_package_filename, ".tgz")
bash 'extract-charon' do
  user "root"
  code <<-EOH
	tar -zxf #{cached_package_filename} -C #{node[:charon][:dir]}
        chown -RL #{node[:hdfs][:user]}:#{node[:charon][:group]} #{node[:charon][:home]}
        rm -f #{node[:charon][:home]}/config/*.config
        # remove the config files that we would otherwise overwrite
        touch #{hin}
	EOH
  not_if { ::File.exist?("#{hin}") }
end

link "#{node[:charon][:dir]}/charon" do
  to node[:charon][:home]
end




# bash "config_libjavafs" do
#     user "root"
#     cwd "/home/tiago/Documents/charon_chef/Charon"
#     code <<-EOH
#     sh configure_libjavafs.sh
#     EOH
# end

libpath = File.expand_path '../../../kagent/libraries', __FILE__
my_private_ip = my_private_ip()
my_public_ip = my_public_ip()

r = Random.new
random_id=r.rand(0..65635)

template "#{node[:charon][:home]}/config/charon.config" do
  source "charon.config.erb"
  owner node[:charon][:user]
  group node[:charon][:group]
  mode 0655
  variables({ :my_ip => my_private_ip ,
              :id => random_id
           })
end

template "#{node[:charon][:home]}/config/depsky.config" do
  source "depsky.config.erb"
  owner node[:charon][:user]
  group node[:charon][:group]
  mode 0655
end

template "#{node[:charon][:home]}/config/locations.config" do
  source "locations.config.erb"
  owner node[:charon][:user]
  group node[:charon][:group]
  mode 0655
end

template "#{node[:charon][:home]}/config/credentials.config" do
  source "credentials.config.erb"
  owner node[:charon][:user]
  group node[:charon][:group]
  mode 0655






























