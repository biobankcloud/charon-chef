bash "run_Charon" do
  guard_interpreter :bash
  user "#{node[:charon][:user]}"
  group "#{node[:charon][:user]}"
  cwd "#{node[:charon][:home]}"
  code <<-EOH
  nohup ./Charon_mount_libs.sh > #{node[:charon][:logs_dir]} &
  EOH
end