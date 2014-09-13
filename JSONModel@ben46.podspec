Pod::Spec.new do |s|
  s.name         = "JSONModel@ben46"
  s.version      = "0.14.0"
  s.summary      = "Magical Data Modelling & Data CRUD Framework for JSON. Create rapidly powerful, atomic and smart data model classes."
  s.homepage     = "http://github.com/ben46/JSONModel"

  s.license      = { :type => 'MIT', :file => 'LICENSE_jsonmodel.txt' }
  s.author       = { "Marin Todorov" => "touch-code-magazine@underplot.com",
                     "Zhuoqian Zhou" => "ben02060846@gmail.com"}

  s.source       = { :git => "https://github.com/ben46/JSONModel.git", :tag => "#{s.version}@ben46" }

  s.ios.deployment_target = '5.0'

  s.source_files = 'JSONModel/**/*.{m,h}'
  s.public_header_files = 'JSONModel/**/*.h'

  s.requires_arc = true
  s.dependency 'FMDB', '~> 2.3'

end
