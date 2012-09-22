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
end

group "hdgroup" do
	members ["hduser"]
	append true
end