title "Default role integrated test file"

describe user('consul') do
  it { should exist }
end

describe group('consul') do
  it { should exist }
end

describe directory('/opt/consul') do
  it { should exist }
  its('owner') { should eq 'consul' }
  its('group') { should eq 'consul' }
  its('mode') { should cmp '0755' }
end
