#
# Cookbook Name:: kafka-manager
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

kafka_manager 'default' do
  package_version "#{node['kafka-manager']['version']}"
  cookbook node['kafka-manager']['cookbook_source']
  action :install
end

template '/usr/share/kafka-manager/conf/application.conf' do
  source 'application.conf.erb'
  variables ({
    :zkhosts => "#{node['kafka-manager']['zkhosts']}"
  })
  notifies :restart, 'service[kafka-manager]'
  cookbook node['kafka-manager']['cookbook_source']
end

service 'kafka-manager' do
  action [ :enable, :start ]
end
