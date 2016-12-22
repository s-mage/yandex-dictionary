lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yandex_dictionary/version'

Gem::Specification.new do |s|
  s.name        = 'yandex-dictionary'
  s.date        = '2014-01-15'
  s.version     = Yandex::Dictionary::VERSION
  s.authors     = ["Sergey Smagin"]
  s.email       = 'smaginsergey1310@gmail.com'
  s.description = "Library for Yandex Dictionary API"
  s.summary     = "Yandex Dictionary API"
  s.homepage    = 'https://github.com/s-mage/yandex-dictionary'
  s.files       = `git ls-files -- lib`.split("\n")
  s.license     = 'MIT'

  s.add_dependency 'httparty'
  s.add_development_dependency 'rspec', '~> 3.1'
  s.add_development_dependency 'webmock'
  s.require_paths = ['lib']
end
