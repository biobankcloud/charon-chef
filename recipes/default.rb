bash "run_Charon" do
  user "#{node[:charon][:user]}"
  #user "root"
  cwd "#{node[:charon][:home]}"
  code <<-EOH
  nohup sh Charon_mount_libs.sh > #{node[:charon][:logs_dir]} &
  EOH
end