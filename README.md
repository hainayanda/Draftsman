# Draftsman

Draftsman is a DSL framework for Swift focussed on builder pattern

![build](https://github.com/nayanda1/Draftsman/workflows/build/badge.svg)
![test](https://github.com/nayanda1/Draftsman/workflows/test/badge.svg)
[![Version](https://img.shields.io/cocoapods/v/Draftsman.svg?style=flat)](https://cocoapods.org/pods/Draftsman)
[![License](https://img.shields.io/cocoapods/l/Draftsman.svg?style=flat)](https://cocoapods.org/pods/Draftsman)
[![Platform](https://img.shields.io/cocoapods/p/Draftsman.svg?style=flat)](https://cocoapods.org/pods/Draftsman)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Swift 5.1 or higher
- iOS 10.0 or higher

## Installation

### Cocoapods

Draftsman is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Draftsman'
```

### Swift Package Manager

First, create a Package.swift file and add this github url. It should look like:

```swift
dependencies: [
    .package(url: "https://github.com/nayanda1/Draftsman.git", from: "1.0.0")
]
```

Then run swift build to build the dependency before you use it

## Author

Nayanda Haberty, nayanda1@outlook.com

## License

Draftsman is available under the MIT license. See the LICENSE file for more info.

***

# Basic Usage

Draftsman is `NSLayoutConstraints` and `UIView` hierarchy builder. The syntax is designed so it could be read just like english language.

***

## Basic
there are two method to start planning which can be called from both any `UIView` or `UIViewController`:
* `func plan(withDelegate delegate: PlanDelegate? = nil, _ options: PlanningOption = .append, _ layouter: (LayoutPlaner<Self>) -> Void)`
* `func planContent(withDelegate delegate: PlanDelegate? = nil, _ options: PlanningOption = .append, _ layouter: (LayoutPlan<Self>) -> Void)`

as you can see in the name, `plan` is used to create plan for the `UIView` or view in `UIViewController` dimension and position that called those method:

```swift
someView.plan { somePlan in
    somePlan.edges(.equal, to: .parent)
        .planContent { someViewContent in
            someViewContent.fit(otherView)
                .at(.topLeft, of: .parent)
        }
}
```

on the other hand, `planContent` could be used if you want to bypass those plan and just want to create plan for those content instead:

```swift
someView.planContent { someContentPlan in
    someContentPlan.fit(otherView)
        .at(.topLeft, of: .parent)
}
```

### PlanDelegate
You could pass `PlanDelegate` to delegate some problem which could be occurs when you are planning. The delegate is declared like this: 

```swift
public protocol PlanDelegate: class {
    func planer(viewHaveNoSuperview view: UIView) -> UIView?
    func planer(neededViewControllerFor viewController: UIViewController) -> UIViewController?
    func planer(_ view: UIView, errorWhenPlanning error: DraftsmanError)
}
```

* `planer(viewHaveNoSuperview:)` will be called if planner need superview but cannot find any. You could provide one, or just return nil to ignore those plan and produce error which can be catch at this delegate. The default is nil.
* `planer(neededViewControllerFor:)` will be called if planner need parent `UIViewController` but cannot find any. You could provide one, or just return nil to ignore those plan and produce error which can be catch at this delegate. The default is get current view UIViewController if have any.
* `planer(_:, errorWhenPlanning:)` will be called if any error occurs when planning.

### PlanningOption
PlanningOption is enumeration which will determined how the plan will be implemented:
* **append** will be ignore current active `NSLayoutConstraints` and append any `NSLayoutConstraints` planned.
* **renew** will be update same current active `NSLayoutConstraints` which created by Draftsman if found and append the new one.
* **startFresh** will be remove all current active `NSLayoutConstraints` which created by Draftsman and append any NSLayoutConstraints planned.
* **startClean** will be remove all current active `NSLayoutConstraints` and append any `NSLayoutConstraints` planned.

if we sort all the option from the fastest to the slowest it could be like this:
* append
* startClean
* startFresh
* renew

but even if the `append` is the fastest, you better just use this if you want to plan once, otherwise you will have multiple duplicated constraints.

***

## View Hierarchy
The hierarchy of View is just like how the closure declared in your code:
```swift
parentView.planContent { parentPlan in
    parentPlan.fit(someView)
        .planContent { somePlan in
            somePlan.fit(someChildView)
        }
    parentPlan.fit(otherView)
}
```
At the above code, it using `planContent` method which will bypass `parentView` plan into its content plan. It actually will do the following instruction sequentially:
1. `parentView` insert `someView`
2. `someView` insert `someChildView`
3. `parentView` insert `otherView`

So if the hierarchy is written in pseudo hierarchy style, it should be similar like this: 
```
parentView
|____someView
|    |____someChildView
|____otherView
```

where `someView` and `otherView` are both inside `parentView`, and `someChildView` is inside `someView`
the compatible type to be passed in fit method are:
* any descendant of `UIView`
* any descendant of `UIViewController`

If you pass `UIViewController`, it will be automatically added `UIViewController` view as child and put the `UIViewController` as child of its current `UIViewController`.
You could `planContent` as much as you need, it will fit all the View just like how you write it.

***

## View Position

### Basic Positioning
Positioning a View is easy. You just need to declare which anchor should have relation to others:

```swift
myView.plan {
    $0.top(.equal, to: other.topAnchor)
        .right(.equalTo(8), to: other.rightAnchor)
        .bottom(.moreThan, to: other.bottomAnchor)
        .left(.moreThanTo(8), to: other.leftAnchor)
        .centerX(.lessThan, to: other.centerXAnchor)
        .centerY(.lessThanTo(8), to: other.centerYAnchor)
}
```

the anatomy of position plan is:

> _func **anchor_name**(__ _relation: **LayoutRelation<CGFloat>**, to anchor: **other_anchor**, priority: UILayoutPriority? = nil) -> Planner_

which `anchor_name` could be:
* **top**
* **bottom**
* **left**
* **right**
* **centerX**
* **centerY**

and `LayoutRelation` is enumeration with generic param which in this case is `CGFloat`:
* **moreThanTo(CGFloat)**
* **lessThanTo(CGFloat)**
* **equalTo(CGFloat)**
* **moreThan**
* **lessThan**
* **equal**

all the parameter is `CGFloat` that will be translated as space towards the anchor, as when the anchor is `left`, then the param will be translated as space to the left, and if the anchor is `right`, then the param will be translated as space to the right.

and `other_anchor` common types are:
* `NSLayoutYAxisAnchor`
* `NSLayoutXAxisAnchor`
* `AnonymousRelation`

the `AnonymousRelation` is enumeration which contains:
* **parent** which are where the same anchor of parent `UIView`
* **safeArea** which are where the same anchor of parent safe area `UIView`
* **myself** which are where the same anchor of current `UIView`
* **mySafeArea** which are where the same anchor of current safe area `UIView`
* **previous** which are where the same anchor of previous planned `UIView`
* **previousSafeArea** which are where the same anchor of previous planned `UIView`

You could also passing `UILayoutPriority` if you need. If you ignore it, it will be lesser than previous priority started by mandatory.

So lets say you want your view to fill the bottom of its superview, you could just use `AnonymousRelation` instead of declare explicitly:

```swift
myView.plan {
    $0.right(.equal, to: .parent)
        .bottom(.equal, to: .parent)
        .left(.equal, to: .parent)
}
```

### Related Anchor
If your `AnonymousRelation` anchor is different than your anchor, you could use `RelatedAnchor<NSLayoutXAxisAnchor>`. Its actually the anchor extractor from `AnonymousRelation`:

```swift
myView.plan {
    $0.top(.equalTo(8), to: Anchor(of: .previous).bottomAnchor)
        .right(.equal(8), to: Anchor(of: .previous).leftAnchor)
        .bottom(.equal, to: .safeArea)
        .left(.equal(8), to: .safeArea)
}
```

so instead of call the previous anchor explicitly, you call them like that.

### Positioning Shortcut
There are some shortcut for Positioning. For center anchor:
* `func center(_ relation: LayoutRelation<CoordinateOffsets>, to view: UIView, priority: UILayoutPriority? = nil) -> Self`
* `func center(_ relation: LayoutRelation<CoordinateOffsets>, to anchor: AnonymousRelation, priority: UILayoutPriority? = nil) -> Self`

the `CoordinateOffsets` is struct which contains `xOffset` and `yOffset`. The center is shortcut to `centerX` and `centerY`, it will automatically assign `NSLayoutConstraints` relation to same center anchor to the `UIView` or `AnonymousRelation`. Example:

```swift
myView.plan {
    $0.center(.equalTo(.init(xOffset: 8, yOffset: 8)), to: .parent)
}
```

For vertical and horizontal position:
* `func vertical(_ relation: LayoutRelation<InsetsConvertible>, to anchor: AnonymousRelation, priority: UILayoutPriority? = nil) -> Self`
* `func vertical(_ relation: LayoutRelation<InsetsConvertible>, to view: UIView, priority: UILayoutPriority? = nil) -> Self`
* `func horizontal(_ relation: LayoutRelation<InsetsConvertible>, to view: UIView, priority: UILayoutPriority? = nil) -> Self`
* `func horizontal(_ relation: LayoutRelation<InsetsConvertible>, to anchor: AnonymousRelation, priority: UILayoutPriority? = nil) -> Self`

the `InsetsConvertible` can be `UIEdgeInsets`, `UIVerticalInsets`, `UIHorizontalInsets`, `CGFloat`, `Int` or `Double`. Single types like `CGFloat`, `Int` or `Double` will be treated as `UIEdgeInsets` with same insets for top, left, right and bottom. The vertical will be assign top and bottom anchor to `UIView` or `AnonymousRelation` same anchors. Example:

```swift
myView.plan {
    $0.vertical(equalTo(16), to: .parent)
}
```

For all edges:
* `func edges(_ relation: LayoutRelation<InsetsConvertible>, to anchor: AnonymousRelation, priority: UILayoutPriority? = nil) -> Self`

It will automatically assign `top`, `left`, `bottom` and `right` anchor to `UIView` or `AnonymousRelation` same anchors. Example:

```swift
myView.plan {
    $0.edges(.equalTo(16), to: .parent)
}
```

For any specific position:
* `func at(_ positions: [LayoutEdge], _ relation: LayoutRelation<InsetsConvertible>, to anchor: AnonymousRelation, priority: UILayoutPriority? = nil) -> Self`
* `func at(_ viewRelation: RelatedPosition, _ relation: LayoutRelation<InsetsConvertible>, priority: UILayoutPriority? = nil) -> Self`
* `func inBetween(of view: UIView, and otherView: UIView, _ position: MiddlePosition, priority: UILayoutPriority? = nil) -> Self`

Array of `LayoutEdge` have static var extensions which are:
* **topLeft** which is `[.top, .left]`
* **topRight** which is `[.top, .right]`
* **bottomLeft** which is `[.bottom, .left]`
* **bottomRight** which is `[.bottom, .right]`
* **fullLeft** which is `[.left, .top, .bottom]`
* **fullRight** which is `[.right, .top, .bottom]`
* **fullBottom** which is `[.bottom, .left, .right]`
* **fullTop** which is `[.top, .left, .right]`
* **edge** which is `[.top, .bottom, .left, .right]`

`RelatedPosition` is enumeration which are:
* **topOf(UIView)** which will mark bottom to be at top of other `UIView`
* **bottomOf(UIView)** which will mark top to be at bottom of other `UIView`
* **leftOf(UIView)** which will mark right to be at left of other `UIView`
* **rightOf(UIView)** which will mark left to be at right of other `UIView`
* **topOfAndParallelWith(UIView)** which same as `topOf`, but with same left and right as other `UIView`
* **bottomOfAndParallelWith(UIView)** which same as `bottomOf`, but with same left and right as other `UIView`
* **leftOfAndParallelWith(UIView)** which same as `leftOf`, but with same top and bottom as other `UIView`
* **rightOfAndParallelWith(UIView)** which same as `rightOf`, but with same top and bottom as other `UIView`

`MiddlePosition` is enumeration with `LayoutRelation<InsetsConvertible>` parameter:
* **horizontally(LayoutRelation<InsetsConvertible>)**
* **vertically(LayoutRelation<InsetsConvertible>)**

Example:

```swift
myView.plan {
    $0.at(.topLeft, .equal, to: .parent)
        .at(.rightOf(otherView), .equalTo(8))
}
otherView.plan {
    $0.inBetween(of: myView, and: anyView, .horizontally(.equalTo(8)))
}
```

***

## View Dimension

### Basic Dimensioning
Create dimension constraints for a View is easy. You just need to declare which anchor should have relation to others:

```swift
myView.plan {
    $0.height(.equalTo(otherView.heightAnchor), multiplyBy: 2)
        .width(.equalTo(.parent), .width)
        .height(.lessThanTo(100))
        .width(.moreThanTo(100))
}
```

The anatomy of dimension plan is:

> _func **dimension_name**(__ _relation: **InterRelation of AnonymousRelation**, __ _dimension: **LayoutDimension**, multiplyBy multiplier: CGFloat, constant: CGFloat, priority: UILayoutPriority? = nil) -> Planner_

this one could be used to plan any dimension constraints with any `AnonymousRelation` dimension anchor. The other dimension plan is:

> _func **dimension_name**(__ _relation: **InterRelation of NSLayoutDimension**, multiplyBy multiplier: CGFloat, constant: CGFloat, priority: UILayoutPriority? = nil) -> Planner_

this one could be used to plan any dimension constraints with any `NSLayoutDimension` anchor. The last dimension plan is:

> _func **dimension_name**(__ _relation: **InterRelation of CGFloat**, priority: UILayoutPriority? = nil) -> Planner_

this one could be used to plan any dimension constraints against any constant.

The `InterRelation` is the enumeration with generic parameter:
* **moreThanTo(Related)**
* **lessThanTo(Related)**
* **equalTo(Related)**

and `LayoutDimension` is enumeration of dimension:
* **height**
* **width**

multiplier is the value which will be multiplied dimension anchor. The constant will be added to the dimension.

### Dimensioning Shortcut
There are some shortcut for Dimensioning which are:
* `func size(_ relation: InterRelation<CGSize>, priority: UILayoutPriority? = nil) -> Self`
* `func size(_ relation: InterRelation<UIView>, multiplyBy multiplier: CGFloat = 1, constant: CGFloat = 0, priority: UILayoutPriority? = nil) -> Self`

both will automatically assign both width and height constraints towards CGSize constant or UIView size. Example:

```swift
myView.plan {
    $0.size(.equalTo(otherView), multiplyBy: 2)
}
otherView.plan {
    $0.size(.equalTo(.init(width: 24, height: 24)))
}
```

***

## Contribute

You know how, just clone and do pull request
