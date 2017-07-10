# Kunstmaan I18n-Swift

## Features
- [x] Make use of the default Localizable.strings file.
- [x] Change the language of your app without changing the device language.
- [x] Make your images Localizable.
- [x] Interface builder support, you can configure your localization keys directly in the Interface Builder. If no localization key is found it will fallback to the original properties for the labels to show. 

Example project can be found here [i18n-swift-example](https://github.com/Kunstmaan/i18n-swift-example)

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

pod 'KunstmaanI18nSwift', '~> 2.0'
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
github "Kunstmaan/i18n-swift" ~> 2.0
```

Run `carthage update` to build the framework and drag the built `KunstmaanI18nSwift.framework` into your Xcode project.

## Usage

When the i18n module is loaded it will try to configure it self based on the preferred languages configured on the device. If no matching language is found there will be no language configured.

### Interface Builder

Following properties of UIViews have localization support inside the Interface Builder (the properties can also be set by code):

* UIButton
	- default title: **i18nDefaultTitleKey**
	- highlighted title: **i18nHighLightedTitleKey**
	- selected title: **i18nSelectedTitleKey**
	- disabled title: **i18nDisabledTitleKey**
* UILabel
	- text: **i18nTextKey**
* UINavigationItem
	- title: **i18nTitleKey**
* UITextField
	- placeholder: **i18nPlaceholderKey**

Special case: 

* UIImage
	- image: **i18nImageBaseName**

By providing the baseName of the image, the view will look for the image named "*baseName (locale)*". It's possible to override this format by extending the i18n class and overriding:

```swift
public func localizedImageNameFor(name: String, lang: String?) -> String 
```

### Code

You can make use of the String extension to quicky translate a key:

```swift
"your.translation.key".i18nLocalized
```

Or with extra options:

```swift
"your.translation.key".i18nLocalized(defaultValue: String, table: String, arguments: ...)
```

Or you can use the i18n class, to use this you should import the i18n module on top of your Swift classes where you want to use this:

```swift
import KunstmaanI18nSwift
```

This will make the i18n class available for you and gives you access to the following API:

* ```i18n.possibleLanguages```  This returns an array of languages which are configured for your project (for example: ["en", "nl"])
* ```i18n.language``` This returns a String value of the current configured language (for example: "en")
* ```i18n.locale``` This returns an NSLocale value of the current configured language
* ```i18n.hasLanguage``` Returns a boolean indicating if a current language is configured
* ```i18n.setLanguage(lang: String)``` Set the current language
* ```i18n.isCurrentLanguage(lang: String)``` Returns wheither the given language is the same as the current configured one
* ```i18n.clear()``` Removes any configured language
* ```i18n.localizedStringForKey(key: String, defaultValue: String, table: String, arguments: ...)``` Returns the translated value for this translation key
* ```i18n.localizedImageForName(name: String)``` Returns the localized UIImage for the given name ("*baseName (locale)*")

### Events

For now there is only one event being dispatched and that is when the Language is being changed. You can listen for this event as follows:

```swift
NSNotificationCenter.defaultCenter().addObserver(self, selector: "onLanguageChange", name: I18n.Events.OnChange, object: nil)
```

```swift
public func onLanguageChange(notification: NSNotification) {
	if let info = notification.userInfo as? Dictionary<String,String>, lang = info["lang"] {
		let oldLang = info["oldLang"]
		
		// Do something here
	}
}
```


