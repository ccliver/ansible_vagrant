# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  HOSTS=2
  BOX='centos/7'
  PORTS_TO_FORWARD = {
    # 'host1' => {
    #   'ports' => [
    #     [ 443, 4443 ], # [ guest, host ]
    #     [ 80, 8080 ]
    #   ]
    # }
  }

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
    hostname = "host#{instance}"
    config.vm.define hostname do |host|
      host.vm.box = BOX
      host.vm.hostname = hostname
      host.vm.network :private_network, ip: "172.16.1.#{instance + 10}", netmask: '255.255.254.0'
      host.vm.provider 'virtualbox' do |vb|
        vb.memory = '512'
      end
      if PORTS_TO_FORWARD.include?(hostname)
        PORTS_TO_FORWARD[hostname]['ports'].each do |ports|
          host.vm.network 'forwarded_port', guest: ports[0], host: ports[1]
        end
      end
      host.vm.provision :shell do |s|
        s.path =  'bootstrap-node.sh'
        s.args = HOSTS
      end
    end
  end
end
