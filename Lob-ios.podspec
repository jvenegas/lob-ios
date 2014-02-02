
Pod::Spec.new do |s|
  s.name = 'Lob-ios'
  s.version = '0.0.2'
  s.license = 'MIT'
  s.summary = "Lob.com iOS Client is a simple wrapper for the Lob.com API"
  s.homepage = 'https://github.com/lob/lob-ios'
  s.author = { 'Zealous Amoeba' => 'support@zealousamoeba.org' }
  s.source = { :git => 'https://github.com/lob/lob-ios.git', :tag => '0.0.1' }
  s.social_media_url = "https://twitter.com/lob"
  s.requires_arc = true
  s.platform     = :ios
  s.ios.deployment_target = '6.0'
  s.prefix_header_file = 'lob-ios/lob-ios-Prefix.pch'
  s.source_files  = 'lob-ios/{Models,Requests}/**/*.{h,m}', 'lob-ios/Constants/*.{h,m}'
  s.framework = 'Foundation'
end
