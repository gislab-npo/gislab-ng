# -*- mode: ruby -*-
# vi: set ft=ruby :


#
### CONFIGURATION SECTION
#

Vagrant.require_version ">= 1.8.4"

box = "bento/ubuntu-16.04"

ROLES = {
    "master" => {
        "memory" => "2048",
        "ports" => [
            ["22", "10022"],
            ["5432", "15432"],
        ],
        "count" => "1",  # only one master server is supported
    },

    "node" => {
        "memory" => "1024",
        "ports" => [
            ["22", "10022"],
        ],
        "count" => "2",
    },
}


#
### DON'T CHANGE ANYTHING UNDER THIS LINE
#

Vagrant.configure(2) do |config|

    # config.vm.box_url = box_url
    config.vm.box = box

    config.ssh.forward_agent = true
    config.vm.synced_folder '.', '/vagrant'


    # loop over all configured roles`
    ROLES.each do | (role, cfg) |

        insts = Array.new

        # loop over all role instances`
        (1..cfg["count"].to_i).each do |i|

            if role == "master"
                iname = "master"
            else
                iname = "#{role}-#{i}"
            end

            config.vm.define iname do |inst|

                insts.push(iname)

                # IP address
                inst.vm.network "private_network",
                    type: "dhcp"

                # hostname
                inst.vm.hostname = iname.gsub("_", "-")

                # ports forwarding
                cfg["ports"].each do | port |
                    inst.vm.network "forwarded_port",
                        guest: port[0],
                        host: port[1],
                        auto_correct: true
                end


                ### PRODUCTION DEPLOYMENT
                inst.vm.provision "deploy", type: "ansible" do |ansible|
                    ansible.playbook = "system/" + role + "-deploy.yml"
                    ansible.verbose = "vv"
                    ansible.groups = {
                        "#{role}" => insts,
                    }
                    ansible.extra_vars = {
                        GISLAB_ROLE: "#{role}",
                        GISLAB_NETWORK_DEVICE: "enp0s8",
                    }
                end

                ### TEST
                if File.exist?("deployment/" + role + "-test.yml")
                    inst.vm.provision "test", type: "ansible" do |ansible|
                        ansible.playbook = "system/" + role + "-test.yml"
                        ansible.verbose = "vv"
                        ansible.groups = {
                            "#{role}" => insts,
                        }
                        ansible.extra_vars = {
                            GISLAB_ROLE: "#{role}",
                            GISLAB_NETWORK_DEVICE: "enp0s8",
                        }
                    end
                else
                    puts "WARNING: Role '#{role}' is missing integration tests !"
                end


                ### PROVIDERS CONFIGURATION
                # VirtualBox
                inst.vm.provider "virtualbox" do |vb, override|
                    vb.customize ["modifyvm", :id, "--memory", cfg["memory"]]
                    vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
                    vb.customize ["modifyvm", :id, "--nictype2", "virtio"]
    #               vb.gui = true
                end

                # Parallels
                inst.vm.provider "parallels" do |pl, override|
                    pl.memory = cfg["memory"]
                end
            end
        end
    end
end

# vim: set ts=4 sts=4 sw=4 et:
