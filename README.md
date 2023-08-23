# ansible-vm-lab

Details about a ansible-vm-lab

## Sample directory layout

```bash
production                # inventory file for production servers
staging                   # inventory file for staging environment

group_vars/
   group1.yml             # here we assign variables to particular groups
   group2.yml
host_vars/
   hostname1.yml          # here we assign variables to particular systems
   hostname2.yml

library/                  # if any custom modules, put them here (optional)
module_utils/             # if any custom module_utils to support modules, put them here (optional)
filter_plugins/           # if any custom filter plugins, put them here (optional)

site.yml                  # main playbook
webservers.yml            # playbook for webserver tier
dbservers.yml             # playbook for dbserver tier
tasks/                    # task files included from playbooks
    webservers-extra.yml  # <-- avoids confusing playbook with task files
```

## Testing inventory with ad-hoc commands

```bash
ansible test -a "date"
```

## Installing roles

```bash
ansible-galaxy install --roles-path . -r requirements.yml
```

## Topic 2

Details about Topic 2

## Resources

- [Ansible User Guide](https://docs.ansible.com/ansible/2.8/user_guide/index.html)
- [Vagrant Advanced Examples](https://ctrlnotes.com/vagrant-advanced-examples/#-insert-custom-ssh-public-key-to-the-vm)
- [Ansible tips and tricks | Sample Ansible setup | Sample directory layout](https://docs.ansible.com/ansible/latest/tips_tricks/sample_setup.html#id1)
- [Red Hat Enterprise Linux (RHEL) System Roles](https://access.redhat.com/articles/3050101)
- [Ways to check for open ports on RHEL](https://access.redhat.com/discussions/3539801)
