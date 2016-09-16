- hosts: all
  pre_tasks:
    - name: Include OS-specific vars
      include_vars: "roles/ansible-role-sudo/vars/{{ ansible_os_family }}.yml"
    - file:
        path: "{{ sudo_etc_dir }}/sudoers.d/icinga"
        state: touch
  roles:
    - ansible-role-sudo
  vars:
    sudo_configs:
      idcfop:
        - User_Alias IDCF = idcfop
        - Cmnd_Alias MAKE = /usr/bin/make
        - IDCF ALL = (root) MAKE
    sudo_configs_to_be_removed:
        - icinga
