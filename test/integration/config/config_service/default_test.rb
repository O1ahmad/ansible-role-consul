title "Consul configuration test suite"

describe directory('/etc/consul/') do
  it { should exist }
  its('owner') { should eq 'consul' }
  its('group') { should eq 'consul' }
end

describe file('/etc/consul/test-example.json') do
  it { should exist }
  its('owner') { should eq 'consul' }
  its('group') { should eq 'consul' }

  its('content') { should match('datacenter') }
  its('content') { should match('data_dir') }
end

describe directory('/mnt/etc/consul') do
  it { should exist }
  its('owner') { should eq 'consul' }
  its('group') { should eq 'consul' }
end

describe file('/mnt/etc/consul/path-test.json') do
  it { should exist }
  its('owner') { should eq 'consul' }
  its('group') { should eq 'consul' }

  its('content') { should match('datacenter') }
  its('content') { should match('log_level') }
  its('content') { should match('log_file') }
end

describe directory('/var/data/consul') do
  it { should exist }
  its('owner') { should eq 'consul' }
  its('group') { should eq 'consul' }
end

describe file('/mnt/var/log/consul/consul.log') do
  it { should exist }
  its('owner') { should eq 'consul' }
  its('group') { should eq 'consul' }
end
