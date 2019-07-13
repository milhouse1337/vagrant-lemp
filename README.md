# Vagrant LEMP stack

[![Tested on Vagrant 2.2.x](https://img.shields.io/badge/Tested%20on%20Vagrant-2.2.x-blue.svg)](https://www.vagrantup.com/)
[![Version 2.0](https://img.shields.io/badge/Version-2.0-success.svg)](#)

This script will automate the setup of a PHP developement box.

## Includes

- Ubuntu 18.04 (LTS)
- Nginx 1.14+
- PHP 7.2+
- MariaDB 10.1+ (~MySQL 5.7+)
- Redis 5.0+
- Memcached
- Composer

## Requirements

- OSX (Windows and Linux might work but are not covered here)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant](http://www.vagrantup.com/)

## Install

You can clone the following Git repo in a folder called `Vagrant` in your home directory. 

```bash
git clone https://github.com/milhouse1337/vagrant-lemp.git ~/Vagrant
cd ~/Vagrant
```

You need to remove the `.git` folder because this folder will become your dev root and there should be no `.git` folder a this level.

```bash
rm -rf .git
```

Open the following files and make sure they fit your desired configuration. For example the timezone, the MySQL root password and vhost might have to be changed.

> ~/Vagrant/_install/bootstrap.sh
> ~/Vagrant/_install/nginx-vhost.sh

When everything seems fine you can start the installation:

```bash
vagrant up
```

Coffee time! ☕️ You will have to wait a few minutes for the script to complete. When everything is done you can restart the VM to make sure everything works as expected:

```bash
vagarant reload
```

You now have a complete LEMP setup to play with. 🥳

## Test your setup

Create the following folders and PHP file: 

```bash
mkdir -p ~/Vagrant/test.127.0.0.1.xip.io/public
echo "<?php phpinfo(); ?>" > ~/Vagrant/test.127.0.0.1.xip.io/public/index.php
```

Open to the following on your browser:

[http://test.127.0.0.1.xip.io:8080](http://test.127.0.0.1.xip.io:8080)

You should see a `phpinfo()` output. 🚀

> Note: If you want Vagrant to listen on port 80 you might have to forward the port 80 on port 8080 with `pf` (the built-in MacOS firewall). More information [here](https://stackoverflow.com/questions/17437137/vagrant-wont-forward-only-port-80).

### How does it work ? I didn't changed my hosts file or anything and it works. 🤔

- The DNS part is handled by [xip.io](http://xip.io) which is a free service that is ment exactly for this purpose. It resolves any subdomain to the IP address you specify.
- We use a wildcard for the default Nginx vhost so the document root is always `/var/www/{hostname}/public` for the VM and `~/Vagrant/{hostname}/public` on your local machine.

## Vagrant cheat sheet

```bash
vagrant up # Boot the VM. (install if not already provisioned)
vagrant ssh # Login on the VM as user "vagrant".
vagrant reload # Reboot the VM.
vagrant halt # Poweroff the VM.
vagrant destroy # Delete the VM.
```

## License

The MIT License (MIT). Please see [License File](LICENSE.md) for more information.
