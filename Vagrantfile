# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  HOSTS=2
  BOX='ubuntu/xenial64'
  PORTS_TO_FORWARD = {
    # 80 => 8080
  }
  ANSIBLE_PRIVATE_KEY =
  ANSIBLE_PUBLIC_KEY = 

  config.vm.define :manager do |manager|
    manager.vm.box = BOX
    manager.vm.hostname = 'manager'
    manager.vm.network :private_network, ip: '172.16.0.11', netmask: '255.255.254.0'
    manager.vm.provider 'virtualbox' do |vb|
      vb.memory = '512'
    end
    manager.vm.provision :shell do |s|
      s.path = 'bootstrap-manager.sh'
      s.args = HOSTS
    end
  end

  (1..HOSTS).each do |instance|
    config.vm.define "host#{instance}" do |host|
      host.vm.box = BOX
      host.vm.hostname = "host#{instance}"
      host.vm.network :private_network, ip: "172.16.1.#{instance + 10}", netmask: '255.255.254.0'
      host.vm.provider 'virtualbox' do |vb|
        vb.memory = '512'
      end
      PORTS_TO_FORWARD.each { |k,v| host.vm.network 'forwarded_port', guest: k, host: v }
      host.vm.provision :shell, path: 'bootstrap-node.sh'
    end
  end

  config.vm.synced_folder "synced_data/", "/srv/synced_data"
end
