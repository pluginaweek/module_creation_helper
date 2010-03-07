# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{module_creation_helper}
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Aaron Pfeifer"]
  s.date = %q{2010-03-07}
  s.description = %q{Adds a helper method for creating new modules and classes at runtime}
  s.email = %q{aaron@pluginaweek.org}
  s.files = ["lib/module_creation_helper", "lib/module_creation_helper/extensions", "lib/module_creation_helper/extensions/module.rb", "lib/module_creation_helper.rb", "test/test_helper.rb", "test/module_creation_helper_test.rb", "CHANGELOG.rdoc", "init.rb", "LICENSE", "Rakefile", "README.rdoc"]
  s.homepage = %q{http://www.pluginaweek.org}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{pluginaweek}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Adds a helper method for creating new modules and classes at runtime}
  s.test_files = ["test/module_creation_helper_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
