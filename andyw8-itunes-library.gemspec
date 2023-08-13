Gem::Specification.new do |s|
  s.name      = 'andyw8-itunes-library'
  s.version   = '0.1.4'

  s.homepage    = "https://github.com/andyw8/itunes-library"
  s.summary     = "Wrapper around iTunes Library.xml"
  s.description = <<-EOS
    A Ruby library that makes it easy to dig around your iTunes Library metadata.
  EOS

  s.files = [
    'lib/itunes/library.rb',
    'lib/itunes/playlist.rb',
    'lib/itunes/track.rb',
    'LICENSE',
    'README.md'
  ]

  s.required_ruby_version = '>= 3.0.0'

  s.add_dependency 'plist', ">= 3.7.0"
  s.add_development_dependency 'rake', ">= 13.0.6"
  s.add_development_dependency 'test-unit', ">= 3.5.3"

  s.authors = ["Joshua Peek"]
  s.email   = ["josh@joshpeek.com"]
end
