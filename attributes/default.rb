include_attribute "kagent"
include_attribute "hadoop_spark"
include_attribute "apache_hadoop"

node.default.drelephant.user                = "glassfish"
node.default.drelephant.group               = node.apache_hadoop.group
node.default.drelephant.version             = "2.0.6"
node.default.drelephant.url                 = "http://snurran.sics.se/hops/dr-elephant-#{node.drelephant.version}.zip"
node.default.drelephant.checksum            = ""
node.default.drelephant.port                = "11011"

node.default.drelephant.dir                 = "/srv"
node.default.drelephant.base_dir            = node.drelephant.dir + "/dr-elephant"
node.default.drelephant.home                = node.drelephant.dir + "/dr-elephant-" + node.drelephant.version

node.default.drelephant.play_version        = "1.3.12"
node.default.drelephant.play_url            = "https://downloads.typesafe.com/typesafe-activator/#{node.drelephant.play_version}/typesafe-activator-#{node.drelephant.play_version}-minimal.zip"
node.default.drelephant.play_checksum       = "d5037bcc2793011a03807a123035d2b3dafde32bcf0fab9112cb958a59ad9386"
node.default.drelephant.play_base_dir       = node.drelephant.dir + "/activator-dist"
node.default.drelephant.play_home           = node.drelephant.dir + "/activator-dist-" + node.drelephant.play_version

node.default.drelephant.db                  = "hopsworks"

node.default.drelephant.systemd             = "true"

node.default.drelephant.spark_log_size_limit_in_mb  = 100
