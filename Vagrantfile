# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "hdp"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  #config.vm.share_folder "ook-home", "/ook", "../"

  config.vm.define :hdp1 do |config|
    config.vm.box = "hdp"
    config.vm.network :hostonly, '33.33.33.10'
    config.vm.customize do |vm|
      vm.memory_size = 1024
    end

    config.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "chef/cookbooks"

      chef.add_recipe("apt")
      # chef.add_recipe("openssl")

    end
  end
end