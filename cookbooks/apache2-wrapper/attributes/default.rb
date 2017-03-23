#default['apache']['version'] = '4-2.4.16-1.62' 
#default['apache']['mpm'] = 'prefork'
default['apache2-wrapper']['reverseproxy']['site'] = "#{node['hostname']}"
default['apache2-wrapper']['port'] = nil

default['apache2-wrapper']['reverseproxy']['www_redirect'] = 'enable'
default['apache2-wrapper']['reverseproxy']['host_aliases'] = ["#{node['hostname']}"]
default['apache2-wrapper']['reverseproxy']['host_name'] = ["#{node['hostname']}"]

#default['apache2-wrapper']['reverseproxy']['cas_validate_server'] = nil
#default['apache2-wrapper']['reverseproxy']['ssl'] = true
#default['apache2-wrapper']['reverseproxy']['ssl']['enabled'] = true
#default['apache2-wrapper']['reverseproxy']['ssl']['redirect_http'] = true
#default['apache2-wrapper']['reverseproxy']['ssl']['ssl_listen_ports'] = 443
#default['apache2-wrapper']['reverseproxy']['ssl']['cert_path'] = nil
#default['apache2-wrapper']['reverseproxy']['ssl']['key_path'] = nil
#default['apache2-wrapper']['reverseproxy']['ssl']['ca_cert_path'] = nil

default['apache2-wrapper']['reverseproxy']['basic_auth_username'] = ''
default['apache2-wrapper']['reverseproxy']['basic_auth_password'] = ''

