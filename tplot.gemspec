# -*- encoding: utf-8 -*-
require File.expand_path('../lib/tplot/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Mitoma Ryo"]
  gem.email         = ["mutetheradio@gmail.com"]
  gem.description   = %q{Tplot is text base graph plot tool.}
  gem.summary       = %q{Tplot is text base graph plot tool.}
  gem.homepage      = "https://github.com/mitoma/tplot"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "tplot"
  gem.require_paths = ["lib"]
  gem.version       = Tplot::VERSION

  gem.add_runtime_dependency "curses"
end
