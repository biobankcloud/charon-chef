package_url = node[:charon][:package_url]
Chef::Log.info "Downloading mysql cluster binaries from #{package_url}"
base_package_filename =  File.basename(node[:ndb][:package_url])
Chef::Log.info "Into file #{base_package_filename}"
base_package_dirname =  File.basename(base_package_filename, ".tar.gz")
ndb_package_dirname = "#{Chef::Config[:file_cache_path]}/#{base_package_dirname}"
cached_package_filename = "#{node[:ndb][:shared_folder]}/#{base_package_filename}"

Chef::Log.info "You should find mysql cluster binaries it in:  #{cached_package_filename}"

# TODO - HTTP Proxy settings
remote_file cached_package_filename do
#  checksum node[:ndb][:checksum]
  source package_url
  mode 0755
  action :create
end


bash "download_charonfs" do
    user "root"
    code <<-EOF

tar -xzf #{cached_package_filename} -C #{Chef::Config[:file_cache_path]}
mv #{ndb_package_dirname}/* #{node[:mysql][:version_dir]}
if [ -L #{node[:mysql][:base_dir]} ] ; then
 rm -rf #{node[:mysql][:base_dir]}
fi

# http://www.slideshare.net/Severalnines/severalnines-my-sqlclusterpt2013
# TODO: If binding threads to CPU, run the following:
# echo '0' > /proc/sys/vm/swappiness
# echo 'vm.swappiness=0' >> /etc/sysctl.conf
chown -R #{node[:mysql][:run_as_user]} #{node[:mysql][:version_dir]}
EOF
  not_if { ::File.exists?( "#{node[:mysql][:version_dir]}/bin/ndbd" ) }
end
