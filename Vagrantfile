MEMORY = ENV['VAGRANT_MEMORY'] || '1024'
CORES = ENV['VAGRANT_CORES'] || '1'

Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.network "private_network", ip: "192.168.3.14"

  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", MEMORY.to_i]
    v.customize ["modifyvm", :id, "--cpus", CORES.to_i]
  end

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "ros.pp"
    puppet.module_path = "modules"
  end

end
