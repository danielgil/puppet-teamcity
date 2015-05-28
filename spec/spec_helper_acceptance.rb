require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'

hosts.each do |host|
    # Install Puppet
    install_puppet
end

RSpec.configure do |c|
    # Project root
    proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

    # Readable test descriptions
    c.formatter = :documentation

    # Configure all nodes in nodeset
    c.before :suite do

        # Install module and dependencies
        puppet_module_install(:source => proj_root, :module_name => 'skye2')

        hosts.each do |host|
            # Configure git for self signed cert
            on host, 'git config --global http.sslVerify false'

            # Download hiera data and configure hiera.yaml
            on host, 'git clone https://git.innoveo.com/scm/inf/data-acceptance-testing.git /etc/puppet/data'
            on host, 'cp /etc/puppet/data/hiera.yaml /etc/puppet/hiera.yaml'

            # Install puppet modules from forge
            on host, puppet('module', 'install', 'puppetlabs-stdlib'), { :acceptable_exit_codes => [0,1] }
            on host, puppet('module', 'install', 'puppetlabs-mysql'), { :acceptable_exit_codes => [0,1] }
            on host, puppet('module', 'install', 'maestrodev-wget'), { :acceptable_exit_codes => [0,1] }
            on host, puppet('module', 'install', 'tylerwalts-jdk_oracle'), { :acceptable_exit_codes => [0,1] }
        end
    end
end