bash "config_libjavafs" do
  user "#{node[:charon][:user]}"
  cwd "#{node[:charon][:home]}"
  code <<-EOH
  nohup sh Charon_mount_libs.sh > #{node[:charon][:logs_dir]}
  EOH
end