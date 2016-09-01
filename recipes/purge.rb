  bash 'kill_running_service_drelephant' do
    user "root"
    ignore_failure true
    code <<-EOF
      service stop drelephant
      systemctl stop drelephant
      pkill -9 drelephant
    EOF
  end

  file "/etc/init.d/drelephant" do
    action :delete
    ignore_failure true
  end
  
  file "/usr/lib/systemd/system/drelephant.service" do
    action :delete
    ignore_failure true
  end
  file "/lib/systemd/system/drelephant.service" do
    action :delete
    ignore_failure true
  end

  directory node.drelephant.home do
    recursive true
    action :delete
    ignore_failure true
  end

  link node.drelephant.base_dir do
    action :delete
    ignore_failure true
  end


