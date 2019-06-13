name             "drelephant"
maintainer       'Jim Dowling'
maintainer_email ''
license          'All rights reserved'
description      'Installs/Configures drelephant'
long_description 'Installs/Configures drelephant'
version          '1.0.0'

%w{ ubuntu debian centos rhel }.each do |os|
  supports os
end

depends 'kagent'
#depends 'scala'
depends 'java'
depends 'hadoop_spark'
depends 'hops'

recipe  "drelephant::install", "Installs the binaries for Dr Elephant"
recipe  "drelephant::default", "Starts Dr Elephant server."
recipe  "drelephant::purge", "Removes and deletes Dr Elephant server."

attribute "java/jdk_version",
          :description =>  "Jdk version",
          :type => 'string'

attribute "java/install_flavor",
          :description =>  "Oracle (default) or openjdk",
          :type => 'string'

attribute "drelephant/dir",
          :description => "Default base installation directory for the Dr Elephant server (default: /srv)",
          :type => 'string'

attribute "drelephant/user",
          :description => "Username that runs the Dr Elephant server",
          :type => 'string'

attribute "drelephant/group",
          :description => "group that runs the Dr Elephant server",
          :type => 'string'

attribute "drelephant/port",
          :description => "Port for running the Dr Elephant server",
          :type => 'string'

attribute "drelephant/default/private_ips",
          :description => "Set ip addresses",
          :type => "array"

attribute "install/dir",
          :description => "Set to a base directory under which we will install.",
          :type => "string"

attribute "install/user",
          :description => "User to install the services as",
          :type => "string"
