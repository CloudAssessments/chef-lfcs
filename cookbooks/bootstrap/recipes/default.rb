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

  group 'cloud_user' do
    members 'cloud_user'
  end

  user 'cloud_user' do
    home '/home/cloud_user'
    manage_home true
    shell '/bin/bash'
    password '$1$linuxaca$iGMxZ4g4lbPmfEDPhW3lw1'
    salt 'linuxacademy'
    gid 'cloud_user'
  end

  execute 'add cloud_user to sudoers' do
    command '/bin/echo \'cloud_user ALL=(ALL:ALL) NOPASSWD: ALL\' >> /etc/sudoers'
  end

  openssh_server '/etc/ssh/sshd_config' do
    PasswordAuthentication yes
  end
end

if node['platform_family'] == "redhat"
  command '/bin/echo \'cloud_user  ALL=(ALL)  NOPASSWD: ALL\' >> /etc/sudoers'
end

directory '/opt/scripts' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

remote_file '/opt/scripts/fix-reports.sh' do
  group 'root'
  owner 'root'
  mode '755'
  source 'https://raw.githubusercontent.com/CloudAssessments/lfcsa-lab-files/master/fix-reports.sh'
  action :create
end

remote_file '/home/cloud_user/irs-records.txt' do
  group 'cloud_user'
  owner 'cloud_user'
  mode '644'
  source 'https://raw.githubusercontent.com/CloudAssessments/lfcsa-lab-files/master/irs-records.txt'
  action :create
end

remote_file '/home/cloud_user/private-records.txt' do
  group 'cloud_user'
  owner 'cloud_user'
  mode '644'
  source 'https://raw.githubusercontent.com/CloudAssessments/lfcsa-lab-files/master/private-records.txt'
  action :create
end

remote_file '/home/cloud_user/reboot.bad' do
  group 'cloud_user'
  owner 'cloud_user'
  mode '644'
  source 'https://raw.githubusercontent.com/CloudAssessments/lfcsa-lab-files/master/reboot.bad'
  action :create
end

service 'sshd' do
  action :start
end
