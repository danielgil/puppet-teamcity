require 'spec_helper_acceptance'

describe 'A server where we run the Skye Puppet module' do

  context 'as the initial installation' do
    it 'should complete with no errors' do
      pp = <<-EOS
          $allow_virtual_packages = false
          include teamcity::server
      EOS

      expect(apply_manifest(pp, :catch_failures => true).exit_code).to eq 2

    end
  end

  context 'after the installation' do
    # Test open ports
    ports = ['8111']
    ports.each do |port|
      describe port(port) do
        it { should be_listening }
      end
    end

    # Test running services
    services = ['teamcity']
    services.each do |service|
      describe service(service) do
        #it { should be_enabled }
        it { should be_running }
      end
    end
  end

  context 'without any changes' do
    it 'should not perform any actions' do
      pp = <<-EOS
          $allow_virtual_packages = false
          include teamcity::server
      EOS

      expect(apply_manifest(pp, :catch_failures => true).exit_code).to eq 0

    end
  end
end
