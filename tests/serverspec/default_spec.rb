require "spec_helper"

default_allow_group = ""
env_keeps = []

case os[:family]
when "freebsd", "openbsd", "redhat"
  default_allow_group = "wheel"
when "debian", "ubuntu"
  default_allow_group = "sudo"
end

case os[:family]
when "freebsd"
  env_keeps = %w[
    FTP_PASSIVE_MODE
    PACKAGEROOT
    PACKAGES
    PACKAGESITE
    PACKAGESITE_MIRRORS
    PKG_DBDIR
    PKGDIR
    PKG_PATH
    PKG_TMPDIR
    PKGTOOLS_CONF
    PORTS_DBDIR
    PORTSDIR
    PORTS_INDEX
    TMPDIR
  ]
when "openbsd"
  env_keeps = %w[
    DESTDIR
    DISTDIR
    FETCH_CMD
    FLAVOR
    FTPMODE
    GROUP
    MAKE
    MAKECONF
    MULTI_PACKAGES
    NOMAN
    OKAY_FILES
    OWNER
    PKG_CACHE
    PKG_DBDIR
    PKG_DESTDIR
    PKG_PATH
    PKG_TMPDIR
    PORTSDIR
    RELEASEDIR
    SHARED_ONLY
    SM_PATH
    SSH_AUTH_SOCK
    SUBPACKAGE
    SUDO_PORT_V1
    WRKOBJDIR
  ]
end

describe package "sudo" do
  it { should be_installed }
end

etc_dir = "/etc"
case os[:family]
when "freebsd"
  etc_dir = "/usr/local/etc"
end

describe file("#{etc_dir}/sudoers.d") do
  it { should be_directory }
end

describe file("#{etc_dir}/sudoers.d/idcfop") do
  it { should be_file }
  it { should be_mode 440 }
  its(:content) { should match(/User_Alias IDCF = idcfop/) }
  its(:content) { should match(/Cmnd_Alias MAKE = #{Regexp.escape("/usr/bin/make")}/) }
  its(:content) { should match(/IDCF ALL = \(root\) MAKE/) }
end

describe file("#{etc_dir}/sudoers") do
  it { should be_file }
  it { should be_mode 440 }
  its(:content) { should match(/^Defaults env_reset$/) }
  its(:content) { should match(/^Defaults env_keep = "COLORS LS_COLORS PS1 PS2"$/) }
  its(:content) { should match(/^Defaults secure_path = "#{ Regexp.escape('/usr/bin:/bin:/usr/local/bin:/usr/sbin:/sbin:/usr/local/sbin') }"$/) }
  its(:content) { should match(/^root\s+ALL=\(ALL\)\s+SETENV:\s+ALL$/) }
  its(:content) { should match(/^%#{ Regexp.escape(default_allow_group) } ALL=\(ALL\) ALL$/) }
  its(:content) { should match(/^#includedir #{ Regexp.escape("#{etc_dir}/sudoers.d") }$/) }

  unless env_keeps.empty?
    its(:content) { should match(/^Defaults\s+env_keep\s+\+=\s+\"#{ env_keeps.join(' ') }\"$/) }
  end
end

if os[:family] == "ubuntu"
  describe file("/etc/pam.d/sudo") do
    it { should be_file }
    it { should be_mode 644 }
    its(:content) { should match(/^(?:session|auth)\s+required\s+pam_env\.so\s+readenv=0\s+user_readenv=0$/) }
  end
end

describe command("sudo env") do
  its(:exit_status) { should eq 0 }
  its(:stderr) { should match(/^$/) }
  its(:stdout) { should match(/^PATH=#{ Regexp.escape('/usr/bin:/bin:/usr/local/bin:/usr/sbin:/sbin:/usr/local/sbin') }$/) }
end
