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
      vm.memory_size = 2048
    end

    config.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = ["chef/cookbooks/opscode", "chef/cookbooks/my"]

      # opscode cookbooks
      chef.add_recipe("openssh")

      # my cookbooks
      chef.add_recipe("hadoop")

    end
  end
end