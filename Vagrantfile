# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
require "yaml"

vconfig = YAML::load_file("./config/aws.yml")
oconfig = YAML::load_file("./config/openstack.yml")

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define :dev do |dev|
    dev.vm.box = "precise64"
    dev.vm.box_url = "http://files.vagrantup.com/precise64.box"

    #dev.vm.network "forwarded_port", guest: 1883, host: 1883, auto_correct: false
    config.vm.network :public_network, :bridge => 'wlan0', ip: "192.168.1.201"

    dev.vm.hostname = "mosquitto-dev.local"

    dev.vm.synced_folder ".", "/srv/"

    dev.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--memory", "256", "--name", config.vm.hostname]
    end

    dev.vm.provision :salt do |salt|
        salt.minion_config = "./minion"
        salt.verbose = true
        salt.run_highstate = true
        salt.install_type = "daily"
    end
  end

  config.vm.define :cloud do |cloud|
    cloud.vm.box = "ubuntu_aws"
    cloud.vm.box_url = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"

    cloud.vm.synced_folder ".", "/srv/"

    cloud.vm.provider :aws do |aws, override|
        aws.access_key_id = vconfig["aws"]["access_key_id"]
        aws.secret_access_key = vconfig["aws"]["secret_access_key"]
        aws.keypair_name = vconfig["aws"]["keypair_name"]
        aws.region = vconfig["aws"]["region"]
        aws.instance_type = vconfig["aws"]["instance_type"]
        aws.ami = vconfig["aws"]["ami"]
        aws.tags = {
            'Name' => ' gps.mqtt.corley.it'
        }
        aws.security_groups = vconfig["aws"]["security_groups"]
        override.ssh.private_key_path = vconfig["aws"]["private_key_path"]
        override.ssh.username = vconfig["aws"]["ssh_username"]
    end

    cloud.vm.provision :shell, :inline => "hostname gps.mqtt.corley.it"

    cloud.vm.provision :salt do |salt|
        salt.minion_config = "./minion"
        salt.verbose = true
        salt.run_highstate = true
        salt.install_type = "daily"
    end
  end

  config.vm.define :test do |test|
    require 'vagrant-openstack-plugin'

    test.vm.box = "openstack_box"
    test.vm.box_url = "https://github.com/cloudbau/vagrant-openstack-plugin/raw/master/dummy.box"

    test.vm.synced_folder ".", "/srv/"

    test.ssh.private_key_path = "~/Enter/walterdalmut/wdm.pem"

    test.vm.provision :salt do |salt|
      salt.minion_config = "./minion"
      salt.verbose = true
      salt.run_highstate = true
      salt.install_type = "daily"
    end

    config.vm.provider :openstack do |os|
      os.server_name  = "gps.mqtt.corley.it"
      os.username     = oconfig["openstack"]["username"]
      os.api_key      = oconfig["openstack"]["api_key"]
      os.tenant       = oconfig["openstack"]["username"]
      os.keypair_name = oconfig["openstack"]["keypair_name"]
      os.floating_ip  = oconfig["openstack"]["floating_ip"]

      os.flavor       = /e1standard.x1/
      os.image        = /GNU\/Linux Ubuntu Server 14.04 LTS Trusty Tahr x64/
      os.endpoint     = "https://api.it-mil1.entercloudsuite.com/v2.0/tokens"
      os.ssh_username = "ubuntu"

      os.networks           = [ "MyNet" ]
      os.security_groups    = ['default', 'test-sg']
    end
  end
end
