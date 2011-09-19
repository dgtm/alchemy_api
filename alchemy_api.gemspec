# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "alchemy_api/version"

Gem::Specification.new do |s|
  # Metadata
  s.name        = "alchemy_api"
  s.version     = AlchemyApi::VERSION
  s.authors     = ["David Balatero"]
  s.email       = ["dbalatero@gmail.com"]
  s.homepage    = "http://github.com/dbalatero/alchemy_api"
  s.summary     = %q{AlchemyAPI Ruby Wrapper}
  s.description = %q{Provides a client API library for AlchemyAPI's awesome NLP services. Allows you to make parallel or serial requests.}

  s.rubyforge_project = "alchemy_api"

  # Manifest
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # Dependencies
  s.add_runtime_dependency "monster_mash"
  s.add_runtime_dependency "json"

  s.add_development_dependency "rspec"
  s.add_development_dependency "typhoeus_spec_cache"
end


