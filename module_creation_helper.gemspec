$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'module_creation_helper/version'

Gem::Specification.new do |s|
  s.name              = "module_creation_helper"
  s.version           = ModuleCreationHelper::VERSION
  s.authors           = ["Aaron Pfeifer"]
  s.email             = "aaron@pluginaweek.org"
  s.homepage          = "http://www.pluginaweek.org"
  s.description       = "Adds a helper method for creating new modules and classes at runtime"
  s.summary           = "Proper runtime module creation"
  s.require_paths     = ["lib"]
  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- test/*`.split("\n")
  s.rdoc_options      = %w(--line-numbers --inline-source --title module_creation_helper --main README.rdoc)
  s.extra_rdoc_files  = %w(README.rdoc CHANGELOG.rdoc LICENSE)
  
  s.add_development_dependency("rake")
end
