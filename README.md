# Kunstmaan I18n-Swift

## Features
- [x] Make use of the default Localizable.strings file.
- [x] Change the language of your app without changing the device language.
- [x] Make your images Localizable.
- [x] Interface builder support, you can configure your localization keys directly in the Interface Builder. If no localization key is found it will fallback to the original properties for the labels to show. 

## Installation

The preferred installation method of installation is using CocoaPods, this way you can configure the @IBDesignable and @IBInspectable properties in the Interface Builder. Apparently when using a standard IOS Framework these properties don't appear in the Interface Builder. 

http://stackoverflow.com/questions/29933691/ibdesignable-from-external-framework

### [CocoaPods](http://cocoapods.org/?q=KunstmaanI18nSwift)

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate KunstmaanI18nSwift into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'KunstmaanI18nSwift', '~> 1.0'
```

Then, run the following command:

```bash
$ pod install
```

Finally add this to your Bridging-Header.h file:

```objective-c
#import <KunstmaanI18nSwift/KunstmaanI18nSwift.h>
```

### [Carthage](https://github.com/Carthage/Carthage) (UNTESTED)

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate KunstmaanI18nSwift into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "Kunstmaan/i18n-swift" ~> 1.0
```

Run `carthage update` to build the framework and drag the built `KunstmaanI18nSwift.framework` into your Xcode project.

## Usage
