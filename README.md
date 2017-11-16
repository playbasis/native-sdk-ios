# PlaybasisSDK

[![CI Status](http://img.shields.io/travis/thanakij-playbasis/PlaybasisSDK.svg?style=flat)](https://travis-ci.org/thanakij-playbasis/PlaybasisSDK)
[![Version](https://img.shields.io/cocoapods/v/PlaybasisSDK.svg?style=flat)](http://cocoapods.org/pods/PlaybasisSDK)
[![License](https://img.shields.io/cocoapods/l/PlaybasisSDK.svg?style=flat)](http://cocoapods.org/pods/PlaybasisSDK)
[![Platform](https://img.shields.io/cocoapods/p/PlaybasisSDK.svg?style=flat)](http://cocoapods.org/pods/PlaybasisSDK)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

PlaybasisSDK is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "PlaybasisSDK"
```
If you would like to use specific branch for different swift version. Add below line based on your need.

```ruby
pod 'PlaybasisSDK', :git => 'https://github.com/playbasis/native-sdk-ios.git', :branch => 'swift4'

```
PlaybasisSDK also have below dependencies. If you have same dependencies in your `Podfile`, make sure dependencies version don't have conflicts.

* [`Alamofire`- 4.5.1](https://github.com/Alamofire/Alamofire)
* [`ObjectMapper`- 3.1.0](https://github.com/Hearst-DD/ObjectMapper)
* [`SAMKeychain`- 1.5.3](https://github.com/soffes/SAMKeychain)

## Development

There are 2 branches for support of different version of swift.

* `swift2.3` branch - for swift 2.3 support
* `swift3` branch - for swift 3 support (still in working progress)
* `swift4` branch - for swift 4 support

`master` branch has the latest development from `swift4`.

## Author

Playbasis Development Team, devteam@playbasis.com

## License

PlaybasisSDK is available under the MIT license. See the LICENSE file for more info.
