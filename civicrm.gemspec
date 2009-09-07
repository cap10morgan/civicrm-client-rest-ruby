Gem::Specification.new do |s|
  s.name = "civicrm"
  s.version = "0.1.0"
  s.date = "2009-03-19"
  s.summary = "Library for accessing the CiviCRM REST API."
  s.email = "cap10morgan@gmail.com"
  s.authors = ["Wes Morgan"]
  s.files = ['civicrm.gemspec', 'lib/civicrm.rb', 'lib/civicrm/restclient.rb']
  s.add_dependency("json")
  s.add_dependency("rest-client")
  s.has_rdoc = false
end