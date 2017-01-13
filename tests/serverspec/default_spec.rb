require 'spec_helper'

default_allow_group = ''
env_keeps = []

case os[:family]
when 'freebsd', 'openbsd', 'redhat'
  default_allow_group = 'wheel'
when 'debian', 'ubuntu'
  default_allow_group = 'sudo'
end

case os[:family]
when 'freebsd'
  env_keeps = %w[ PACKAGESITE PKGTOOLS_CONF ]
when 'openbsd'
  env_keeps = %w[ SM_PATH PKG_TMPDIR ]
end

describe package ('sudo') do
  it { should be_installed }
end


etc_dir = '/etc'
case os[:family]
when 'freebsd'
  etc_dir = '/usr/local/etc'
end

describe file("#{etc_dir}/sudoers.d") do
  it { should be_directory }
end

describe file("#{etc_dir}/sudoers.d/idcfop") do
  it { should be_file }
  it { should be_mode 440 }
  its(:content) { should match /User_Alias IDCF = idcfop/ }
  its(:content) { should match /Cmnd_Alias MAKE = \/usr\/bin\/make/ }
  its(:content) { should match /IDCF ALL = \(root\) MAKE/ }
end

describe file("#{etc_dir}/sudoers") do
  it { should be_file }
  it { should be_mode 440 }
  its(:content) { should match /^Defaults env_reset$/ }
  its(:content) { should match /^Defaults env_keep = "COLORS LS_COLORS PS1 PS2"$/ }
  its(:content) { should match /^root\s+ALL=\(ALL\)\s+SETENV:\s+ALL$/ }
  its(:content) { should match /^%#{ Regexp.escape(default_allow_group) } ALL=\(ALL\) ALL$/ }
  its(:content) { should match /^#includedir #{ Regexp.escape(etc_dir) }\/sudoers\.d$/ }

  env_keeps.each do |env|
    its(:content) { should match /^Defaults\s+env_keep\s+\+=\s+\"#{ env }\"$/ }
  end
end
