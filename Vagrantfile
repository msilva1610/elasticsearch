# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # config.vm.box = 'ubuntu/xenial64' #Ubuntu 16.04 LTS

  # config.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: ".vagrant/, .git/"

  config.vm.define :elasticsearch10 do |elasticsearch10_config|
    elasticsearch10_config.vm.box = 'centos/7'
    elasticsearch10_config.vm.hostname = 'elasticsearch10'
    elasticsearch10_config.vm.network :private_network, ip: '192.168.110.10'
    elasticsearch10_config.vm.network :forwarded_port, guest: 9200, host: 9200
    elasticsearch10_config.vm.provision :shell, path: "es10.sh"
  end     
  config.vm.define :elasticsearch11 do |elasticsearch11_config|
    elasticsearch11_config.vm.box = 'centos/7' 
    elasticsearch11_config.vm.hostname = 'elasticsearch11'
    elasticsearch11_config.vm.network :private_network, ip: '192.168.110.11'
    elasticsearch11_config.vm.provision :shell, path: "es11.sh"    
  end
  config.vm.define :kibana do |kibana_config|
    kibana_config.vm.box = 'centos/7' 
    kibana_config.vm.hostname = 'kibana'
    kibana_config.vm.network :private_network, ip: '192.168.110.13'
    kibana_config.vm.network :forwarded_port, guest: 5601, host: 5601
    kibana_config.vm.provision :shell, path: "kibana.sh" 
  end           
  config.vm.define :logstash do |logstash_config|
    logstash_config.vm.box = 'centos/7' 
    logstash_config.vm.hostname = 'logstash'
    logstash_config.vm.network :private_network, ip: '192.168.110.12'
    logstash_config.vm.provision :shell, path: "ls01.sh" 
  end  
  config.vm.define :filebeat do |filebeat_config|
    filebeat_config.vm.box = 'centos/7' 
    filebeat_config.vm.hostname = 'filebeat'
    filebeat_config.vm.network :private_network, ip: '192.168.110.14'
    filebeat_config.vm.provision :shell, path: "filebeat.sh" 
  end    
  # filebeat com parse manual da log cisco
  config.vm.define :filebeat01 do |filebeat01_config|
    filebeat01_config.vm.box = 'centos/7' 
    filebeat01_config.vm.hostname = 'filebeat01'
    filebeat01_config.vm.network :private_network, ip: '192.168.110.15'
    filebeat01_config.vm.provision :shell, path: "filebeat.sh" 
  end 
  config.vm.define :filebeat02 do |filebeat02_config|
    # filebeat com parse manual da log cisco - automatizando instalacao
    filebeat02_config.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: ".vagrant/, .git/"
    filebeat02_config.vm.box = 'centos/7' 
    filebeat02_config.vm.hostname = 'filebeat02'
    filebeat02_config.vm.network :private_network, ip: '192.168.110.16'
    filebeat02_config.vm.provision :shell, path: "filebeat.sh" 
    filebeat02_config.vm.provision :shell, path: "filebeatyml.sh" 
    filebeat02_config.vm.provision :shell, path: "ciscomoduleyml.sh" 
  end   
end
