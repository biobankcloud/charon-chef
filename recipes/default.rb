bash "run_Charon" do
    guard_interpreter :bash
    user "#{node[:charon][:user]}"
    group "#{node[:charon][:group]}"
    cwd "#{node[:charon][:home]}"
    code <<-EOH
    mkdir -p NewSiteIds
    mkdir -p NewSNSs
    nohup ./Charon_mount.sh > #{node[:charon][:logs_dir]}/log &
    EOH
end


