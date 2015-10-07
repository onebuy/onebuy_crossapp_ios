Pod::Spec.new do |s|
  s.name         = "OneBuy"
  s.version      = "1.0.2"
  s.summary      = "Biblioteca para integração CrossApp no iOS"
  s.homepage         = "https://github.com/onebuy/onebuy_crossapp_ios"
  s.license          = { :type => 'BSD' }
  s.authors          = "OneBuy"
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/onebuy/onebuy_crossapp_ios.git", :tag => s.version }
  s.source_files  = "OneBuy/**/*.h"
  s.framework    = "Security"
  s.requires_arc = true
  s.dependency "AFNetworking"
end
