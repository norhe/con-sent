# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version.
# NB: Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/xenial64"

  #config.vm.provision "fix-no-tty", type: "shell" do |s|
  #  s.privileged = false
  #  s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
  #end

  config.vm.define "server" do |s1|
      s1.vm.hostname = "s1"
      s1.vm.network "private_network", ip: "172.20.20.10"
      config.vm.provision "shell",
        path: "./scripts/provision_consul.sh",
        args: "server"
      config.vm.provision "shell",
        path: "./scripts/enable_acl.sh"
  end

  config.vm.define "client" do |c1|
      c1.vm.hostname = "c1"
      c1.vm.network "private_network", ip: "172.20.20.11"
      config.vm.provision "shell",
        path: "./scripts/provision_consul.sh",
        args: "client"
      config.vm.provision "shell",
        path: "./scripts/enable_acl.sh"
  end
end
