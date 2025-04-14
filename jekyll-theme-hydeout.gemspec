# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "jekyll-theme-hydeout"
  spec.version       = "5.0.2"
  spec.authors       = ["Andrew Fong"]
  spec.email         = ["id@andrewfong.com"]
  spec.summary       = %q{The Hyde theme for Jekyll, refreshed.}
  spec.homepage      = "https://github.com/fongandrew/hydeout"
  spec.license       = "MIT"

  spec.metadata["plugin_type"] = "theme"

  spec.files         = `git ls-files -z`.split("\x0").select do |f|
    f.match(%r{^(assets|_(includes|layouts|sass)/|(LICENSE|README)((\.(txt|md|markdown)|$)))}i)
  end

  spec.required_ruby_version = '~> 3.0'

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }

  spec.add_runtime_dependency "jekyll", ">= 4.0", "< 5.0"
  spec.add_runtime_dependency "jekyll-gist", "~> 1.5"
  spec.add_runtime_dependency "jekyll-paginate", "~> 1.1"
  spec.add_runtime_dependency "jekyll-feed", "~> 0.17"
  spec.add_runtime_dependency "jekyll-include-cache", "~> 0.2"
  spec.add_runtime_dependency "jemoji", "~> 0.13"
  spec.add_development_dependency "bundler", "~> 2.6"
  spec.add_development_dependency "wdm", "~> 0.1" if Gem.win_platform?
end
