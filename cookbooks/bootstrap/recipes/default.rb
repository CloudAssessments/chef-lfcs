#
# Cookbook:: bootstrap
# Recipe:: default
#
# Copyright:: 2017, Travis N. Thomsen for Linux Academy, All Rights Reserved.

include_recipe 'sshd::default'

service 'sshd' do
  action :stop
end

if node['platform_family'] == "debian"

  user 'cloud_user' do
    home '/home/cloud_user'
    manage_home true
    shell '/bin/bash'
    password '$1$linuxaca$iGMxZ4g4lbPmfEDPhW3lw1'
    salt 'linuxacademy'
    gid 'sudo'
  end
  
  openssh_server '/etc/ssh/sshd_config' do
    PasswordAuthentication yes
  end
end

git 'lfcsa-lab-files' do
  repository 'https://github.com/CloudAssessments/lfcsa-lab-files.git'
  revision 'challenge1'
  destination '/root/lfcsa-lab-files'
  action :sync
end

directory '/opt/scripts' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

file '/opt/scripts/fix-reorts.sh' do
  group 'root'
  owner 'root'
  mode '755'
  content IO.read('/root/lfcsa-lab-files/fix-reports.sh')
  action :create
end

file '/home/cloud_user/irs-records.txt' do
  group 'cloud_user'
  owner 'cloud_user'
  mode '644'
  content IO.read('/root/lfcsa-lab-files/irs-records.txt')
  action :create
end

file '/home/cloud_user/private-records.txt' do
  group 'cloud_user'
  owner 'cloud_user'
  mode '644'
  content IO.read('/root/lfcsa-lab-files/private-records.txt')
  action :create
end

file '/home/cloud_user/reboot.bad' do
  group 'cloud_user'
  owner 'cloud_user'
  mode '644'
  content IO.read('/root/lfcsa-lab-files/reboot.bad')
  action :create
end

service 'sshd' do
  action :start
end
