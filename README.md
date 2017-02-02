# ansible-role-sudo

Install and configure sudo(8)

## Note for Ubuntu xenial users

The role disables reading ENV, which is implemented in `/etc/pam.d/sudo`, from
`/etc/environment` to enforce `secure_path` in `sudoers(5)`.

# Requirements

None

# Role Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `sudo_etc_dir` | path to `etc` dir | `{{ __sudo_etc_dir }}` |
| `sudo_package_name` | package name | `{{ __sudo_package_name }}` |
| `sudo_configs` | a dict of config fragments | `{}` |
| `sudo_configs_to_be_removed` | list of config fragments to remove | `[]` |
| `sudo_conf_env_keep` | list of environment variables to keep | `{{ __sudo_conf_env_keep }}` |
| `sudo_conf_secure_path` | PATH enforced by default | `/usr/bin:/bin:/usr/local/bin:/usr/sbin:/sbin:/usr/local/sbin` |
| `sudo_conf_default_allow_groups` | list of groups that can run any commands as root | `{{ __sudo_conf_default_allow_groups }}` |

## Debian

| Variable | Default |
|----------|---------|
| `__sudo_package_name` | `sudo` |
| `__sudo_etc_dir` | `/etc` |
| `__sudo_conf_env_keep` | `[]` |
| `__sudo_conf_default_allow_groups` | `["sudo"]` |

## FreeBSD

| Variable | Default |
|----------|---------|
| `__sudo_package_name` | `sudo` |
| `__sudo_etc_dir` | `/usr/local/etc` |
| `__sudo_conf_default_allow_groups` | `["wheel"]` |
| `__sudo_conf_env_keep` | `["FTP_PASSIVE_MODE", "PACKAGEROOT", "PACKAGES", "PACKAGESITE", "PACKAGESITE_MIRRORS", "PKG_DBDIR", "PKGDIR", "PKG_PATH", "PKG_TMPDIR", "PKGTOOLS_CONF", "PORTS_DBDIR", "PORTSDIR", "PORTS_INDEX", "TMPDIR"]` |

## OpenBSD

| Variable | Default |
|----------|---------|
| `__sudo_package_name` | `sudo--` |
| `__sudo_etc_dir` | `/etc` |
| `__sudo_conf_default_allow_groups` | `["wheel"]` |
| `__sudo_conf_env_keep` | `["DESTDIR", "DISTDIR", "FETCH_CMD", "FLAVOR", "FTPMODE", "GROUP", "MAKE", "MAKECONF", "MULTI_PACKAGES", "NOMAN", "OKAY_FILES", "OWNER", "PKG_CACHE", "PKG_DBDIR", "PKG_DESTDIR", "PKG_PATH", "PKG_TMPDIR", "PORTSDIR", "RELEASEDIR", "SHARED_ONLY", "SM_PATH", "SSH_AUTH_SOCK", "SUBPACKAGE", "SUDO_PORT_V1", "WRKOBJDIR"]` |

## RedHat

| Variable | Default |
|----------|---------|
| `__sudo_package_name` | `sudo` |
| `__sudo_etc_dir` | `/etc` |
| `__sudo_conf_env_keep` | `[]` |
| `__sudo_conf_default_allow_groups` | `["wheel"]` |

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

```
Copyright (c) 2016 Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```

# Author Information

Tomoyuki Sakurai <tomoyukis@reallyenglish.com>
