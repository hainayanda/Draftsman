#
# Be sure to run `pod lib lint Draftsman.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Draftsman'
  s.version          = '3.1.0'
  s.summary          = 'Draftsman is a DSL framework for Swift'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Draftsman is a DSL framework for Swift focussed on builder pattern
                       DESC

  s.homepage         = 'https://github.com/hainayanda/Draftsman'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'nayanda' => 'hainayanda@outlook.com' }
  s.source           = { :git => 'https://github.com/hainayanda/Draftsman.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'

  s.source_files = 'Draftsman/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Draftsman' => ['Draftsman/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Clavier', '~> 2.0.3'
  s.dependency 'Builder', '~> 1.1.0'
  s.swift_version = '5.5'
end
