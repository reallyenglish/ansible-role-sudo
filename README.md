# ansible-role-sudo

Install and configure sudo(8)

# Requirements

None

# Role Variables

|Variable                      | Description| Default |
|------------------------------|:-----------|---------|
|sudo\_package\_name           | package name | \_\_sudo\_package\_name |
|sudo\_configs                 | a hash of config fragments (see example below)| {} |
|sudo\_configs\_to\_be\_removed| an array of config fragments to be removed| [] |
|sudo\_conf\_env\_keep         | an array of environment variables to keep | \_\_sudo\_conf\_env\_keep |
|sudo\_conf\_default\_allow\_groups| an array of groups that can run any commands | \_\_sudo\_conf\_default\_allow\_groups |

## FreeBSD

| Variable | Default |
|----------|---------|
| \_\_sudo\_package\_name | sudo |
| \_\_sudo\_etc\_dir | /usr/local/etc |
| \_\_sudo\_conf\_default\_allow\_groups | ["wheel"] |
| \_\_sudo\_conf\_env\_keep | ["FTP\_PASSIVE\_MODE", "PACKAGEROOT", "PACKAGES", "PACKAGESITE", "PACKAGESITE\_MIRRORS", "PKG\_DBDIR", "PKGDIR", "PKG\_PATH", "PKG\_TMPDIR", "PKGTOOLS\_CONF", "PORTS\_DBDIR", "PORTSDIR", "PORTS\_INDEX", "TMPDIR"] |

## Debian

| Variable | Default |
|----------|---------|
| \_\_sudo\_package\_name | sudo |
| \_\_sudo\_etc\_dir | /etc |
| \_\_sudo\_conf\_env\_keep | [] |
| \_\_sudo\_conf\_default\_allow\_groups | ["sudo"] |

## OpenBSD

| Variable | Default |
|----------|---------|
| \_\_sudo\_package\_name | sudo-- |
| \_\_sudo\_etc\_dir | /etc |
| \_\_sudo\_conf\_default\_allow\_groups | ["wheel"] |
| \_\_sudo\_conf\_env\_keep | ["DESTDIR", "DISTDIR", "FETCH\_CMD", "FLAVOR", "FTPMODE", "GROUP", "MAKE", "MAKECONF", "MULTI\_PACKAGES", "NOMAN", "OKAY\_FILES", "OWNER", "PKG\_CACHE", "PKG\_DBDIR", "PKG\_DESTDIR", "PKG\_PATH", "PKG\_TMPDIR", "PORTSDIR", "RELEASEDIR", "SHARED\_ONLY", "SM\_PATH", "SSH\_AUTH\_SOCK", "SUBPACKAGE", "SUDO\_PORT\_V1", "WRKOBJDIR"] |

## Red Hat and CentOS

| Variable | Default |
|----------|---------|
| \_\_sudo\_package\_name | sudo |
| \_\_sudo\_etc\_dir | /etc |
| \_\_sudo\_conf\_env\_keep | [] |
| \_\_sudo\_conf\_default\_allow\_groups | ["wheel"] |

# Dependencies

None

# Example Playbook

```yaml
- hosts: servers
  roles:
     - ansible-role-sudo
  vars:
    sudo_configs_to_be_removed:
      - removeme
    sudo_configs:
      foo:
        - User_Alias FOO = foo
        - Cmnd_Alias SH = /bin/sh
        - FOO ALL = (root) SH
```

# License

BSD

# Author Information

Tomoyuki Sakurai <tomoyukis@reallyenglish.com>
