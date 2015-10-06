Pod::Spec.new do |s|
  s.name         = "OneBuy"
  s.version      = ‘1.0.0’
  s.summary      = "Biblioteca para integração CrossApp no iOS"
  s.homepage     = "https://github.com/onebuy/onebuy_crossapp_ios"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = "OneBuy"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/onebuy/onebuy_crossapp_ios.git", :tag => s.version }
  s.source_files = "OneBuy/**/*.{h,m}"
  s.framework    = "Security"
  s.requires_arc = true

  s.dependency "AFNetworking"
end
