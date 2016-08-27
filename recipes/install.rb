
group node.drelephant.group do
  action :create
  not_if "getent group #{node.drelephant.group}"
end

user node.drelephant.user do
  action :create
  system true
  shell "/bin/bash"
  not_if "getent passwd #{node.drelephant.user}"  
end

group node.drelephant.group do
  action :modify
  members ["#{node.drelephant.user}"]
  append true
end


include_recipe "java"


package "unzip" do
end

case node.platform_family
when "debian"
 # package "scala" do
 #   action :install
 # end

  # bash "install_scala" do
  #   user "root"
  #   code <<-EOF
  #   wget www.scala-lang.org/files/archive/scala-2.11.7.deb
  #   sudo dpkg -i scala-2.11.7.deb
  #   EOF
  #   not_if "scala -version | grep 'Scala code runner'"
  # end


when "redhat"
# include_recipe "scala"
end

dr_url = node.drelephant.url
basename =  File.basename(dr_url)
base_zipname =  File.basename(basename, ".zip")

remote_file "/tmp/#{basename}" do
#  checksum node.drelephant.checksum
  source dr_url
  owner node.drelephant.user
  group node.drelephant.group
  mode 0755
  action :create
end

drlock = "#{node.drelephant.base_dir}/.dr_downloaded"

bash "unpack_dr" do
    user "root"
    code <<-EOF
    set -e
    if [ -L #{node.drelephant.base_dir}  ; then
       rm -rf #{node.drelephant.base_dir} 
    fi
    cd /tmp
    unzip /tmp/#{basename}
    mv -f #{base_zipname} #{node.drelephant.dir}
    ln -s #{node.drelephant.home} #{node.drelephant.base_dir}
    chown -R #{node.drelephant.user} #{node.drelephant.home}
    touch #{drlock}
EOF
  not_if { ::File.exists?( drlock ) }
end

my_ip = my_private_ip()

my_url = "#{my_ip}:#{node.ndb.mysql_port}"

file "#{node.drelephant.home}/conf/elephant.conf" do
 action :delete
end

template "#{node.drelephant.home}/conf/elephant.conf" do
  source "elephant.conf.erb"
  owner node.drelephant.user
  group node.drelephant.group
  mode 0644
  variables({ 
        :my_url => my_url
           })
end



tmp_dirs   = ["FetcherConf.xml","HeuristicConf.xml","JobTypeConf.xml","resolver.conf", "log4j.properties"]

for d in tmp_dirs

  file "#{node.drelephant.home}/conf/#{d}" do
    action :delete
  end

  template "#{node.drelephant.home}/conf/#{d}" do
    source "#{d}.erb"
    owner node.drelephant.user
    group node.drelephant.group
    mode 0644
  end

end
