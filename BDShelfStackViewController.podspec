#
# Be sure to run `pod lib lint BDShelfStackViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BDShelfStackViewController'
  s.version          = '0.0.1'
  s.summary          = 'Multiple tables within table the easy way.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Tables within tables – the easy way. Veritcally scrollables mixed with horizontally scrollables on one page. Built for quick prototyping or releasing apps that needs product or content browsing, e.g. shopping or showcase apps.
                       DESC

  s.homepage         = 'https://github.com/norsez/BDShelfStackViewController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'norsez' => 'norsez@gmail.com' }
  s.source           = { :git => 'https://github.com/norsez/BDShelfStackViewController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'BDShelfStackViewController/Classes/**/*'
  
  # s.resource_bundles = {
  #   'BDShelfStackViewController' => ['BDShelfStackViewController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'

    s.swift_version = '4.0'
end
