# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/bionic64"

  config.vm.provision :shell, :path => "_install/bootstrap.sh"

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 443, host: 8443
  config.vm.network "forwarded_port", guest: 3306, host: 3306 # MySQL
  config.vm.network "forwarded_port", guest: 6379, host: 6379 # Redis
  config.vm.network "forwarded_port", guest: 11211, host: 11211 # Memcached

  config.vm.synced_folder ".", "/var/www", id: "vagrant-www", :owner => "www-data", :group => "www-data"

  config.vm.provider "virtualbox" do |v|

    v.memory = 2048
    v.cpus = 2

  end

end
