Gem::Specification.new do |s|
  s.name               = "jobs-dependency"
  s.version            = "0.0.1"
  s.default_executable = "jobs-dependency"

  s.authors = ["Shawn Wang"]
  s.date = %q{2012-07-27}
  s.description = %q{A Ruby Test}
  s.email = %q{shawn.wang.uk@gmail.com}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Ruby Test by Shawn!}
  s.test_files = Dir.glob('test/*') 

  s.files = Dir.glob('lib/*.rb')
  s.executables = ['jobs-dependency']
end

