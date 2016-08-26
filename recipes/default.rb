#
# Cookbook Name:: drelephant
# Recipe:: default
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

service_name="drelephant"

case node.platform
when "ubuntu"
 if node.platform_version.to_f <= 14.04
   node.override.drelephant.systemd = "false"
 end
end


if node.drelephant.systemd == "true"

  service service_name do
    provider Chef::Provider::Service::Systemd
    supports :restart => true, :stop => true, :start => true, :status => true
    action :nothing
  end

  case node.platform_family
  when "rhel"
    systemd_script = "/usr/lib/systemd/system/#{service_name}.service" 
  else
    systemd_script = "/lib/systemd/system/#{service_name}.service"
  end

  template systemd_script do
    source "#{service_name}.service.erb"
    owner "root"
    group "root"
    mode 0754
    notifies :enable, resources(:service => service_name)
    notifies :start, resources(:service => service_name), :immediately
  end

  hadoop_spark_start "reload_#{service_name}" do
    action :systemd_reload
  end  

else #sysv

  service service_name do
    provider Chef::Provider::Service::Init::Debian
    supports :restart => true, :stop => true, :start => true, :status => true
    action :nothing
  end

  template "/etc/init.d/#{service_name}" do
    source "#{service_name}.erb"
    owner node.drelephant.user
    group node.drelephant.group
    mode 0754
    notifies :enable, resources(:service => service_name)
    notifies :restart, resources(:service => service_name)
  end

end


if node.kagent.enabled == "true" 
   kagent_config service_name do
     service service_name
     log_file "#{node.drelephant.base_dir}/drelephant.log"
     web_port "#{node.drelephant.port}".to_i
   end
end


