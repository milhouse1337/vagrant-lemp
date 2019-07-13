#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# Locale.
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8
dpkg-reconfigure locales

# Fix timezone.
timedatectl set-timezone America/Montreal

# Fix for hosts file.
echo "127.0.0.1  localhost" > /etc/hosts
echo "127.0.0.1  bionic64" >> /etc/hosts
echo "127.0.0.1  vagrant-box" >> /etc/hosts

# Fix hostname.
echo "vagrant-box" > /etc/hostname

# Update and cleanup.
apt-get update
apt-get dist-upgrade -y
apt-get autoremove -y

# Install base packages.
apt-get install -y build-essential checkinstall software-properties-common

# Install tools.
apt-get install -y whois curl screen supervisor subversion git-core ack-grep htop vim

# Install Nginx.
apt-get install -y nginx

# Install PHP.
add-apt-repository -y ppa:ondrej/php
apt-get install -y php7.2 php7.2-fpm php7.2-curl php7.2-gd php7.2-intl php7.2-mbstring php7.2-sqlite3 php7.2-soap php7.2-xml php7.2-zip

# Install MariaDB (MySQL).
debconf-set-selections <<< 'mysql-server mysql-server/root_password password change_me'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password change_me'
apt-get install -y mariadb-server php7.2-mysql

# Install Memcached.
apt-get install -y memcached php-memcached

# Install Redis.
add-apt-repository -y ppa:chris-lea/redis-server
apt-get install -y redis-server

# Install Composer.
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Configure Nginx.
unlink /etc/nginx/sites-enabled/default
cp /var/www/_install/fpm-laravel.conf /etc/nginx/fpm-laravel.conf
cp /var/www/_install/nginx-vhost.conf /etc/nginx/conf.d/vhost.conf
service nginx reload

# Cleanup.
rm -rf /var/www/html

# All done.
echo ""
echo "##############################################################################"
echo "# Installation complete!                                                     #"
echo "# Please reboot to make sure it works fine with: vagrant reload              #"
echo "##############################################################################"
echo ""