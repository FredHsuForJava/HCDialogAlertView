#
# Be sure to run `pod lib lint HCDialogAlertView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HCDialogAlertView'
  s.version          = '0.0.3'
  s.summary          = 'An Alert Diaglog that can show coreText and View, this is easy for user to show something.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

#  s.description      = 'Add long description of the pod here.'

  s.homepage         = 'https://github.com/FredHsuForJava/HCAlertDialogHandler'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xuwenfeng' => 'xuwf@bsoft.com.cn' }
  s.source           = { :git => 'https://github.com/FredHsuForJava/HCAlertDialogHandler.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files  = 'HCDialogAlertView', 'HCDialogAlertView/**/*.{h,m}'
  s.requires_arc  = true
  # s.resource_bundles = {
  #   'HCDialogAlertView' => ['HCDialogAlertView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
   s.dependency 'TTTAttributedLabel'
end
