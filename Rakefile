require 'bundler'
Bundler.require(:rake)
require 'rake/clean'

CLEAN.include('spec/fixtures/', 'doc')

require 'puppetlabs_spec_helper/rake_tasks'

PuppetLint.configuration.send("disable_80chars")
