#
# Cookbook Name:: install_charon
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.


apt_package 'tar' do
    action :install
end

apt_package 'openjdk-7-jre-headless' do
    action :install
end

apt_package 'fuse' do
    action :install
end

# download charon
# use tar to extract charon
# put it on the desired directory

bash "config_libjavafs" do
    user "root"
    cwd "/home/tiago/Documents/charon_chef/Charon"
    code <<-EOH
    sh configure_libjavafs.sh
    EOH
end

template 'config.charon' do
    path '/home/tiago/Documents/charon_chef/cookbooks/charon.config'
    source 'charon.config.erb'
    action :create_if_missing
end

template 'depsky.config' do
    path '/home/tiago/Documents/charon_chef/cookbooks/depsky.config'
    source 'depsky.config.erb'
    action :create_if_missing
end

template 'locations.config' do
    path '/home/tiago/Documents/charon_chef/cookbooks/locations.config'
    source 'locations.config.erb'
    action :create_if_missing
end

template 'credentials.config' do
    path '/home/tiago/Documents/charon_chef/cookbooks/credentials.config'
    source 'credentials.config.erb'
    action :create_if_missing
end

# run ./Charon_mount.sh script to mount Charon (maybe set to 777 mode)





























