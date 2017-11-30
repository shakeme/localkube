# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  
  config.vm.box = "ubuntu/xenial64"
  config.vm.box_check_update = false
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  # config.vm.network "public_network"
  # config.vm.synced_folder "../data", "/vagrant_data"
  # config.vm.usable_port_range = 2200..2250
  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 2
    vb.gui = false
    vb.memory = "512"
  end

  # provision
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get dist-upgrade --assume-yes
    apt-get install --assume-yes \
      python \
      virtualbox-guest-utils
  SHELL

  config.vm.provision "shell" do |s|
    ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
    s.inline = <<-SHELL
      echo #{ssh_pub_key} >> /home/ubuntu/.ssh/authorized_keys
    SHELL
  end

#  config.vm.provision "ansible" do |ansible|
#    ansible.playbook = "ansible/site.yml"
#    #ansible.verbose = "vvv"
#    ansible.groups = {
#      "etcd"  => ["etcd[1:2]"]
#    }
#  end

  # do not change the number 
  NE = 3
  (1..NE).each do |machine_id|
    config.vm.define "etcd#{machine_id}" do |etcd|
      etcd.vm.hostname = "etcd#{machine_id}"
      etcd.vm.network "private_network", ip: "10.240.0.1#{machine_id}"
    end
  end


  # do not change the number
  NC = 3
  (1..NC).each do |machine_id|
    config.vm.define "controller#{machine_id}" do |controller|
      controller.vm.hostname = "controller#{machine_id}"
      controller.vm.network "private_network", ip: "10.240.0.2#{machine_id}"
    end
  end

  # do not change the number
  NW = 2
  (1..NW).each do |machine_id|
    config.vm.define "worker#{machine_id}" do |worker|
      worker.vm.hostname = "worker#{machine_id}"
      worker.vm.network "private_network", ip: "10.240.0.3#{machine_id}"

      worker.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
      end
    end
  end

  # do not change the number
  NL = 2
  (1..NL).each do |machine_id|
    config.vm.define "lb#{machine_id}" do |lb|
      lb.vm.hostname = "lb#{machine_id}"
      lb.vm.network "private_network", ip: "10.240.0.4#{machine_id}"

      lb.vm.provider "virtualbox" do |vb|
        vb.memory = "256"
      end
    end
  end

end

# vim: ai expandtab ts=2 sts=2 sw=2

