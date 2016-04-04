Role Name
=========

Install and configure sudo(1)

Requirements
------------

None

Role Variables
--------------

sudo\_configs: a hash of config fragments (see example below)
sudo\_configs\_to\_be\_removed: an array of config fragments

Dependencies
------------

None

Example Playbook
----------------

    - hosts: servers
      roles:
         - { sudo }
      vars:
        sudo_configs:
          foo:
            - User_Alias FOO = foo
            - Cmnd_Alias SH = /bin/sh
            - FOO ALL = (root) SH

License
-------

BSD

Author Information
------------------

Tomoyuki Sakurai <tomoyukis@reallyenglish.com>
