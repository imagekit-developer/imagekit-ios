Pod::Spec.new do |s|
  s.name             = 'ImageKitIO'
  s.version          = '3.0.0'
  s.summary          = 'iOS SDK for ImageKit.io'


  s.description      = <<-DESC
iOS Pod for ImageKit.io which implements client-side upload and URL generation for use inside an iOS application.
ImageKit is a complete image optimization and transformation solution that comes with an image CDN and media storage. It can be integrated with your existing infrastructure - storages like AWS S3, web servers, your CDN and custom domain names, allowing you to deliver optimized images in minutes with minimal code changes.
                       DESC

  s.homepage         = 'https://imagekit.io/'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ImageKit Developer' => 'developer@imagekit.io', 'ahnv' => 'abhinav@imagekit.io' }
  s.source           = { :git => 'https://github.com/imagekit-developer/imagekit-ios.git', :tag => s.version.to_s }

  s.swift_version    = '4.0'
  s.ios.deployment_target = '11.0'

  s.source_files = 'ImageKit/**/*'
#  s.dependency 'ReachabilitySwift'

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Tests/**/*'
    test_spec.dependency 'Quick', '~> 5.0.1'
    test_spec.dependency 'Nimble', '~> 10.0.0'
    test_spec.dependency 'Swifter', '~> 1.5.0'
  end
end
