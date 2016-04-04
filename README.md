Role Name
=========

Install and configure sudo(1)

Requirements
------------

None

Role Variables
--------------

|Variable                      | Description|
|------------------------------|-----------:|
|sudo\_configs                 | a hash of config fragments (see example below)|
|sudo\_configs\_to\_be\_removed| an array of config fragments to be removed|

Dependencies
------------

None

Example Playbook
----------------

    - hosts: servers
      roles:
         - { sudo }
      vars:
        sudo_configs_to_be_removed:
          - removeme
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
