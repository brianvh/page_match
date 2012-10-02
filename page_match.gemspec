# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "page_match/version"

Gem::Specification.new do |s|
  s.name        = "page_match"
  s.version     = PageMatch::VERSION
  s.authors     = ["Brian V. Hughes"]
  s.email       = ["brianvh@mac.com"]
  s.homepage    = %(https://github.com/brianvh/page_match)
  s.summary     = %(#{s.name}-#{s.version})
  s.description = %(PageMatch: RSpec 2 matcher class for building custom
Capybara matchers in acceptance tests.)

  s.add_dependency 'capybara', '>= 1.0.0'

  s.add_development_dependency 'bundler', '>= 1.0.15'
  s.add_development_dependency 'rspec', '~> 2.6.0'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
