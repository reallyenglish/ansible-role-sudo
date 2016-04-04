require 'spec_helper'

describe package ('sudo') do
  it { should be_installed }
end


etc_dir = '/etc/sudo'
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
end

describe file("#{etc_dir}/sudoers.d/icinga") do
  it { should_not exist }
end

describe file("#{etc_dir}/sudoers") do
  it { should be_file }
  it { should be_mode 440 }
end
