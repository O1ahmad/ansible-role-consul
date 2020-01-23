title "Default role integrated test file"

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
