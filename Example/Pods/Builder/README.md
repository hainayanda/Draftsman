<p align="center">
  <img width="512" height="192" src="builder.png"/>
</p>

# Builder

Builder is Swift builder pattern library that utilize dynamicCallable and dynamicMemberLookup as its core.

[![codebeat badge](https://codebeat.co/badges/2aadfe57-5ebc-4c9d-a76a-ac59ebb94b8d)](https://codebeat.co/projects/github-com-hainayanda-builder-main)
![build](https://github.com/hainayanda/Builder/workflows/build/badge.svg)
![test](https://github.com/hainayanda/Builder/workflows/test/badge.svg)
[![SwiftPM Compatible](https://img.shields.io/badge/SwiftPM-Compatible-brightgreen)](https://swift.org/package-manager/)
[![Version](https://img.shields.io/cocoapods/v/Builder.svg?style=flat)](https://cocoapods.org/pods/Builder)
[![License](https://img.shields.io/cocoapods/l/Builder.svg?style=flat)](https://cocoapods.org/pods/Builder)
[![Platform](https://img.shields.io/cocoapods/p/Builder.svg?style=flat)](https://cocoapods.org/pods/Builder)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Swift 5.1 or higher (or 5.3 when using Swift Package Manager)
- iOS 10 or higher

### Only Swift Package Manager

- macOS 10.10 or higher
- tvOS 10 or higher

## Installation

### Cocoapods

Builder is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'Builder', '~> 1.1.0'
```

### Swift Package Manager from XCode

- Add it using XCode menu **File > Swift Package > Add Package Dependency**
- Add **https://github.com/hainayanda/Builder.git** as Swift Package URL
- Set rules at **version**, with **Up to Next Major** option and put **1.1.0** as its version
- Click next and wait

### Swift Package Manager from Package.swift

Add as your target dependency in **Package.swift**

```swift
dependencies: [
  .package(url: "https://github.com/hainayanda/Builder.git", .upToNextMajor(from: "1.1.0"))
]
```

Use it in your target as `Builder`

```swift
 .target(
  name: "MyModule",
  dependencies: ["Builder"]
)
```

## Author

Nayanda Haberty, hainayanda@outlook.com

## License

Impose is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

## Basic Usage

Using Builder is simple. You just need to pass the object you want to build and assign its writable property as its a function. Example:

If you have a class like this:

```swift
class MyObject {
    var string: String?
    var int: Int?
    var double: Double?
    
    ...
    ...
}
```

you can build it like this:

```swift
let myObject: MyObject = builder(MyObject())
    .string("some string")
    .int(10)
    .double(1.2)
    .build()
```

Its even can assign property of property as deep as you need, as long the property is mutable:

```swift
let myObject: MyObject = builder(MyObject())
    .string("some string")
    .int(10)
    .double(1.2)
    .subObject.string("some string")
    .subObject.int(10)
    .subObject.double(1.2)
    .build()
```

## Buildable

There's a protocol named Buildable that allowed your object to have a `bld` computed property that will return a Builder object for you to use:

```swift
let myObject: MyObject = MyBuildable().bld
    .string("some string")
    .int(10)
    .double(1.2)
    .subObject.string("some string")
    .subObject.int(10)
    .subObject.double(1.2)
    .build()
```

## Initializable

There's a protocol named Initializable which declared like this:

```swift
public protocol Initializable {
    init()
}
```

its just to ensure you can call builder global function by only passing its `Type`:

```swift
let view: MyObjectImplementInitializable = builder(MyObjectImplementInitializable.self)
    .string("some string")
    .int(10)
    .double(1.2)
    .build()
```

Initializable is implementing Buildable by default

## Error Handling

Sometimes you can mistakenly  try to assigning property that immutable. By default you can always see the debugPrint output like this:

```
Failed to assign property keypath of MyType with property type MyPropertyType because its not writable
```

But it can be forgotton and became a bug in the future. So you can always force it to throw fatalError if something like this is happes by assigning `errorHandling` on `BuilderConfig`:

```swift
BuilderConfig.errorHandling = .fatalErrorOnAssigningLet
```

it will create a fatal error when immutable property is assigned, so you can always fix it before it became a problem in the future. 
You can always handling it manually by assigning closure:

```swift
BuilderConfig.errorHandling = .manual { message in
    debugPrint("FIX THIS: \(message)")
}
```

## Contribute

You know how, just clone and do pull request
