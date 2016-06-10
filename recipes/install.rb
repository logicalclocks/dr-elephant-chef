
group node.drelephant.group do
  action :create
end

user node.drelephant.user do
  action :create
  system true
  shell "/bin/bash"
end

package "unzip" do
end

case node.platform_family
when "debian"
 package "scala" do
   action :install
 end
when "redhat"
 include_recipe "scala"
end


# package_url = node.drelephant.play_url
# base_package_filename =  File.basename(package_url)
# base_package_zipname =  File.basename(base_package_filename, ".zip")

# remote_file "#{Chef::Config.file_cache_path}/#{base_package_filename}" do
#   checksum node.drelephant.play_checksum
#   source package_url
#   owner node.drelephant.user
#   group node.drelephant.group
#   mode 0755
#   action :create
# end

# playlock = "#{Chef::Config.file_cache_path}/.play_downloaded"

# bash "unpack_typesafe_play" do
#     user "root"
#     code <<-EOF
#     set -e
#     if [ -L #{node.drelephant.play_base_dir}  ; then
#        rm -rf #{node.drelephant.play_base_dir} 
#     fi
#     cd #{Chef::Config.file_cache_path}
#     unzip #{Chef::Config.file_cache_path}/#{base_package_filename}
#     mv #{base_package_zipname} #{node.drelephant.dir}
#     ln -s #{node.drelephant.play_home} #{node.drelephant.play_base_dir}
#     chown -R #{node.drelephant.user} #{node.drelephant.play_home}
#     touch #{playlock}
# EOF
#   not_if { ::File.exists?( playlock ) }
# end


dr_url = node.drelephant.url
basename =  File.basename(dr_url)
base_zipname =  File.basename(basename, ".zip")

remote_file "#{Chef::Config.file_cache_path}/#{basename}" do
  checksum node.drelephant.checksum
  source dr_url
  owner node.drelephant.user
  group node.drelephant.group
  mode 0755
  action :create
end

drlock = "#{Chef::Config.file_cache_path}/.dr_downloaded"

bash "unpack_dr" do
    user "root"
    code <<-EOF
    set -e
    if [ -L #{node.drelephant.base_dir}  ; then
       rm -rf #{node.drelephant.base_dir} 
    fi
    cd #{Chef::Config.file_cache_path}
    unzip #{Chef::Config.file_cache_path}/#{basename}
    mv #{base_zipname} #{node.drelephant.dir}
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
  mode 0655
  variables({ 
        :my_url => my_url
           })
end



tmp_dirs   = ["FetcherConf.xml","HeuristicConf.xml","JobTypeConf.xml","resolver.conf"]

for d in tmp_dirs

  file "#{node.drelephant.home}/conf/#{d}" do
    action :delete
  end

  template "#{node.drelephant.home}/conf/#{d}" do
    source "#{d}.erb"
    owner node.drelephant.user
    group node.drelephant.group
    mode 0655
  end

end
