#
# Cookbook:: bootstrap
# Recipe:: default
#
# Copyright:: 2017, Travis N. Thomsen for Linux Academy, All Rights Reserved.

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
