script "run_Charon" do
  guard_interpreter :script
  user "#{node[:charon][:user]}"
  group "#{node[:charon][:user]}"
  #user "root"
  cwd "#{node[:charon][:home]}"
  code <<-EOH
  nohup ./Charon_mount_libs.sh > #{node[:charon][:logs_dir]} &
  EOH
end