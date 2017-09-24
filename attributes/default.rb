include_attribute "kagent"
include_attribute "hadoop_spark"
include_attribute "hops"

default['drelephant']['user']                = node['install']['user'].empty? ? "glassfish" : node['install']['user'] 
default['drelephant']['group']               = node['install']['user'].empty? ? node['hops']['group'] : node['install']['user'] 
default['drelephant']['version']             = "2.0.3-SNAPSHOT"
default['drelephant']['url']                 = "http://snurran.sics.se/hops/dr-elephant-#{node['drelephant']['version']}.zip"
default['drelephant']['checksum']            = ""
default['drelephant']['port']                = "11011"

default['drelephant']['dir']                 = node['install']['dir'].empty? ? "/srv" : node['install']['dir']
default['drelephant']['base_dir']            = node['drelephant']['dir'] + "/dr-elephant"
default['drelephant']['home']                = node['drelephant']['dir'] + "/dr-elephant-" + node['drelephant']['version']

default['drelephant']['play_version']        = "1.3.10"
default['drelephant']['play_url']            = "https://downloads.typesafe.com/typesafe-activator/#{node['drelephant']['play_version']}/typesafe-activator-#{node['drelephant']['play_version']}-minimal.zip"
default['drelephant']['play_checksum']       = "15352ce253aa804f707ef8be86390ee1ee91da4b78dbb2729ab1e9cae01d8937"
default['drelephant']['play_base_dir']       = node['drelephant']['dir'] + "/activator-dist"
default['drelephant']['play_home']           = node['drelephant']['dir'] + "/activator-dist-" + node['drelephant']['play_version']

default['drelephant']['db']                  = "hopsworks"

default['drelephant']['systemd']             = "true"

default['drelephant']['spark_log_size_limit_in_mb']  = 100
