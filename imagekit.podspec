#
# Be sure to run `pod lib lint imagekit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'imagekit'
  s.version          = '0.1.0'
  s.summary          = 'iOS client for ImageKit Integration'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'This is the iOS client for ImageKit Integration.'

  s.homepage         = 'https://github.com/imagekit-developer/imagekit-ios'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rungtaakki' => 'akshit@bowstringstudio.in' }
  s.source           = { :git => 'https://github.com/imagekit-developer/imagekit-ios.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    s.swift_version    = '4.0'

  s.ios.deployment_target = '8.0'

  s.source_files = 'imagekit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'imagekit' => ['imagekit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
    s.dependency 'Alamofire', '~> 4.0'
    s.dependency 'AlamofireObjectMapper', '5.0'
    s.dependency 'ObjectMapper', '3.3'
end
