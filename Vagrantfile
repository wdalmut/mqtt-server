# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
require "yaml"

vconfig = YAML::load_file("./config/options.yml")

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.ssh.private_key_path = "~/.ssh/id_rsa"
  config.vm.define :dev do |dev|
    dev.vm.box = "precise64"
    dev.vm.box_url = "http://files.vagrantup.com/precise64.box"


    dev.vm.synced_folder ".", "/srv/"

    dev.vm.provision :salt do |salt|
        salt.minion_config = "./minion"
        salt.verbose = true
        salt.run_highstate = true
        salt.install_type = "daily"
    end

    dev.vm.provider "virtualbox" do |vb, override|
      vb.customize ["modifyvm", :id, "--memory", "256", "--name", config.vm.hostname]

      #override.vm.network "forwarded_port", guest: 1883, host: 1883, auto_correct: false
      override.vm.network :public_network, :bridge => 'wlan0', ip: "192.168.1.201"
      override.vm.hostname = "mosquitto-dev.local"
    end

    dev.vm.provider :aws do |aws, override|
        override.vm.box = "ubuntu_aws"
        override.vm.box_url = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"

        override.vm.hostname = "gps.mqtt.corley.it"

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

    dev.vm.provider :openstack do |os, override|
      override.vm.box = "openstack_box"
      override.vm.box_url = "https://github.com/cloudbau/vagrant-openstack-plugin/raw/master/dummy.box"

      os.server_name  = "gps.mqtt.corley.it"

      override.ssh.private_key_path = vconfig["openstack"]["private_key_path"]

      os.username     = vconfig["openstack"]["username"]
      os.api_key      = vconfig["openstack"]["api_key"]
      os.tenant       = vconfig["openstack"]["username"]
      os.keypair_name = vconfig["openstack"]["keypair_name"]
      os.floating_ip  = vconfig["openstack"]["floating_ip"]

      os.flavor       = /e1standard.x1/
      os.image        = /GNU\/Linux Ubuntu Server 14.04 LTS Trusty Tahr x64/
      os.endpoint     = "https://api.it-mil1.entercloudsuite.com/v2.0/tokens"
      os.ssh_username = "ubuntu"

      os.networks           = [ "MyNet" ]
      os.security_groups    = ['default', 'test-sg']
    end

    dev.vm.provider :digitalocean do |digitalocean, override|
      override.vm.box = "digital_ocean"
      override.vm.box_url = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"

      override.vm.hostname = "gps.mqtt.corley.it"

      digitalocean.api_key = vconfig["digitalocean"]["api_key"]
      digitalocean.image = vconfig["digitalocean"]["image"]
      digitalocean.region = vconfig["digitalocean"]["region"]
    end
  end
end
