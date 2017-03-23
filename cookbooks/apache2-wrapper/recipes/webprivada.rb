#
# Cookbook Name:: apache2-wrapper
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'apache2'

web_app "my_site" do
  server_name node['hostname']
  server_aliases [node['fqdn']]
  docroot "/var/www/html/#{node['hostname']}"
  cookbook 'apache2'
end
