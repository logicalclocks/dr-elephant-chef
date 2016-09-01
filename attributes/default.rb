include_attribute "kagent"
include_attribute "hadoop_spark"
include_attribute "apache_hadoop"

node.default.drelephant.user                = node.glassfish.user
node.default.drelephant.group               = node.glassfish.group
node.default.drelephant.version             = "2.0.3-SNAPSHOT"
node.default.drelephant.url                 = "http://snurran.sics.se/hops/dr-elephant-#{node.drelephant.version}.zip"
node.default.drelephant.checksum            = ""
node.default.drelephant.port                = "11011"

node.default.drelephant.dir                 = "/srv"
node.default.drelephant.base_dir            = node.drelephant.dir + "/dr-elephant"
node.default.drelephant.home                = node.drelephant.dir + "/dr-elephant-" + node.drelephant.version

node.default.drelephant.play_version        = "1.3.10"
node.default.drelephant.play_url            = "https://downloads.typesafe.com/typesafe-activator/#{node.drelephant.play_version}/typesafe-activator-#{node.drelephant.play_version}-minimal.zip"
node.default.drelephant.play_checksum       = "15352ce253aa804f707ef8be86390ee1ee91da4b78dbb2729ab1e9cae01d8937"
node.default.drelephant.play_base_dir       = node.drelephant.dir + "/activator-dist"
node.default.drelephant.play_home           = node.drelephant.dir + "/activator-dist-" + node.drelephant.play_version

node.default.drelephant.db                  = "hopsworks"

node.default.drelephant.systemd             = "true"

node.default.drelephant.spark_log_size_limit_in_mb  = 100
