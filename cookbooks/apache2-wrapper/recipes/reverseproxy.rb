#
# Cookbook Name:: apache2-wrapper
# Recipe:: reverseproxy
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'apache2::default'

www_redirect = (node['apache2-wrapper']['reverseproxy']['www_redirect'] == 'enable')
host_name = node['apache2-wrapper']['reverseproxy']['host_name'] || node['fqdn']

if node['apache2-wrapper']['reverseproxy']['cas_validate_server'] == 'cas'
  apache_module 'mod_auth_cas'
end

if node['apache2-wrapper']['reverseproxy']['ssl'] && node['apache2-wrapper']['http_proxy']['ssl']['enabled']
  include_recipe 'apache2::mod_ssl'
end

apache_module 'proxy'
apache_module 'proxy_http'
apache_module 'vhost_alias'

if www_redirect || (node['apache2-wrapper']['reverseproxy']['ssl'] && node['apache2-wrapper']['http_proxy']['ssl']['redirect_http'])
  apache_module 'rewrite'
end

if false
  template "#{node['apache']['dir']}/htpasswd" do
    variables(:username => node['apache2-wrapper']['reverseproxy']['basic_auth_username'],
              :password => node['apache2-wrapper']['reverseproxy']['basic_auth_password'])
    owner node['apache']['user']
    group node['apache']['user']
    mode '0600'
  end
end

template "#{node['apache']['dir']}/sites-available/#{node['apache2-wrapper']['reverseproxy']['site']}.conf" do
  source      'proxy_site80.erb'
  owner       'root'
  group       'root'
  mode        '0644'
  variables(
    :host_name        => host_name,
    :www_redirect     => www_redirect
  )

  if File.exists?("#{node['apache']['dir']}/sites-enabled/#{node['apache2-wrapper']['reverseproxy']['site']}.conf")
    notifies  :restart, 'service[apache2]'
  end
end

apache_site '000-default' do
  enable  false
end

apache_site "#{node['apache2-wrapper']['reverseproxy']['site']}" do
  enable true
end
