# Draftsman

Draftsman is a DSL framework for Swift focussed on builder pattern

[![codebeat badge](https://codebeat.co/badges/e0358dc0-7445-47a9-8f81-5c57a11fa9e8)](https://codebeat.co/projects/github-com-hainayanda-draftsman-master)
![build](https://github.com/hainayanda/Draftsman/workflows/build/badge.svg)
![test](https://github.com/hainayanda/Draftsman/workflows/test/badge.svg)
[![SwiftPM Compatible](https://img.shields.io/badge/SwiftPM-Compatible-brightgreen)](https://swift.org/package-manager/)
[![Version](https://img.shields.io/cocoapods/v/Draftsman.svg?style=flat)](https://cocoapods.org/pods/Draftsman)
[![License](https://img.shields.io/cocoapods/l/Draftsman.svg?style=flat)](https://cocoapods.org/pods/Draftsman)
[![Platform](https://img.shields.io/cocoapods/p/Draftsman.svg?style=flat)](https://cocoapods.org/pods/Draftsman)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Swift 5.3 or higher (Swift 5.1 for version 1.1.1 or lower)
- iOS 10.0 or higher
- XCode 12.5 or higher (XCode 11 for version 1.1.1 or lower)

## Installation

### Cocoapods

Draftsman is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Draftsman', '~> 2.0.5'
```

or for Swift 5.1 and XCode 11

```ruby
pod 'Draftsman', '~> 1.1.1'
```

### Swift Package Manager from XCode

- Add it using XCode menu **File > Swift Package > Add Package Dependency**
- Add **<https://github.com/hainayanda/Draftsman.git>** as Swift Package URL
- Set rules at **version**, with **Up to Next Major** option and put **2.0.3** or **1.1.1** for Swift 5.1 and XCode 11 as its version
- Click next and wait

### Swift Package Manager from Package.swift

Add as your target dependency in **Package.swift**

```swift
dependencies: [
    .package(url: "https://github.com/hainayanda/Draftsman.git", .upToNextMajor(from: "2.0.5"))
]
```

or for Swift 5.1 and XCode 11

```swift
dependencies: [
    .package(url: "https://github.com/hainayanda/Draftsman.git", .upToNextMajor(from: "1.1.1"))
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

Draftsman is `NSLayoutConstraints` and `UIView` hierarchy builder. Draftsman using new resultBuilder from Swift that makes the Declarative approach possible. For **1.1.1** version, please lookup this [readme](https://github.com/hainayanda/Draftsman/blob/master/README_1_1_1.md) instead

***

### Basic

Creating constraints is very easy. All you need to do is call plan to get `LayoutScheme`:

```swift
myView.plan
    .left(.equal, to: otherView.rightAnchor)
    .right(.equalTo(16), to: .parent)
    .top(.lessThanTo(8), to: .safeArea)
    .bottom(.moreThan, to: .top(of: .keyboard))
    .apply()
```

there are two method to end planning constraints which can be called from both any `UIView` or `UIViewController`:

- `func apply() -> [NSLayoutConstraint]`
- `func build() -> [NSLayoutConstraint]`

the difference between the two is `apply` will activate the constraints but `build` will only create constraints without activating it. Apply return value is discardable so it's optional for you to use the created `NSLayoutConstraint` or not.

You could always create a `UIViewController` or `UIView` and implements `Planned` protocol, and call `applyPlan()` whenever you want the plan to be applied:

```swift
import Draftsman

class MyViewController: UIViewController, Planned {
    
    var models: [MyModel] = []
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        UIStackView(axis: .vertical, spacing: 32).plan
            .center(.equal, to: .parent)
            .horizontal(.equalTo(16), to: .safeArea)
            .vertical(.moreThanTo(16), to: .safeArea)
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
        applyPlan()
    }
}
```

`ViewPlan` can always be composed to make the code cleaner:

```swift
import Draftsman

class MyViewController: UIViewController, Planned {
    
    var models: [MyModel] = []
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        UIStackView(axis: .vertical, spacing: 32).plan
            .center(.equal, to: .parent)
            .horizontal(.equalTo(16), to: .safeArea)
            .vertical(.moreThanTo(16), to: .safeArea)
            .insertStacked {
                stackPlan
            }
    }

    @LayoutPlan
    var stackPlan: ViewPlan {
        if models.isEmpty {
            emptyStackPlan
        } else {
            modeledStackPlan(for: models)
        }
    }

    @LayoutPlan
    var emptyStackPlan: ViewPlan {
        MyView()
        MyOtherView()
        SomeOtherView()
    }

    @LayoutPlan
    func modeledStackPlan(for models: [MyModel]) -> ViewPlan {
        for model in models {
            MyModeledView(model)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyPlan()
    }
}
```

### View Hierarchy

You can create view hierarchy while creating a constraints by using `planContent` method and `insert` method for subview plan (`planStackedContent` and `insertStacked` if its arranged subviews in `UIStackView`). **You should not calls apply or build when using this method**, since it will always automatically populate all constraints inside to activate as bulk:

```swift
view.planContent {
    UIView().plan
        .center(.equal, to: .parent)
        .horizontal(.equal, to: .safeArea)
        .vertical(.moreThan, to: .safeArea)
        .insert {
            myView.plan
                .edges(.equal, to: .parent)
        }
}
```

The hierarchy of View is just like how the closure is declared in your code.
The above code, It actually will do the following instruction sequentially:

1. `view` create and insert new `UIView()`
2. new `UIView` then will create constraints
3. new `UIView` then will insert `myView`
4. `myView` then will create constraints
5. all the constraints then will be activated

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

### PlanDelegate

You could pass `PlanDelegate` to delegate some problem which could be occurs when you are planning. The delegate is declared like this:

```swift
public protocol PlanDelegate: class {
    func planer(viewHaveNoSuperview view: UIView) -> UIView?
    func planer(neededViewControllerFor viewController: UIViewController) -> UIViewController?
    func planer(_ view: UIView, errorWhenPlanning error: DraftsmanError)
}
```

- `planer(viewHaveNoSuperview:)` will be called if the planner needs superview but cannot find any. You could provide one, or just return nil to ignore those plan and produce error which can be caught at this delegate. The default is nil.
- `planer(neededViewControllerFor:)` will be called if the planner needs parent `UIViewController` but cannot find any. You could provide one, or just return nil to ignore those plan and produce error which can be caught at this delegate. The default is to get the current view UIViewController if have any.
- `planer(_:, errorWhenPlanning:)` will be called if any error occurs when planning.

```swift
view.planContent(withDelegate: myDelegate) {
    UIView().plan
        .center(.equal, to: .parent)
        .horizontal(.equal, to: .safeArea)
        .vertical(.moreThan, to: .safeArea)
        .insert {
            myView.plan
                .edges(.equal, to: .parent)
        }
}
```

***

### Basic Positioning

Positioning a View is easy. You just need to declare which anchor should have relation to others:

```swift
myView.plan
    .top(.equal, to: other.topAnchor)
    .right(.equalTo(8), to: other.rightAnchor)
    .bottom(.moreThan, to: other.bottomAnchor)
    .left(.moreThanTo(8), to: other.leftAnchor)
    .centerX(.lessThan, to: other.centerXAnchor)
    .centerY(.lessThanTo(8), to: other.centerYAnchor)
```

the anatomy of position plan is:

> _func **anchor_name**(__ _relation:**LayoutRelation<CGFloat>**, to anchor:**other_anchor**, priority: UILayoutPriority? = nil) -> Self_

which `anchor_name` could be:

- **top**
- **bottom**
- **left**
- **right**
- **centerX**
- **centerY**

and `LayoutRelation` is enumeration with generic param which in this case is `CGFloat`:

- **moreThanTo(CGFloat)**
- **lessThanTo(CGFloat)**
- **equalTo(CGFloat)**
- **moreThan**
- **lessThan**
- **equal**

all the parameter is `CGFloat` that will be translated as space towards the anchor, as when the anchor is `left`, then the param will be translated as space to the left, and if the anchor is `right`, then the param will be translated as space to the right.

and `other_anchor` common types are:

- `NSLayoutYAxisAnchor`
- `NSLayoutXAxisAnchor`
- `AnonymousRelation`

the `AnonymousRelation` is an enumeration that contains:

- **parent** which are where the same anchor of parent `UIView`
- **safeArea** which are where the same anchor of parent safe area `UIView`
- **myself** which are where the same anchor of current `UIView`
- **mySafeArea** which are where the same anchor of current safe area `UIView`
- **previous** which are where the same anchor of previous planned `UIView`
- **previousSafeArea** which are where the same anchor of previous planned `UIView`
- **keyboard** which are the same anchor of parent keyboard guide of `UIView`
- **keyboardSafeArea** which are the same anchor of parent keyboard guide of `UIView` intersect with safe area

the `keyboard` and `keyboardSafeArea` are all powered by [Clavier](https://github.com/hainayanda/Clavier)

You could also pass `UILayoutPriority` if you need. If you ignore it, it will be lesser than the previous priority started by mandatory.

So lets say you want your view to fill the bottom of its superview, you could just use `AnonymousRelation` instead of declare explicitly:

```swift
myView.plan
    .right(.equal, to: .parent)
    .bottom(.equal, to: .parent)
    .left(.equal, to: .parent)
```

### Related Anchor

If your `AnonymousRelation` anchor is different than your anchor, you could use `RelatedAnchor<NSLayoutXAxisAnchor>`. It's actually the anchor extractor from `AnonymousRelation`.

So lets say you want to make your view always on top of keyboard, just do this:

```swift
myView.plan
    .bottom(.equal, to: .top(of: .keyboard))
    .right(.equalTo(8), to: .safeArea)
    .left(.equalTo(8), to: .safeArea)
```

so instead of calling the previous anchor explicitly, you call them like that.

### Positioning Shortcut

There are some shortcuts for Positioning. For center anchor:

- `func center(_ relation: LayoutRelation<CoordinateOffsets>, to view: UIView, priority: UILayoutPriority? = nil) -> Self`
- `func center(_ relation: LayoutRelation<CoordinateOffsets>, to anchor: AnonymousRelation, priority: UILayoutPriority? = nil) -> Self`

the `CoordinateOffsets` is struct which contains `xOffset` and `yOffset`. The center is shortcut to `centerX` and `centerY`, it will automatically assign `NSLayoutConstraints` relation to same center anchor to the `UIView` or `AnonymousRelation`. Example:

```swift
myView.plan
    .center(.equalTo(.init(xOffset: 8, yOffset: 8)), to: .parent)
```

For vertical and horizontal position:

- `func vertical(_ relation: LayoutRelation<InsetsConvertible>, to anchor: AnonymousRelation, priority: UILayoutPriority? = nil) -> Self`
- `func vertical(_ relation: LayoutRelation<InsetsConvertible>, to view: UIView, priority: UILayoutPriority? = nil) -> Self`
- `func horizontal(_ relation: LayoutRelation<InsetsConvertible>, to view: UIView, priority: UILayoutPriority? = nil) -> Self`
- `func horizontal(_ relation: LayoutRelation<InsetsConvertible>, to anchor: AnonymousRelation, priority: UILayoutPriority? = nil) -> Self`

the `InsetsConvertible` can be `UIEdgeInsets`, `UIVerticalInsets`, `UIHorizontalInsets`, `CGFloat`, `Int` or `Double`. Single types like `CGFloat`, `Int` or `Double` will be treated as `UIEdgeInsets` with same insets for top, left, right and bottom. The vertical will be assign top and bottom anchor to `UIView` or `AnonymousRelation` same anchors. Example:

```swift
myView.plan 
    .vertical(equalTo(16), to: .parent)
```

For all edges:

- `func edges(_ relation: LayoutRelation<InsetsConvertible>, to anchor: AnonymousRelation, priority: UILayoutPriority? = nil) -> Self`

It will automatically assign `top`, `left`, `bottom` and `right` anchor to `UIView` or `AnonymousRelation` same anchors. Example:

```swift
myView.plan 
    .edges(.equalTo(16), to: .parent)
```

For any specific position:

- `func at(_ positions: [LayoutEdge], _ relation: LayoutRelation<InsetsConvertible>, to anchor: AnonymousRelation, priority: UILayoutPriority? = nil) -> Self`
- `func at(_ viewRelation: RelatedPosition, _ relation: LayoutRelation<InsetsConvertible>, priority: UILayoutPriority? = nil) -> Self`
- `func inBetween(of view: UIView, and otherView: UIView, _ position: MiddlePosition, priority: UILayoutPriority? = nil) -> Self`

Array of `LayoutEdge` have static var extensions which are:

- **topLeft** which is `[.top, .left]`
- **topRight** which is `[.top, .right]`
- **bottomLeft** which is `[.bottom, .left]`
- **bottomRight** which is `[.bottom, .right]`
- **fullLeft** which is `[.left, .top, .bottom]`
- **fullRight** which is `[.right, .top, .bottom]`
- **fullBottom** which is `[.bottom, .left, .right]`
- **fullTop** which is `[.top, .left, .right]`
- **edge** which is `[.top, .bottom, .left, .right]`

`RelatedPosition` is enumeration which are:

- **topOf(UIView)** which will mark bottom to be at top of other `UIView`
- **bottomOf(UIView)** which will mark top to be at bottom of other `UIView`
- **leftOf(UIView)** which will mark right to be at left of other `UIView`
- **rightOf(UIView)** which will mark left to be at right of other `UIView`
- **topOfAndParallelWith(UIView)** which same as `topOf`, but with same left and right as other `UIView`
- **bottomOfAndParallelWith(UIView)** which same as `bottomOf`, but with same left and right as other `UIView`
- **leftOfAndParallelWith(UIView)** which same as `leftOf`, but with same top and bottom as other `UIView`
- **rightOfAndParallelWith(UIView)** which same as `rightOf`, but with same top and bottom as other `UIView`

`MiddlePosition` is enumeration with `LayoutRelation<InsetsConvertible>` parameter:

- **horizontally(LayoutRelation<InsetsConvertible>)**
- **vertically(LayoutRelation<InsetsConvertible>)**

Example:

```swift
myView.plan 
    .at(.topLeft, .equal, to: .parent)
    .at(.rightOf(otherView), .equalTo(8))
otherView.plan
    .inBetween(of: myView, and: anyView, .horizontally(.equalTo(8)))
```

***

### Basic Dimensioning

Create dimension constraints for a View is easy. You just need to declare which anchor should have relation to others:

```swift
myView.plan
    .height(.equalTo(otherView.heightAnchor), multiplyBy: 2)
    .width(.equalTo(.parent), .width)
    .height(.lessThanTo(100))
    .width(.moreThanTo(100))
```

The anatomy of dimension plan is:

> _func **dimension_name**(__ _relation:**InterRelation of AnonymousRelation**, __ _dimension:**LayoutDimension**, multiplyBy multiplier: CGFloat, constant: CGFloat, priority: UILayoutPriority? = nil) -> Planner_

this one could be used to plan any dimension constraints with any `AnonymousRelation` dimension anchor. The other dimension plan is:

> _func **dimension_name**(__ _relation:**InterRelation of NSLayoutDimension**, multiplyBy multiplier: CGFloat, constant: CGFloat, priority: UILayoutPriority? = nil) -> Planner_

this one could be used to plan any dimension constraints with any `NSLayoutDimension` anchor. The last dimension plan is:

> _func **dimension_name**(__ _relation:**InterRelation of CGFloat**, priority: UILayoutPriority? = nil) -> Planner_

this one could be used to plan any dimension constraints against any constant.

The `InterRelation` is the enumeration with generic parameter:

- **moreThanTo(Related)**
- **lessThanTo(Related)**
- **equalTo(Related)**

and `LayoutDimension` is enumeration of dimension:

- **height**
- **width**

a multiplier is a value that will be multiplied by dimension anchor. The constant will be added to the dimension.

### Dimensioning Shortcut

There are some shortcut for Dimensioning which are:

- `func size(_ relation: InterRelation<CGSize>, priority: UILayoutPriority? = nil) -> Self`
- `func size(_ relation: InterRelation<UIView>, multiplyBy multiplier: CGFloat = 1, constant: CGFloat = 0, priority: UILayoutPriority? = nil) -> Self`

both will automatically assign both width and height constraints towards CGSize constant or UIView size. Example:

```swift
myView.plan
    .size(.equalTo(otherView), multiplyBy: 2)
otherView.plan 
    .size(.equalTo(.init(width: 24, height: 24)))
```

## Draftsman Planned

Draftsman `Planned` protocol is the protocol that makes any `UIView` or `UIViewController` can have its predefined view plan and applied it using `applyPlan` method. The protocol is declared like this:

```swift
public protocol Planned {
    @LayoutPlan
    var viewPlan: ViewPlan { get }
    
    func applyPlan()
}
```

The only thing you need to implement is the `viewPlan` getter:

```swift
import Draftsman

class MyViewController: UIViewController, Planned {
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        UIStackView(axis: .vertical, spacing: 32).plan
            .center(.equal, to: .parent)
            .horizontal(.equalTo(16), to: .safeArea)
            .vertical(.moreThanTo(16), to: .safeArea)
            .insertStacked {
                MyView()
                MyOtherView()
                SomeOtherView()
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyPlan()
    }
}
```

Every time you call `applyPlan`, it will always try to recreate the view to be same like what declared in `ViewPlan`

***

### Fragment

`Fragment` in Draftsman is actually an ordinary UIView (or `TableViewCell`/`CollectionViewCell`) that can do a plan for itself and its `subviews` by using `Planned` capabilities

```swift
public protocol Fragment: Planned {
    func fragmentWillPlanContent()
    func fragmentDidPlanContent()
}
```

- `fragmentWillPlanContent()` will be called before `planContent(_:)` is called. its optional
- `fragmentDidPlanContent()` will be called after `planContent(_:)` is called. its optional

The mechanism is very straightforward. lets say you have this simple fragment:

```swift
class MySimpleFragment: UIView, Fragment {
    var margin = UIEdgeInsets(insets: 8)
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        UIButton().plan.edges(equalTo(margin), to: .parent)
    }

}
```

to put it in ViewController bottom edges:

```swift
class MySimpleViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        planContent {
            MySimpleFragment().plan
                .at(.fullBottom, .equal, to: .parent)
        }
}
```

`viewPlan` in `MySimpleFragment` will be executed as part of `MySimpleViewController` planContent.

There are two other extensions method you could use to call planContent indirectly:

- `func planFragment(delegate: PlanDelegate? = nil)` which will be call `fragmentWillPlanContent()` and activate all created constraints right away and `fragmentDidPlanContent()`
- `func replanContent(delegate: PlanDelegate? = nil)` which will remove all its and subviews constraints created by Draftsman and call `planFragment(delegate:)`

***

### Fragment View

There is UIView that already implemented Fragment that you can extend named `FragmentView`. It has some more open method that you can use:

- `func fragmentWillLayoutForTheFirstTime()` which will be called inside `layoutSubviews()` and only once at the first time before `super.layoutSubviews()`
- `func fragmentDidLayoutForTheFirstTime()` which will be called inside `layoutSubviews()` and only once at the first time after  `super.layoutSubviews()`

The advantages of the FragmentView are:

| Capabilities | Fragment View  | Implementing Own Fragment |
| :---: | :---: | :---: |
| have `fragmentWillLayoutForTheFirstTime()`  | YES | NO |
| have `fragmentDidLayoutForTheFirstTime()`  | YES | NO |
| automatically run `planFragment` when inserted to any `UIView` | YES | NO |
| automatically run  `planFragment` when planned using Draftsman | YES | YES |

example:

```swift
class MySimpleFragment: FragmentView {
    var margin = UIEdgeInsets(insets: 8)
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        UIButton().plan.edges(equalTo(margin), to: .parent)
    }
    
    func fragmentDidLayoutForTheFirstTime() {
        addGradient(with: self.bounds)
    }
}
```

***

### Fragment Cell

There is Fragment created specifically for cell which named `FragmentCell`:

```swift
public protocol FragmentCell: Fragment {
    var layoutPhase: CellLayoutingPhase { get }
    var planningBehavior: CellPlanningBehavior { get }
    func planningOption(on phase: CellLayoutingPhase) -> PlanningOption
}
```

You're not supposed to implement FragmentCell by yourself but by extend `TableFragmentCell` which is `UITableViewCell` that implement `FragmentCell` or `CollectionFragmentCell` which is `UICollectionViewCell` that implement `FragmentCell`. The reason is that all of the `FragmentCell` implementation is implemented there as part of how those `FragmentCell` should behave.

### Behavior and Phase

As we could see before, the `FragmentCell` have two properties and one added method:

- `var layoutPhase: CellLayoutingPhase { get }`
- `var planningBehavior: CellPlanningBehavior { get }`
- `func planningOption(on phase: CellLayoutingPhase) -> PlanningOption`

The `layoutPhase` is the phase of the Cell, which is an enumeration:

- **firstLoad** which indicated that the `Cell` is just created
- **setNeedsLayout** which indicated that the `Cell` `setNeedsLayout()` is just called
- **reused** which indicated that the `Cell` is being reused
- **none

the `planningBehavior` is the behavior of the cell during layouting which could be overridden if needed. It is enumeration which contains:

- **planOnce** which will only call `planContent(_:)` during `firstLoad` phase
- **planOn(CellLayoutingPhase)** which will only call `planContent(_:)` during the given `CellLayoutingPhase`
- **planOnEach([CellLayoutingPhase])** which will only call `planContent(_:)` during each given `CellLayoutingPhase`
- **planIfPossible** which will always call `planContent(_:)` for any `CellLayoutingPhase`

. Example:

```swift
class EventCollectionCell: CollectionFragmentCell {
    override var planningBehavior: CellPlanningBehavior { .planIfPossible }

    lazy var imageView: UIImageView = .init()
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        imageView.plan.edges(equalTo(margin), to: .parent)
    }
}
```

Cell at the example above will always create `viewPlan` at any phases.

If you want to manually create `viewPlan` during any phases, you could just call `layoutContentIfNeeded()` it will layout content if the current phase is whitelisted in `planningBehavior` and return `Bool` indicated that the `planContent(_:)` is called or not.

### Table Fragment Cell

`TableFragmentCell` is the `UITableViewCell` that implement `FragmentCell`. Other than what `UITableViewCell`, `Fragment` and `FragmentCell` feature, it have one method that  could help you determine cell dimension:

**func calculatedCellHeight(for cellWidth: CGFloat) -> CGFloat**

`cellWidth` is the width of the cell which already calculated according to the tableView content width and insets. The default return value is automatic, but it could be came in handy if the cell `NSLayoutConstraints` alone cannot give the exact dimension of the cell. Example:

```swift
class MyCell: TableFragmentCell {
    lazy var collectionLayout: UICollectionViewFlowLayout = .init()
    lazy var collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: collectionLayout)
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        collectionView.plan.edges(equalTo(margin), to: .parent)
    }
    
    override func fragmentWillPlanContent() {
        collectionView.allowsSelection = true
        collectionView.backgroundColor = .clear
        collectionView.allowsSelection = true
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.itemSize = .init(width: .x64, height: .x48)
        collectionLayout.minimumInteritemSpacing = .zero
        collectionLayout.minimumLineSpacing = .zero
    }
    
    override func calculatedCellHeight(for cellWidth: CGFloat) -> CGFloat {
        128
    }
}
```

If you want to inject cellSize calculator, just pass a closure to `whenNeedCellSize` method at the cell

```swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableFragmentCell
    cell.whenNeedCellSize { width in
        return 128
    }
    return cell
}
```

The cell above will have a height of 128 regarding how long is cellWidth.

### Collection Fragment Cell

`CollectionFragmentCell` is the `UICollectionViewCell` that implement `FragmentCell`. Other than what `UICollectionViewCell`, `Fragment` and `FragmentCell` feature.

```swift
class EventCollectionCell: CollectionFragmentCell {
    lazy var imageView: UIImageView = .init()
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        imageView.plan.edges(equalTo(margin), to: .parent)
    }
}
```

***

## Contribute

You know how, just clone and do pull request
