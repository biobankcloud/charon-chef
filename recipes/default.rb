bash "run_Charon" do
    guard_interpreter :bash
    user "#{node[:charon][:user]}"
    group "#{node[:charon][:group]}"
    cwd "#{node[:charon][:home]}"
    code <<-EOH
    nohup ./Charon_mount.sh > #{node[:charon][:logs_dir]}/log &
    EOH
end


