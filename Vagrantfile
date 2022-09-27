masters = {
  "master" => {"memory" => "1024", "cpu" => "1", "image" => "bento/ubuntu-22.04", "ipaddr" => "199.199.0.2"}
}
workers = {
  "no1" => {"memory" => "1024", "cpu" => "1", "image" => "bento/ubuntu-22.04", "ipaddr" => "199.199.0.3"},
  "no2" => {"memory" => "1024", "cpu" => "1", "image" => "bento/ubuntu-22.04", "ipaddr" => "199.199.0.4"},
  "no3" => {"memory" => "1024", "cpu" => "1", "image" => "bento/ubuntu-22.04", "ipaddr" => "199.199.0.5"}
}

Vagrant.configure(2) do |config|
  masters.each do |name, conf|
    config.vm.define "#{name}" do |manager|
      manager.vm.box = "#{conf["image"]}"
      manager.vm.hostname = "#{name}"
      manager.vm.network "public_network", bridge: "eth0", ip: "#{conf["ipaddr"]}"
      manager.vm.provision "shell",
        run: "always",
        inline: "ip route add default via 199.199.0.1"
      manager.vm.provider "virtualbox" do |vb|
        vb.name = "#{name}"
        vb.memory = conf["memory"]
        vb.cpus = conf["cpu"]
      end
      manager.vm.provision "shell", path: "instalar_docker_master.sh"
    end
  end
end

Vagrant.configure(2) do |config|
  workers.each do |name, conf|
    config.vm.define "#{name}" do |machine|
      machine.vm.box = "#{conf["image"]}"
      machine.vm.hostname = "#{name}"
      machine.vm.network "public_network", bridge: "eth0", ip: "#{conf["ipaddr"]}"
      machine.vm.provision "shell",
        run: "always",
        inline: "ip route add default via 199.199.0.1"
      machine.vm.provider "virtualbox" do |vb|
        vb.name = "#{name}"
        vb.memory = conf["memory"]
        vb.cpus = conf["cpu"]
      end
      machine.vm.provision "shell", path: "instalar_docker_worker.sh"
    end
  end
end
