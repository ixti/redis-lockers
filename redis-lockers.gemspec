# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "redis/lockers/version"

Gem::Specification.new do |spec|
  spec.name          = "redis-lockers"
  spec.version       = Redis::Lockers::VERSION
  spec.authors       = ["Alexey Zapparov"]
  spec.email         = ["ixti@member.fsf.org"]

  spec.summary       = "Yet another Redis-based lock manager."
  spec.description   = <<~DESCRIPTION
    Simplified implementation of Redlock (distributed lock manger by antirez).
    Right now it works with single Redis node only.
  DESCRIPTION

  spec.homepage      = "https://github.com/ixti/redis-lockers"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "concurrent-ruby",    "~> 1.0"
  spec.add_runtime_dependency "redis",              "~> 4.0"
  spec.add_runtime_dependency "redis-prescription", "~> 1.0"

  spec.add_development_dependency "bundler", "~> 1.16"

  spec.required_ruby_version = "~> 2.3"
end
