//
//  File.swift
//  
//
//  Created by Nayanda Haberty on 9/1/23.
//

import Foundation
#if canImport(UIKit)
import UIKit

extension ViewDraft where Self: ViewPlanBuilder, Self: LayoutAnchor, Self.Layout: UIView {
    
    @inlinable public func fillParent() -> QuadAnchorRelation<Self> {
        edges.equal(with: .parent)
    }
    
    @inlinable public func fillSafeArea() -> QuadAnchorRelation<Self> {
        edges.equal(with: .safeArea)
    }
    
    @inlinable public func matchParentH() -> PairAnchorRelation<Self, NSLayoutXAxisAnchor> {
        horizontal.equal(with: .parent)
    }
    
    @inlinable public func matchParentV() -> PairAnchorRelation<Self, NSLayoutYAxisAnchor> {
        vertical.equal(with: .parent)
    }
    
    @inlinable public func matchSafeAreaH() -> PairAnchorRelation<Self, NSLayoutXAxisAnchor> {
        horizontal.equal(with: .safeArea)
    }
    
    @inlinable public func matchSafeAreaV() -> PairAnchorRelation<Self, NSLayoutYAxisAnchor> {
        vertical.equal(with: .safeArea)
    }
    
    @inlinable public func matchParentSize() -> SizeAnchorRelation<Self> {
        size.equal(with: .parent)
    }
    
    @inlinable public func centered() -> AxisAnchorRelation<Self> {
        center.equal(with: .parent)
    }
    
    @inlinable public func centeredH() -> SingleAnchorRelation<Self, NSLayoutXAxisAnchor> {
        centerX.equal(with: .parent)
    }
    
    @inlinable public func centeredV() -> SingleAnchorRelation<Self, NSLayoutYAxisAnchor> {
        centerY.equal(with: .parent)
    }
    
    @inlinable public func onTopOfKeyboard() -> SingleAnchorRelation<Self, NSLayoutYAxisAnchor> {
        bottom.equal(with: .top(of: .keyboard))
    }
    
    @inlinable public func cornered(at position: CornerPosition) -> AxisAnchorRelation<Self> {
        switch position {
        case .topLeft:
            return top.left.equal(with: .parent)
        case .topLeading:
            return top.leading.equal(with: .parent)
        case .topRight:
            return top.right.equal(with: .parent)
        case .topTrailing:
            return top.trailing.equal(with: .parent)
        case .bottomLeft:
            return bottom.left.equal(with: .parent)
        case .bottomLeading:
            return bottom.leading.equal(with: .parent)
        case .bottomRight:
            return bottom.right.equal(with: .parent)
        case .bottomTrailing:
            return bottom.trailing.equal(with: .parent)
        }
    }
    
    @inlinable public func widthMatchHeight() -> DimensionAnchorRelation<Self> {
        width.equal(with: .height(of: .mySelf))
    }
    
    @inlinable public func heightMatchWidth() -> DimensionAnchorRelation<Self> {
        height.equal(with: .width(of: .mySelf))
    }
    
    @inlinable public func sized(_ size: CGSize) -> SizeAnchorConstant<Self> {
        self.size.equal(with: size)
    }
}

extension ConstraintBuilderRootRecoverable where Root: ViewDraft, Root.Layout: UIView {
    @inlinable public func fillParent() -> QuadAnchorRelation<Root> {
        backToRoot { $0.fillParent() }
    }
    
    @inlinable public func fillSafeArea() -> QuadAnchorRelation<Root> {
        backToRoot { $0.fillSafeArea() }
    }
    
    @inlinable public func matchParentH() -> PairAnchorRelation<Root, NSLayoutXAxisAnchor> {
        backToRoot { $0.matchParentH() }
    }
    
    @inlinable public func matchParentV() -> PairAnchorRelation<Root, NSLayoutYAxisAnchor> {
        backToRoot { $0.matchParentV() }
    }
    
    @inlinable public func matchSafeAreaH() -> PairAnchorRelation<Root, NSLayoutXAxisAnchor> {
        backToRoot { $0.matchSafeAreaH() }
    }
    
    @inlinable public func matchSafeAreaV() -> PairAnchorRelation<Root, NSLayoutYAxisAnchor> {
        backToRoot { $0.matchSafeAreaV() }
    }
    
    @inlinable func matchParentSize() -> SizeAnchorRelation<Root> {
        backToRoot { $0.matchParentSize() }
    }
    
    @inlinable public func centered() -> AxisAnchorRelation<Root> {
        backToRoot { $0.centered() }
    }
    
    @inlinable public func centeredH() -> SingleAnchorRelation<Root, NSLayoutXAxisAnchor> {
        backToRoot { $0.centeredH() }
    }
    
    @inlinable public func centeredV() -> SingleAnchorRelation<Root, NSLayoutYAxisAnchor> {
        backToRoot { $0.centeredV() }
    }
    
    @inlinable public func onTopOfKeyboard() -> SingleAnchorRelation<Root, NSLayoutYAxisAnchor> {
        backToRoot { $0.onTopOfKeyboard() }
    }
    
    @inlinable public func cornered(at position: CornerPosition) -> AxisAnchorRelation<Root> {
        backToRoot { $0.cornered(at: position) }
    }
    
    @inlinable public func widthMatchHeight() -> DimensionAnchorRelation<Root> {
        backToRoot { $0.widthMatchHeight() }
    }
    
    @inlinable public func heightMatchWidth() -> DimensionAnchorRelation<Root> {
        backToRoot { $0.heightMatchWidth() }
    }
    
    @inlinable public func sized(_ size: CGSize) -> SizeAnchorConstant<Root> {
        backToRoot { $0.sized(size) }
    }
}

public enum CornerPosition {
    case topLeft
    case topLeading
    case topRight
    case topTrailing
    case bottomLeft
    case bottomLeading
    case bottomRight
    case bottomTrailing
}
#endif
