control 'security-checks-1.1' do
  impact 0.7 # High Impact
  title 'Verify Docker Container Image source'
  tag "nist": ['SI-10', 'Rev_4']

  describe docker_container(name: attribute('application_container_name')) do
    its('repo') { should eq 'nemonik/helloworld-web' }
    its('tag') { should eq 'latest' }
  end
end

application_url = attribute('application_url')

control 'security-checks-1.2' do
  impact 0.7 # High Impact
  title 'Verify application is running securely'
  tag "nist": ['SC-8', 'Rev_4']

  describe http("https://#{application_url}", enable_remote_worker: true, ssl_verify: false) do
    its('body') { should cmp 'awesome' }
  end
end
