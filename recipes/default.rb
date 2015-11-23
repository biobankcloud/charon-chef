bash "run_Charon" do
  guard_interpreter :bash
  user "#{node[:charon][:user]}"
  group "#{node[:charon][:user]}"
  cwd "#{node[:charon][:home]}"
  code <<-EOH
   nohup sudo ./Charon_mount.sh > #{node[:charon][:logs_dir]} &
  EOH
end
