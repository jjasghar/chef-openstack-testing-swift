require 'chef_metal'

with_chef_local_server :chef_repo_path => '~/repo/swift-stack/'

aiostorage_config = <<-ENDCONFIG
  config.vm.box = "trusty64"
  config.vm.network "forwarded_port", guest: 6002, host: 6002
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
    v.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
    v.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end
  config.vm.network "private_network", ip: "192.168.100.60"
  config.vm.network "private_network", ip: "10.0.0.10"
ENDCONFIG

machine 'aio-storage' do
  machine_options :vagrant_config => aiostorage_config
  role 'os-object-storage'
  chef_environment 'multi-swift'
  converge true
end

storage1_config = <<-ENDCONFIG
  config.vm.box = "trusty64"
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
    v.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
    v.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end
  config.vm.network "private_network", ip: "192.168.100.61"
  config.vm.network "private_network", ip: "10.0.0.11"
ENDCONFIG

machine 'storage1' do
  machine_options :vagrant_config => storage1_config
  role 'os-object-storage-object-server'
  chef_environment 'multi-swift'
  converge true
end

storage2_config = <<-ENDCONFIG
  config.vm.box = "trusty64"
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
    v.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
    v.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end
  config.vm.network "private_network", ip: "192.168.100.62"
  config.vm.network "private_network", ip: "10.0.0.12"
ENDCONFIG

machine 'storage2' do
  machine_options :vagrant_config => storage2_config
  role 'os-object-storage-object-server'
    chef_environment 'multi-swift'
  converge true
end

storage3_config = <<-ENDCONFIG
  config.vm.box = "trusty64"
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
    v.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
    v.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end
  config.vm.network "private_network", ip: "192.168.100.63"
  config.vm.network "private_network", ip: "10.0.0.13"
ENDCONFIG

machine 'storage3' do
  machine_options :vagrant_config => storage3_config
  role 'os-object-storage-object-server'
  chef_environment 'multi-swift'
  converge true
end
