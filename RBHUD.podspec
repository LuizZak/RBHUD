Pod::Spec.new do |s|
  s.name             = "RBHUD"
  s.version          = "0.0.3"
  s.summary          = "HUD written in Swift - Ready to use, no muss, no fuss..."
  s.description      = <<-DESC
HUD written in Swift - Ready to use, no muss, no fuss... Highly reusable HUD, completely written in Swift.
                    DESC
  s.homepage         = "https://github.com/robertBojor/RBHUD"
  s.license          = 'MIT'
  s.author           = { "Robert Bojor" => "robert.bojor@gmail.com" }
  s.source           = { :git => "https://github.com/robertBojor/RBHUD.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/robert_bojor'
  s.platform     = :ios, '8.3'
  s.requires_arc = true
  s.source_files = 'Pod/Classes/*'
  s.frameworks = 'UIKit', 'QuartzCore'
end
