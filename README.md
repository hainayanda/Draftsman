# Draftsman

Draftsman is a DSL framework for Swift focussed on builder pattern
If you are still using version 2.3.x, Separated README is available [here](https://github.com/hainayanda/Draftsman/blob/master/README_2_3.md).
If you are still using Swift 5.1, please use 1.1.x version. Separated README is available [here](https://github.com/hainayanda/Draftsman/blob/master/README_1_1_1.md).

[![codebeat badge](https://codebeat.co/badges/4dab4a09-06c6-40f1-98d4-51e908de36c8)](https://codebeat.co/projects/github-com-hainayanda-draftsman-master)
![build](https://github.com/hainayanda/Draftsman/workflows/build/badge.svg)
![test](https://github.com/hainayanda/Draftsman/workflows/test/badge.svg)
[![SwiftPM Compatible](https://img.shields.io/badge/SwiftPM-Compatible-brightgreen)](https://swift.org/package-manager/)
[![Version](https://img.shields.io/cocoapods/v/Draftsman.svg?style=flat)](https://cocoapods.org/pods/Draftsman)
[![License](https://img.shields.io/cocoapods/l/Draftsman.svg?style=flat)](https://cocoapods.org/pods/Draftsman)
[![Platform](https://img.shields.io/cocoapods/p/Draftsman.svg?style=flat)](https://cocoapods.org/pods/Draftsman)

***

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Swift 5.5 or higher
- iOS 12.0 or higher
- XCode 13 or higher

## Installation

### Cocoapods

Draftsman is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Draftsman', '~> 3.0.0'
```

### Swift Package Manager from XCode

- Add it using XCode menu **File > Swift Package > Add Package Dependency**
- Add **<https://github.com/hainayanda/Draftsman.git>** as Swift Package URL
- Set rules at **version**, with **Up to Next Major** option and put **3.0.0** as its version
- Click next and wait

### Swift Package Manager from Package.swift

Add as your target dependency in **Package.swift**

```swift
dependencies: [
    .package(url: "https://github.com/hainayanda/Draftsman.git", .upToNextMajor(from: "3.0.0"))
]
```

Use it in your target as `Draftsman`

```swift
 .target(
    name: "MyModule",
    dependencies: ["Draftsman"]
)
```

## Author

Nayanda Haberty, hainayanda@outlook.com

## License

Draftsman is available under the MIT license. See the LICENSE file for more info.

***

## Basic Usage

Draftsman is `NSLayoutConstraints` and `UIView` hierarchy builder. Draftsman using new resultBuilder from Swift that makes the Declarative approach possible.

***

### Basic

Creating constraints is very easy. All you need to do is call `drf` to get `LayoutScheme` object:

```swift
myView.drf
    .left.equal(to: otherView.drf.right)
    .right.equal(with: .parent).offset(by: 16)
    .top.lessThan(with: .safeArea).offSet(8)
    .bottom.moreThan(with: .top(of: .keyboard))
    .apply()
```

there are two method to end drafting constraints which can be called from both any `UIView` or `UIViewController`:

- `func apply() -> [NSLayoutConstraint]`
- `func build() -> [NSLayoutConstraint]`

the difference between the two is `apply` will activate the constraints but `build` will only create constraints without activating it. Apply return value is discardable so it's optional for you to use the created `NSLayoutConstraint` or not.

You could always create a `UIViewController` or `UIView` and implements `Drafted` protocol, and call `applyDraft()` whenever you want the viewDraft to be applied:

```swift
import Draftsman

class MyViewController: UIViewController, Drafted {
    
    var models: [MyModel] = []
    
    @LayoutDraft
    var viewDraft: ViewDraft {
        UIStackView(axis: .vertical, spacing: 32).drf
            .center.equal(with: .parent)
            .horizontal.equal(with: .safeArea).offset(by: 16)
            .vertical.moreThan(with: .safeArea).offset(by: 16)
            .insertStacked {
                if models.isEmpty {
                    MyView()
                    MyOtherView()
                    SomeOtherView()
                } else {
                    for model in models {
                        MyModeledView(model)
                    }
                }
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyDraft()
    }
}
```

`ViewDraft` can always be composed to make the code cleaner:

```swift
import Draftsman

class MyViewController: UIViewController, Drafted {
    
    var models: [MyModel] = []
    
    @LayoutDraft
    var viewDraft: ViewDraft {
        UIStackView(axis: .vertical, spacing: 32).drf
            .center.equal(with: .parent)
            .horizontal.equal(with: .safeArea).offset(by: 16)
            .vertical.moreThan(with: .safeArea).offset(by: 16)
            .insertStacked {
                stackDraft
            }
    }

    @LayoutDraft
    var stackDraft: ViewDraft {
        if models.isEmpty {
            emptyStackDraft
        } else {
            modeledStackDraft(for: models)
        }
    }

    @LayoutDraft
    var emptyStackDraft: ViewDraft {
        MyView()
        MyOtherView()
        SomeOtherView()
    }

    @LayoutDraft
    func modeledStackDraft(for models: [MyModel]) -> ViewDraft {
        for model in models {
            MyModeledView(model)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyDraft()
    }
}
```

### View Hierarchy

You can create view hierarchy while creating a constraints by using `draftContent` or `drf.insert` method and `insert` method for subview draft (`draftStackedContent` or `drf.insertStacked` and `insertStacked` if its arranged subviews in `UIStackView`). Don't forget to call `apply()` or `build()`, Both will rearrange view hierarchy but only `apply()` will activate the constraints created.

```swift
view.draftContent {
    UIView().drf
        .center.equal(to: .parent)
        .horizontal.equal(to: .safeArea)
        .vertical.moreThan(with: .safeArea)
        .insert {
            myView.drf
                .edges(.equal, to: .parent)
        }
}.apply()
```

The hierarchy of View is just like how the closure is declared in your code.
The above code, It actually will do the following instruction sequentially:

1. `view` create and insert new `UIView()`
2. new `UIView` then will create constraints
3. new `UIView` then will insert `myView`
4. `myView` then will create constraints
5. all the constraints then will be created and activated

So if the hierarchy is written in pseudo hierarchy style, it should be similar to this:

```
view
|____new UIView
|    |____myView
```

the compatible type to be passed in the closure are:

- any descendant of `UIView`
- any descendant of `UIViewController`

If you pass `UIViewController`, it will be automatically added `UIViewController` view as a child and put the `UIViewController` as a child of its current `UIViewController`.
You could insert components as much as you need, it will fit all the Views just like how you write it.

***

### Basic Positioning

Positioning a View is easy. You just need to declare which anchor that should have relation to others:

```swift
myView.drf
    .top.equal(to: other.drf.top)
    .right.moreThan(to: other.drf.right).offset(by: 8)
    .bottom.lessThan(to: other.drf.bottom).offset(by: 8).priority(.required)
    .left.equal(to: other.leftAnchor)
    .centerX.moreThan(to: other.centerXAnchor).inset(by: 8)
    .centerY.lessThan(to: other.centerYAnchor).inset(by: 8).identifier("centerY")
```

basic position anchors available from Draftsman are:

- **top**
- **left**
- **bottom**
- **right**
- **centerX**
- **centerY**
- **leading**
- **trailing**

All are available for both `UIView` and `UILayoutGuide`
Which can be used to create a constraint using one of this three methods:

- **equal(to:)**
- **moreThan(to:)**
- **lessThan(to:)**

Those methods can accept basic `NSLayoutAnchor` from `UIKit` or using `Anchor` from `Draftsman` as long its in the same Axis.
To add a constant, use one of `offset(by:)` or `inset(by:)` method. offset` are spacing going to outer part of anchor and `inset` are spacing going to inner part of anchors:

![alt text](https://github.com/hainayanda/Draftsman/blob/main/offset_and_inset.png)

For center anchor, offset and inset can be described by this picuture:

![alt text](https://github.com/hainayanda/Draftsman/blob/main/offset_and_inset_center.png)

You can then add priority or/and identifier for the constraints created.

### Basic Dimensioning

Dimensioning a View is easy. You just need to declare which anchor that should have relation to others or constant:

```swift
myView.drf
    .height.equal(to: other.drf.width)
    .width.moreThan(to: other.drf.height).added(by: 8)
    .height.lessThan(to: anyOther.heightAnchor).substracted(by: 8).priority(.required)
    .width.equal(to: anyOther.widthAnchor).multiplied(by: 0.75).identifier("width")
```

basic dimension anchors available from Draftsman are:

- **height**
- **width**

All are available for both `UIView` and `UILayoutGuide`
Which can be used to create a constraint using one of this three methods:

- **equal(to:)**
- **moreThan(to:)**
- **lessThan(to:)**

Those methods can accept basic `NSLayoutDimension` from `UIKit` or using dimension `Anchor` from `Draftsman`.
To add a constant, use one of `added(by:)`, `substracted(by:)` or `multiplied(by: )`  method.
You can then add priority or/and identifier for the constraints created.

Dimensioning can be achieved using constant too:

```swift
myView.drf
    .height.equal(to: 32)
    .width.moreThan(to: 64)
    .width.lessThan(to: 128).priority(.required).identifier("width")
```

Very similar except it accept `CGFloat`

### Combining Two or More Anchors

Creating constraints using multiple anchors is very easy, you can always combined two or more anchors and use them to create multiple constraints at once:

```swift
myView.drf
    .top.left.equal(to: other.drf.top.left)
    .bottom.left.right.moreThan(to: anyOther.drf.top.left.right)
```

It will be the similar like single anchors, but you can only passed `Draftsman Anchor` with the same Axis combination:

- all same anchors combination can be related to each other
- **top.left**, **top.right**, **bottom.left**, **bottom.right** and **centerX.centerY** are all can be related to each other
- **top.leading**, **top.trailing**, **bottom.leading**, **bottom.trailing** and **centerX.centerY** are all can be related to each other
- **top.left.bottom** and **top.right.bottom** both can be related to each other
- **top.left.right** and **bottom.left.right** both can be related to each other
- **top.leading.bottom** and **top.trailing.bottom** both can be related to each other
- **top.leading.trailing** and **bottom.leading.trailing** both can be related to each other

There are some shortcuts for anchor combinations:

- **vertical** is the same as **top.bottom**
- **horizontal** is the same as **left.right**
- **localizedHorizontal** is the same as **leading.trailing**
- **center** is the same as **centerX.centerY**
- **edges** is the same as **top.left.bottom.right**
- **localizedEdges** is the same as **top.leading.bottom.trailing**
- **size** is the same as **width.height**

Example:

```swift
myView.drf
    .vertical.equal(to: other.drf.vertical)
    .bottom.horizontal.moreThan(to: anyOther.drf.top.horizontal)
```

Sizing with **size** or **width.height** can be achieved by using `CGSize` too if needed:

```swift
myView.drf
    .size.equal(to: CGSize(sides: 30))
```

### Anonymous Anchor

Sometimes you don't want or even can't use anchor explicitly. At those case, you can always use `AnonymousLayout`:

```swift
myView.drf
    .top.left.equal(with: .parent)
    .bottom.moreThan(with: .safeArea).offset(by: 16)
    .size.lessThan(with: .previous)
```

available `AnonymousLayout` are:

- **mySelf** which will automatically get the current view
- **parent** which will automatically get the current superview
- **safeArea** which will automatically get the current superview safeAreaLayoutGuide
- **keyboard** which will automatically get the keyboardLayoutGuide (powered by Clavier)
- **keyboardSafeArea** which will automatically get the keyboardLayoutGuide with safeArea (powered by Clavier)
- **previous** which will automatically get the previous view
- **previousSafeArea** which will automatically get the previous safeAreaLayoutGuide

It's basically the same as regular anchor, but it will automatically get the same anchor for anonymous view.
If you want to explicitly get different anchor of anonymous, then you can do something like this:

```swift
myView.drf
    .top.equal(with: .top(of:.parent))
    .bottom.moreThan(with: .bottom(of: .safeArea)).offset(by: 16)
    .width.lessThan(with: .height(of: .previous))
```

available explicit anchor are:

- **left(of: )**
- **leading(of: )**
- **right(of: )**
- **trailing(of: )**
- **centerX(of: )**
- **top(of: )**
- **bottom(of: )**
- **centerY(of: )**
- **topLeft(of: )**
- **topLeading(of: )**
- **topRight(of: )**
- **topTrailing(of: )**
- **bottomLeft(of: )**
- **bottomLeading(of: )**
- **bottomRight(of: )**
- **bottomTrailing(of: )**
- **center(of: )**
- **centerLeft(of: )**
- **centerLeading(of: )**
- **centerRight(of: )**
- **centerTrailing(of: )**
- **centerTop(of: )**
- **centerBottom(of: )**

## Draftsman Drafted

Draftsman `Drafted` protocol is the protocol that makes any `UIView` or `UIViewController` can have its predefined view draft and applied it using `applyDraft` method. The protocol is declared like this:

```swift
public protocol Drafted: AnyObject {
    var draftedIdentifier: ObjectIdentifier { get }
    var appliedConstraints: [NSLayoutConstraint] { get }
    var viewDraftApplied: Bool { get }
    @LayoutDraft
    var viewDraft: ViewDraft { get }
    @discardableResult
    func applyDraft() -> [NSLayoutConstraint]
}
```

The only thing you need to implement is the `viewDraft` getter since everything will be implemented in extensions:

```swift
import Draftsman

class MyViewController: UIViewController, Drafted {
    
    @LayoutDraft
    var viewDraft: ViewDraft {
        UIStackView(axis: .vertical, spacing: 32).drf
            .center.equal(with: .parent)
            .horizontal.equal(with: .safeArea).offset(by: 16)
            .vertical.moreThan(with: .safeArea).offset(by: 16)
            .insertStacked {
                MyView()
                MyOtherView()
                SomeOtherView()
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyDraft()
    }
}
```

Every time you call `applyDraft`, it will always try to recreate the view to be same like what declared in `viewDraft`.

There are some typealias with Drafted that you can use:

- **UIDraftedController** which is `UIViewController & Drafted`
- **UIDraftedView** which is `UIView & Drafted`

### Drafted Cell

Drafted Cell is Drafted built specifically for cell which declared like this:

```swift
public protocol DraftedCell: Drafted {
    @LayoutDraft
    var contentViewDraft: ViewDraft { get }
}
```

The only thing you need to implement is the `contentViewDraft` getter since everything will be implemented in extensions. It will skip `contentView` and straight into its content:

```swift
class TableCell: UITableView, DraftedCell {
    
    @LayoutDraft
    var contentViewDraft: ViewDraft {
        UIImageView(image: UIImage(named: "icon_test")).drf.builder
            .contentMode(.scaleAspectFit).drf
            .left.vertical.equal(with: .parent).offset(by: 12)
            .size.equal(with: CGSize(sides: 56))
        UIStackView(axis: .vertical, distribution: .fillEqually, spacing: 4).drf
            .right.vertical.equal(with: .parent).offset(by: 12)
            .left.equal(with: .right(of: .previous)).offset(by: 8)
            .insertStacked {
                UILabel(text: "title text")
                UILabel(text: "subtitle text")
            }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        applyDraft()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyDraft()
    }
}
```

Every time you call `applyDraft`, it will always try to recreate the view to be same like what declared in `viewDraft`.

There are some typealias with Drafted that you can use:

- **UITableDraftedCell** which is `UITableViewCell & DraftedCell`
- **UICollectionDraftedCell** which is `UICollectionViewCell & DraftedCell`

### Drafted Stack

`DraftedStack` is `Drafted` built specifically for cell which declared like this:

```swift
public protocol DraftedStack: Drafted {
    @LayoutDraft
    var stackViewDraft: ViewDraft { get }
}
```

The only thing you need to implement is the `stackViewDraft` getter since everything will be implemented in extensions. It will automatically treat draft as `arrangeSubviews` of the stack:

```swift
class MyStack: UIStackView, DraftedStack {
    
    @LayoutDraft
    var stackViewDraft: ViewDraft {
        UIImageView(image: UIImage(named: "icon_test")).drf.builder
            .contentMode(.scaleAspectFit).drf
            .size.equal(with: CGSize(sides: 56))
        UILabel(text: "title text")
        UILabel(text: "subtitle text")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyDraft()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyDraft()
    }
}
```

Every time you call `applyDraft`, it will always try to recreate the view to be same like what declared in `viewDraft`.

You can use `UIDraftedStack` since its a typealias of `UIStackView & DraftedStack`

***

## Contribute

You know how, just clone and do pull request
