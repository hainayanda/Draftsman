//
//  ViewScheme+Shortcuts.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 07/07/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension ViewScheme {
    
    // MARK: Center Anchor
    
    @discardableResult
    func center(
        _ relation: LayoutRelation<CoordinateOffsets>,
        to view: UIView,
        priority: UILayoutPriority? = nil) -> Self {
        let priority: UILayoutPriority = priority ?? context.mutatingPriority
        centerX(relation.asXRelation, to: view.centerXAnchor, priority: priority)
        centerY(relation.asYRelation, to: view.centerYAnchor, priority: priority)
        return self
    }
    
    @discardableResult
    func center(
        _ relation: LayoutRelation<CoordinateOffsets>,
        to anchor: AnonymousRelation,
        priority: UILayoutPriority? = nil) -> Self {
        let priority: UILayoutPriority = priority ?? context.mutatingPriority
        centerX(relation.asXRelation, to: anchor, priority: priority)
        centerY(relation.asYRelation, to: anchor, priority: priority)
        return self
    }
    
    // MARK: Vertical Anchor
    
    @discardableResult
    func vertical(
        _ relation: LayoutRelation<InsetsConvertible>,
        to anchor: AnonymousRelation,
        priority: UILayoutPriority? = nil) -> Self {
        let priority: UILayoutPriority = priority ?? context.mutatingPriority
        top(relation.asTopRelation, to: anchor, priority: priority)
        bottom(relation.asBottomRelation, to: anchor, priority: priority)
        return self
    }
    
    @discardableResult
    func vertical(
        _ relation: LayoutRelation<InsetsConvertible>,
        to view: UIView,
        priority: UILayoutPriority? = nil) -> Self {
        let priority: UILayoutPriority = priority ?? context.mutatingPriority
        top(relation.asTopRelation, to: view.topAnchor, priority: priority)
        bottom(relation.asBottomRelation, to: view.bottomAnchor, priority: priority)
        return self
    }
    
    // MARK: Horizontal Anchor
    
    @discardableResult
    func horizontal(
        _ relation: LayoutRelation<InsetsConvertible>,
        to view: UIView,
        priority: UILayoutPriority? = nil) -> Self {
        let priority: UILayoutPriority = priority ?? context.mutatingPriority
        left(relation.asLeftRelation, to: view.leftAnchor, priority: priority)
        right(relation.asRightRelation, to: view.rightAnchor, priority: priority)
        return self
    }
    
    @discardableResult
    func horizontal(
        _ relation: LayoutRelation<InsetsConvertible>,
        to anchor: AnonymousRelation,
        priority: UILayoutPriority? = nil) -> Self {
        let priority: UILayoutPriority = priority ?? context.mutatingPriority
        left(relation.asLeftRelation, to: anchor, priority: priority)
        right(relation.asRightRelation, to: anchor, priority: priority)
        return self
    }
    
    // MARK: Edges Anchor
    
    @discardableResult
    func edges(
        _ relation: LayoutRelation<InsetsConvertible>,
        to anchor: AnonymousRelation,
        priority: UILayoutPriority? = nil) -> Self {
        let priority: UILayoutPriority = priority ?? context.mutatingPriority
        vertical(relation, to: anchor, priority: priority)
        horizontal(relation, to: anchor, priority: priority)
        return self
    }
    
    // MARK: Size Anchor
    
    @discardableResult
    func size(
        _ relation: InterRelation<CGSize>,
        priority: UILayoutPriority? = nil) -> Self {
        let priority: UILayoutPriority = priority ?? context.mutatingPriority
        height(relation.asHeightRelation, priority: priority)
        width(relation.asHeightRelation, priority: priority)
        return self
    }
    
    @discardableResult
    func size(
        _ relation: InterRelation<UIView>,
        multiplyBy multipier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: UILayoutPriority? = nil) -> Self {
        let priority: UILayoutPriority = priority ?? context.mutatingPriority
        height(relation.asHeightRelation, multiplyBy: multipier, constant: constant, priority: priority)
        width(relation.asWidthRelation, multiplyBy: multipier, constant: constant, priority: priority)
        return self
    }
    
    // MARK: Position Anchor
    
    @discardableResult
    func at(
        _ positions: [LayoutEdge],
        _ relation: LayoutRelation<InsetsConvertible>,
        to anchor: AnonymousRelation,
        priority: UILayoutPriority? = nil) -> Self {
        let priority: UILayoutPriority = priority ?? context.mutatingPriority
        for position in positions {
            switch position {
            case .top:
                top(relation.asTopRelation, to: anchor, priority: priority)
            case .bottom:
                bottom(relation.asBottomRelation, to: anchor, priority: priority)
            case .left:
                left(relation.asLeftRelation, to: anchor, priority: priority)
            case .right:
                right(relation.asRightRelation, to: anchor, priority: priority)
            }
        }
        return self
    }
    
    @discardableResult
    func at(
        _ viewRelation: RelatedPosition,
        _ relation: LayoutRelation<InsetsConvertible>,
        priority: UILayoutPriority? = nil) -> Self {
        let priority: UILayoutPriority = priority ?? context.mutatingPriority
        let position = viewRelation.position
        let relatedView = viewRelation.view
        switch position {
        case .top:
            bottom(relation.asBottomRelation, to: relatedView.topAnchor, priority: priority)
        case .bottom:
            top(relation.asTopRelation, to: relatedView.bottomAnchor, priority: priority)
        case .left:
            right(relation.asRightRelation, to: relatedView.leftAnchor, priority: priority)
        case .right:
            left(relation.asLeftRelation, to: relatedView.rightAnchor, priority: priority)
        }
        if viewRelation.shouldParallel {
            switch position {
            case .top, .bottom:
                centerX(.equal, to: relatedView.centerXAnchor, priority: priority)
            case .left, .right:
                centerY(.equal, to: relatedView.centerYAnchor, priority: priority)
            }
        }
        return self
    }
    
    // MARK: Between Anchor
    
    @discardableResult
    func inBetween(
        of view: UIView,
        and otherView: UIView,
        _ position: MiddlePosition,
        priority: UILayoutPriority? = nil) -> Self {
        let priority: UILayoutPriority = priority ?? context.mutatingPriority
        switch position {
        case .vertically(let relation):
            top(relation.asTopRelation, to: view.bottomAnchor, priority: priority)
            bottom(relation.asBottomRelation, to: otherView.topAnchor, priority: priority)
        case .horizontally(let relation):
            left(relation.asLeftRelation, to: view.rightAnchor, priority: priority)
            right(relation.asRightRelation, to: view.leftAnchor, priority: priority)
        }
        return self
    }
}

public extension Array where Element == LayoutEdge {
    static var topLeft: [Element] { [.top, .left] }
    static var topRight: [Element] { [.top, .right] }
    static var bottomLeft: [Element] { [.bottom, .left] }
    static var bottomRight: [Element] { [.bottom, .right] }
    static var fullLeft: [Element] { [.left, .top, .bottom] }
    static var fullRight: [Element] { [.right, .top, .bottom] }
    static var fullBottom: [Element] { [.bottom, .left, .right] }
    static var fullTop: [Element] { [.top, .left, .right] }
    static var edges: [Element] { [.top, .bottom, .left, .right] }
}
#endif
