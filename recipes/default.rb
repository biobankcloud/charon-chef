bash "config_libjavafs" do
  user "root"
  cwd "#{node[:charon][:home]}"
  code <<-EOH
  sh Charon_mount_libs.sh
  EOH
end