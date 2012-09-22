#
# Cookbook Name:: hadoop
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "/etc/sudoers" do
  source "sudoers.erb"
  mode 0440
  owner "root"
  group "root"
  variables({
    :sudoers_groups => node[:authorization][:sudo][:groups],
    :sudoers_users => node[:authorization][:sudo][:users]
  })
end

remote_file "/tmp/hadoop.tar.gz" do
	source "http://ftp.ps.pl/pub/apache/hadoop/common/alpha/hadoop-2.0.1-alpha.tar.gz"
end

script "install_hadoop" do
	interpreter "bash"
	cwd "/tmp"
	code <<-EOH
		tar zxf hadoop.tar.gz -C /usr/local/
		ln -s /usr/local/hadoop-2.0.1-alpha/ /usr/local/hadoop
	EOH
end

script "generate_key" do
  interpreter "bash"
  code <<-EOH
  	ssh-keygen -t rsa -q -f $HOME/.ssh/id_rsa -P ""
  	cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys
  	ssh-keyscan -t rsa localhost >> $HOME/.ssh/known_hosts
  	ssh-keyscan -t rsa 0.0.0.0 >> $HOME/.ssh/known_hosts
  EOH
end

template "/usr/local/hadoop/etc/hadoop/hadoop-env.sh" do
	source "hadoop-env.sh.erb"
	variables({ :java_home => node['java']['java_home']})
end

script "configure_hadoop" do
	interpreter "bash"
	code <<-EOH
		/usr/local/hadoop/sbin/update-hadoop-env.sh --prefix=/usr/local/hadoop
	EOH
end
