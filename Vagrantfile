Vagrant.configure("2") do |config|
  config.vm.box = "codecool/ubuntu-18.04-base"

  config.vm.define "db", autostart: false do |db|
    db.vm.hostname = 'db'
    db.vm.network :"private_network", ip: "ADDRESS"
    db.vm.provision "file", source: "chinook_data.sql", destination: "/tmp/chinook_data.sql"
    db.vm.provision "shell", path: "db.sh"
  end

  config.vm.define "web1", autostart: false do |web|
    web.vm.hostname = 'web1'
    web.vm.network "forwarded_port", guest: 8080, host: 8080
    web.vm.provision "shell", path: "web.sh"
    web.vm.provision "shell", path: "web1.sh"
  end

  config.vm.define "web2", autostart: false do |web|
    web.vm.hostname = 'web2'
    web.vm.network "forwarded_port", guest: 8080, host: 8082
    web.vm.provision "shell", path: "web.sh"
    web.vm.provision "shell", path: "web2.sh"
  end

  config.vm.define "web3", autostart: false do |web|
    web.vm.hostname = 'web3'
    web.vm.network "forwarded_port", guest: 8080, host: 8083
    web.vm.provision "shell", path: "web.sh"
    web.vm.provision "shell", path: "web3.sh"
  end
end
