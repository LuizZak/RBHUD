#
# Be sure to run `pod lib lint RBHUD.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "RBHUD"
  s.version          = "0.1.0"
  s.summary          = "HUD written in Swift - Ready to use, no muss, no fuss..."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
HUD written in Swift - Ready to use, no muss, no fuss... Highly reusable HUD, completely written in Swift.
                       DESC

  s.homepage         = "https://github.com/robertBojor/RBHUD"
#  s.screenshots     = "https://github.com/robertBojor/RBHUD/blob/master/RBHUD/hud_gif.gif"
  s.license          = 'MIT'
  s.author           = { "Robert Bojor" => "robert.bojor@gmail.com" }
  s.source           = { :git => "https://github.com/robertBojor/RBHUD.git", :tag => s.version.to_s, :commit => "bab893581b36fcc362685e001b48933f45989ca2" }
  s.social_media_url = 'https://twitter.com/robert_bojor'

  s.platform     = :ios, '8.3'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/*'
  s.frameworks = 'UIKit', 'QuartzCore'
end
