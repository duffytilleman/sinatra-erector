# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sinatra-erector}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Alex Chaffee"]
  s.date = %q{2009-05-20}
  s.description = %q{Sinatra plugin to enable erector (.erector) template rendering.}
  s.email = %q{alex@stinky.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION.yml",
    "lib/sinatra/erector.rb",
    "test/sinatra_erector_test.rb",
    "test/test_helper.rb",
    "test/views/hello.erector",
    "test/views/html.erector"
  ]
  s.homepage = %q{http://github.com/alexch/sinatra-erector}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{Sinatra plugin to enable erector (.erector) template rendering.}
  s.test_files = [
    "test/sinatra_erector_test.rb",
    "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<erector>, [">= 0"])
    else
      s.add_dependency(%q<erector>, [">= 0"])
    end
  else
    s.add_dependency(%q<erector>, [">= 0"])
  end
end
