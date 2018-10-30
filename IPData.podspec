#
# Be sure to run `pod lib lint IPData.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'IPData'
  s.version          = '1.0.0'
  s.summary          = 'Swift library to gather information for an IP using https://ipdata.co'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Swift library to gather information for an IP using https://ipdata.co.
Using the class `IPData` you can set an apiKey and perform lookups, bulk lookups and carrier lookups.
                       DESC

  s.homepage         = 'https://ipdata.co'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Victor Hugo Barros' => 'hey.zooi@gmail.com' }
  s.source           = { :git => 'https://github.com/heyzooi/IPData.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ipdata_co'

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.11'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.swift_version = '4.2'

  s.source_files = 'Sources/IPData/**/*'
  
  # s.resource_bundles = {
  #   'IPData' => ['IPData/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
