# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/centos-6.8"

  config.vm.network "private_network", ip: "192.168.33.101"

  config.ssh.insert_key = false

  config.vm.provision :itamae do |config|
    config.sudo = true
    config.recipes = ['./roles/centos68/recipe.rb']
  end
end
