source 'https://rubygems.org'

group :test do
  gem 'rake'
  gem 'puppet', ENV['PUPPET_VERSION'] || '~> 3.7.0'
  gem 'puppet-lint'
  gem 'rspec-puppet'
  gem 'puppet-syntax'
  gem 'puppetlabs_spec_helper'
end

group :development do
  gem 'minitest'
  gem 'minitest-reporters'
  gem 'beaker', '~>2.9.0'
  gem 'beaker-rspec'
  gem 'vagrant-wrapper'
end

