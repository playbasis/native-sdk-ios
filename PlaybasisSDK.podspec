#
# Be sure to run `pod lib lint PlaybasisSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PlaybasisSDK'
  s.version          = '0.1.9'
  s.summary          = 'PlaybasisSDK '

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Playbasis iOS SDK is a brand new iOS SDK from Playbasis for helping developers integrate their mobile apps with Playbasis gamification API.

The iOS SDK is designed to work effectively with mobile devices. For example, it provides:

High-level function API calls so that developers will find it is relatively easy to work with Playbasis API
However, the SDK didn't limit the access to low-level API calls so that, if needed, developers still can have a finer control
Automatically parse JSON responses into Objective-C objects
Works offline when there is no internet connection as the requests will be stored on the device (in an encrypted way)
Expose phone native features like phone events so it will very easy for developers to track their users' actions and learn more about their behavior
Next, more documentation and resources can be found below:

Developers can sign up here to get API key/secret
Next, one can try out our API Explorer
Download the SDK
Documentation is also available
                       DESC

  s.homepage         = 'https://github.com/playbasis/playbook-travel-ios'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Med' => 'med@smartsoftasia.com' }
  s.source           = { :git => 'git@github.com:playbasis/playbook-travel-ios.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'PlaybasisSDK/Classes/**/*'
  s.resources = 'PlaybasisSDK/Resources/PlaybasisSDK.bundle'

  # s.resource_bundles = {
  #   'PlaybasisSDK' => ['PlaybasisSDK/Recources/*']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Alamofire'
  s.dependency 'ObjectMapper'
  s.dependency 'SAMKeychain'
end
