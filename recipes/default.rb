script "run_Charon" do
  user #{node[:charon][:user]}
  group #{node[:charon][:user]}
  #user "root"
  guard_interpreter :script
  cwd '#{node[:charon][:home]}'
  code <<-EOH
  nohup ./Charon_mount_libs.sh > #{node[:charon][:logs_dir]} &
  EOH
end