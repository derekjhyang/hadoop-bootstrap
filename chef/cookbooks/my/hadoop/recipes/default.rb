#
# Cookbook Name:: hadoop
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user "hduser" do
  comment "Hadoop User"
  system false
  password "$1$Q5YyJZpE$VePKWkZjH0RUq9L2AUx/I/"
  shell "/bin/bash"
  home "/home/hduser"
end

group "hdgroup" do
	members ["hduser"]
	append true
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
		chown -R hduser:hdgroup /usr/local/hadoop-2.0.1-alpha  
	EOH
end