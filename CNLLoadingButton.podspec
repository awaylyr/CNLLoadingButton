#CNLLoadingButton.podspec
Pod::Spec.new do |s|
  s.name         = "CNLLoadingButton"
  s.version      = "1.0.4"
  s.summary      = "a button with activity indicator."

  s.homepage     = "https://github.com/awaylyr/CNLLoadingButton"
  s.license      = 'MIT'
  s.author       = { "awaylyr" => "awaylyr@163.com" }
  s.platform     = :ios, "7.0"
  s.ios.deployment_target = "7.0"
  s.requires_arc = true

  s.source       = { :git => "https://github.com/awaylyr/CNLLoadingButton.git", :tag => s.version}

  s.source_files  = 'CNLLoadingButton/*.{h,m}'
  s.public_header_files = 'CNLLoadingButton/*.h'

  s.dependency 'ViewUtils'
  
end