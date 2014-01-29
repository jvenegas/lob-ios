
Pod::Spec.new do |s|
  s.name = 'Lob-ios'
  s.version = '0.0.1'
  s.license = 'MIT'
  s.summary = "Lob.com iOS Client is a simple wrapper for the Lob.com API"
  s.homepage = 'https://github.com/jvenegas/lob-ios'
  s.author = { 'Zealous Amoeba' => 'support@zealousamoeba.org' }
  s.source = { :git => 'https://github.com/jvenegas/lob-ios.git', :tag => '0.0.1' }
  s.social_media_url = "https://twitter.com/lob"
  s.requires_arc = true
  s.platform     = :ios
  s.ios.deployment_target = '6.0'
  s.source_files  = 'lob-ios/*'
  s.framework = 'Foundation'
end
