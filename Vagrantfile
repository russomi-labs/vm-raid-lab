Vagrant.require_version ">= 2.0.0"
require 'yaml'

# TODO: add this as a key to the list of machines
ansible_local_provision = false

# Read YAML file with config details
f = YAML.load_file(File.join(File.dirname(__FILE__), 'machines.yml'))

# Local PATH_SRC for mounting
$PathSrc = ENV['PATH_SRC'] || "."
Vagrant.configure(2) do |config|
  # These plugins are not required for this lab
  # config.vagrant.plugins = ["vagrant-hostmanager", "vagrant-vbguest","vagrant-registration"]

  # check for updates of the base image
  config.vm.box_check_update = false

  # wait a while longer
  config.vm.boot_timeout = 1200

  # disable update guest additions
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false
  end
  if Vagrant.has_plugin?('vagrant-registration')
    config.registration.username = ENV['SUB_USERNAME']
    config.registration.password = ENV['SUB_PASSWORD']
  end

  # enable ssh agent forwarding
  config.ssh.forward_agent = true

  # use the standard vagrant ssh key
  config.ssh.insert_key = false

  # manage /etc/hosts
  if Vagrant.has_plugin?('vagrant-hostmanager')
    config.hostmanager.enabled = true
    config.hostmanager.include_offline = true
    config.hostmanager.manage_guest = true
    config.hostmanager.manage_host = true
  end

  # Iterate through entries in YAML file
  f['machines'].each do |g|
    config.vm.define g['name'] do |s|
      s.vm.box = g['box']
      s.vm.hostname = g['name']
      s.vm.network 'private_network', ip: g['ip_addr']

      if g['forwarded_port'] && g['app_port']
        s.vm.network :forwarded_port,
          host: g['forwarded_port'],
          guest: g['app_port']
      end

      # add disks for RAID setup
      # this adds 4 x 5GB disks to the VM
      (0..3).each do |i|
        s.vm.disk :disk, size: "5GB", name: "disk-#{i}"
      end

      # set no_share to false to enable file sharing
      s.vm.synced_folder ".", "/vagrant", disabled: g['no_share']

      s.vm.provider :virtualbox do |virtualbox|
        virtualbox.customize ["modifyvm", :id,
          "--audio", "none",
          "--cpus", g['cpus'],
          "--memory", g['memory'],
          "--graphicscontroller", "VMSVGA",
          "--vram", "64"
        ]
        virtualbox.gui = g['gui']
        virtualbox.name = g['name']
      end
    end
  end

  if ansible_local_provision
    config.vm.provision "ansible_local" do |ansible|
      ansible.compatibility_mode = "2.0"
      ansible.galaxy_role_file = "roles/requirements.yml"
      ansible.galaxy_roles_path = "roles"
      ansible.playbook = "playbook.yml"
      ansible.verbose = "vv"
    end
  end
end
