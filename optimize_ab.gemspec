# -*- encoding: utf-8 -*-
require File.expand_path('../lib/optimize_ab/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Kevin Incorvia"]
  gem.email         = ["incorvia@gmail.com"]
  gem.description   = %q{Gem to integrate Google Optimize into Rails App}
  gem.summary       = %q{Gem to integrate Google Website Optimize into Rails apps}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "optimize_ab"
  gem.require_paths = ["lib"]
  gem.version       = OptimizeAb::VERSION
end
