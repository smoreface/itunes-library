Gem::Specification.new do |s|
  s.name      = 'andyw8-itunes-library'
  s.version   = '0.1.2'

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

  s.add_dependency 'plist'
  s.add_development_dependency 'rake'

  s.authors = ["Joshua Peek"]
  s.email   = ["josh@joshpeek.com"]
end
