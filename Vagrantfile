# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/focal64"

  config.vm.provision :shell, :path => "_install/bootstrap.sh"

  config.vm.provision "shell", inline: "service nginx restart", run: "always"

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 443, host: 8443
  config.vm.network "forwarded_port", guest: 3306, host: 3306 # MySQL
  config.vm.network "forwarded_port", guest: 6379, host: 6379 # Redis
  config.vm.network "forwarded_port", guest: 11211, host: 11211 # Memcached

  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 3001, host: 3001
  config.vm.network "forwarded_port", guest: 3002, host: 3002
  config.vm.network "forwarded_port", guest: 3003, host: 3003
  config.vm.network "forwarded_port", guest: 3004, host: 3004
  config.vm.network "forwarded_port", guest: 3005, host: 3005

  if Vagrant::Util::Platform.windows?
    config.vm.network "private_network", type: "dhcp"
    config.vm.synced_folder ".", "/var/www", id: "vagrant-www", :type => "nfs", :mount_options => ["rw","async","fsc","nolock","vers=3","udp","rsize=32768","wsize=32768","hard","noatime","actimeo=2"]
  else
    # config.vm.network "forwarded_port", guest: 11300, host: 11300 # Beanstalk
      config.vm.synced_folder ".", "/var/www", id: "vagrant-www", :owner => "www-data", :group => "www-data"
  end

  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus = 4

    v.customize ["modifyvm", :id, "--ioapic", "on"]
    v.customize ["modifyvm", :id, "--nictype1", "virtio"]
    # v.customize ["modifyvm", :id, "--uartmode1", "disconnected"]
    v.customize ["modifyvm", :id, "--uartmode1", "file", File.join(Dir.pwd, "_install/console.log")]
  
  end


  if Vagrant::Util::Platform.windows? then
  # If you can't connect after windows update
  # Control Panel\Network and Internet\Network Connections
  # find all the "VirtualBox Host-Only Ethernet Adapter #" connections, disable and re-enable them
  # CMD admin
  # netsh interface show interface
  # netsh interface set interface "Ethernet 6" disable && netsh interface set interface "Ethernet 6" enable
  # netsh interface set interface "Ethernet 7" disable && netsh interface set interface "Ethernet 7" enable

  # Be sure that winnfsd is installed
    unless Vagrant.has_plugin?("vagrant-winnfsd")
      raise  Vagrant::Errors::VagrantError.new, "vagrant-winnfsd plugin is missing. Please install it using 'vagrant plugin install vagrant-winnfsd' and rerun 'vagrant up'"
    end
  end 
end
