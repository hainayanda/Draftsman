# Clavier

Clavier is Keyboard Layout Guide for iOS. It using an intersection frame to calculate the Layout Guide.

[![codebeat badge](https://codebeat.co/badges/e012c68d-22fa-430a-8eb4-0c149d31f547)](https://codebeat.co/projects/github-com-hainayanda-clavier-main)
![build](https://github.com/hainayanda/Clavier/workflows/build/badge.svg)
![test](https://github.com/hainayanda/Clavier/workflows/test/badge.svg)
[![SwiftPM Compatible](https://img.shields.io/badge/SwiftPM-Compatible-brightgreen)](https://swift.org/package-manager/)
[![Version](https://img.shields.io/cocoapods/v/Clavier.svg?style=flat)](https://cocoapods.org/pods/Clavier)
[![License](https://img.shields.io/cocoapods/l/Clavier.svg?style=flat)](https://cocoapods.org/pods/Clavier)
[![Platform](https://img.shields.io/cocoapods/p/Clavier.svg?style=flat)](https://cocoapods.org/pods/Clavier)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Swift 5.1 or higher
- iOS 10.0 or higher

## Installation

## Requirements

- Swift 5.1 or higher
- iOS 10.0 or higher

### Cocoapods

Clavier is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Clavier', '~> 2.0.1'
```

### Swift Package Manager from XCode

- Add it using XCode menu **File > Swift Package > Add Package Dependency**
- Add **https://github.com/hainayanda/Clavier.git** as Swift Package URL
- Set rules at **version**, with **Up to Next Major** option and put **2.0.1** as its version
- Click next and wait

### Swift Package Manager from Package.swift

Add as your target dependency in **Package.swift**

```swift
dependencies: [
    .package(url: "https://github.com/hainayanda/Clavier.git", .upToNextMajor(from: "2.0.1"))
]
```

Use it in your target as `Clavier`

```swift
 .target(
    name: "MyModule",
    dependencies: ["Clavier"]
)
```

## Author

Nayanda Haberty, hainayanda@outlook.com

## License

Clavier is available under the MIT license. See the LICENSE file for more info.

***

# Basic Usage

Clavier is the Keyboard Layout Guide created to make constraints to the keyboard. It will automatically change on the keyboard changes. It calculates the intersection frame of the Keyboard and the `UIView`. As you can see in the picture below:

![alt text](https://github.com/hainayanda/Clavier/blob/main/KeyboardUp.png)

If the keyboard did not intersect with the view, it will always use the most bottom of the `UIView` with zero height for the regular one, or most bottom of the safe area when using a safe one

![alt text](https://github.com/hainayanda/Clavier/blob/main/KeyboardDown.png)

If the keyboard is hidden, it will always use the most bottom of the UIView with zero height for the regular one, or most bottom of the safe area when using a safe one

## Usage

To use Clavier, just use `clavierLayoutGuide` from any `UIView`, or `safeClavierLayoutGuide` if you prefer the one intersect with the safe area. it is an instance of `ClavierLayoutGuide` class which extend `UILayoutGuide` so it has all its anchors, like `topAnchor`, `leadingAnchor`, etc:

```swift
myView.bottomAnchor.constraints(equalTo: mySuperview.clavierLayoutGuide.topAnchor)
```

or with safe area:

```swift
myView.bottomAnchor.constraints(equalTo: mySuperview.safeClavierLayoutGuide.topAnchor)
```

myView will automatically move according to keyboard layout guide frame changes.

Since its subclass of UILayoutGuide, it has layoutFrame which is the intersection frame with keyboard frame, if you need it:

```swift
let frameIntersectWithKeyboard: CGRect = view.clavierLayoutGuide.layoutFrame
```

or with safe area:

```swift
let frameIntersectWithKeyboard: CGRect = view.safeClavierLayoutGuide.layoutFrame
```

***

## iOS 15

On iOS 15, Clavier will defaultly use `keyboardLayoutGuide` from UIKit. on `safeClavierLayoutGuide`, it will use custom class that utilize `keyboardLayoutGuide` and `safeAreaLayoutGuide`

# Contribute

You know how, just clone and do pull request
