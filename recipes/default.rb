bash "config_libjavafs" do
  user "#{node[:charon][:user]}"
  cwd "#{node[:charon][:home]}"
  code <<-EOH
  sh Charon_mount_libs.sh
  EOH
end