//
//  Anchor.swift
//  Draftsman
//
//  Created by Nayanda Haberty (ID) on 07/07/20.
//

import Foundation
#if canImport(UIKit)
import UIKit

@dynamicMemberLookup
public struct Anchor<LayoutAnchor: AnyObject> {
    var related: AnonymousRelation
    
    public subscript(dynamicMember keyPath: KeyPath<UIView, LayoutAnchor>) -> RelatedAnchor<LayoutAnchor> {
        .init(related: related, anchorKeyPath: keyPath)
    }
    
    public init(of related: AnonymousRelation) {
        self.related = related
    }
}

public struct RelatedAnchor<LayoutAnchor> {
    var related: AnonymousRelation
    var anchorKeyPath: KeyPath<UIView, LayoutAnchor>
}

public struct AnchorWithOffset<LayoutAnchor> {
    var anchor: LayoutAnchor
    var offset: CGFloat = 0
    var isHaveOffset: Bool {
        return offset > 0
    }
}

public extension RelatedAnchor where LayoutAnchor == NSLayoutYAxisAnchor {
    func getOffsettedAnchor(from context: PlanContext) -> AnchorWithOffset<LayoutAnchor>? {
        var view: UIView?
        switch related {
        case .parent, .safeArea:
            view = context.currentView.superview ?? context.delegate.planer(viewHaveNoSuperview: context.currentView)
        case .myself, .mySafeArea:
            view = context.currentView
        case .previous, .previousSafeArea:
            view = context.previousView
        }
        guard let relatedView = view else { return nil }
        let anchor = relatedView[keyPath: anchorKeyPath]
        if related.isSafeArea {
            if #available(iOS 11.0, *) {
                return .init(anchor: relatedView.safeAreaLayoutGuide[equal: anchorKeyPath])
            } else {
                return .init(anchor: anchor, offset: relatedView.layoutMargins[equal: anchorKeyPath])
            }
        }
        return .init(anchor: anchor)
    }
}

public extension RelatedAnchor where LayoutAnchor == NSLayoutXAxisAnchor {
    func getOffsettedAnchor(from context: PlanContext) -> AnchorWithOffset<LayoutAnchor>? {
        var view: UIView?
        switch related {
        case .parent, .safeArea:
            view = context.currentView.superview ?? context.delegate.planer(viewHaveNoSuperview: context.currentView)
        case .myself, .mySafeArea:
            view = context.currentView
        case .previous, .previousSafeArea:
            view = context.previousView
        }
        guard let relatedView = view else { return nil }
        let anchor = relatedView[keyPath: anchorKeyPath]
        if related.isSafeArea {
            if #available(iOS 11.0, *) {
                return .init(anchor: relatedView.safeAreaLayoutGuide[equal: anchorKeyPath])
            }
            return .init(anchor: anchor, offset: relatedView.layoutMargins[equal: anchorKeyPath])
        }
        return .init(anchor: anchor)
    }
}

public extension RelatedAnchor where LayoutAnchor == NSLayoutDimension {
    func getOffsettedAnchor(from context: PlanContext) -> AnchorWithOffset<LayoutAnchor>? {
        var view: UIView?
        switch related {
        case .parent, .safeArea:
            view = context.currentView.superview ?? context.delegate.planer(viewHaveNoSuperview: context.currentView)
        case .myself, .mySafeArea:
            view = context.currentView
        case .previous, .previousSafeArea:
            view = context.previousView
        }
        guard let relatedView = view else { return nil }
        let anchor = relatedView[keyPath: anchorKeyPath]
        if related.isSafeArea {
            if #available(iOS 11.0, *) {
                return .init(anchor: relatedView.safeAreaLayoutGuide[equal: anchorKeyPath])
            }
            return .init(anchor: anchor, offset: relatedView.layoutMargins[equal: anchorKeyPath])
        }
        return .init(anchor: anchor)
    }
}

public extension UIEdgeInsets {
    subscript(equal anchor: KeyPath<UIView, NSLayoutYAxisAnchor>) -> CGFloat {
        switch anchor {
        case \.topAnchor:
            return top
        case \.bottomAnchor:
            return bottom
        default:
            return top - bottom
        }
    }
    
    subscript(equal anchor: KeyPath<UIView, NSLayoutXAxisAnchor>) -> CGFloat {
        switch anchor {
        case \.leadingAnchor, \.leftAnchor:
            return left
        case \.trailingAnchor, \.rightAnchor:
            return right
        default:
            return left - right
        }
    }
    subscript(equal anchor: KeyPath<UIView, NSLayoutDimension>) -> CGFloat {
        switch anchor {
        case \.widthAnchor:
            return -(left + right)
        default:
            return -(top + bottom)
        }
    }
}

public extension UILayoutGuide {
    subscript(equal anchor: KeyPath<UIView, NSLayoutYAxisAnchor>) -> NSLayoutYAxisAnchor {
        switch anchor {
        case \.topAnchor:
            return topAnchor
        case \.bottomAnchor:
            return bottomAnchor
        default:
            return centerYAnchor
        }
    }
    
    subscript(equal anchor: KeyPath<UIView, NSLayoutXAxisAnchor>) -> NSLayoutXAxisAnchor {
        switch anchor {
        case \.leadingAnchor:
            return leadingAnchor
        case \.leftAnchor:
            return leftAnchor
        case \.trailingAnchor:
            return trailingAnchor
        case \.rightAnchor:
            return rightAnchor
        default:
            return centerXAnchor
        }
    }
    subscript(equal anchor: KeyPath<UIView, NSLayoutDimension>) -> NSLayoutDimension {
        switch anchor {
        case \.widthAnchor:
            return widthAnchor
        default:
            return heightAnchor
        }
    }
}
#endif
