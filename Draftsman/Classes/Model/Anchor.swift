//
//  Anchor.swift
//  Draftsman
//
//  Created by Nayanda Haberty (ID) on 07/07/20.
//

import Foundation
#if canImport(UIKit)
import Clavier
import UIKit

public struct AnchorWithOffset<LayoutAnchor> {
    var anchor: LayoutAnchor
    var offset: CGFloat = 0
    var isHaveOffset: Bool {
        return offset > 0
    }
}

public struct RelatedAnchor<LayoutAnchor> {
    var related: AnonymousRelation
    var anchorKeyPath: KeyPath<UIView, LayoutAnchor>
}

extension RelatedAnchor {
    func extractRelatedView(from context: PlanContext) -> UIView? {
        switch related {
        case .parent, .safeArea, .keyboard, .keyboardSafeArea:
            return context.currentView.superview ?? context.delegate.planer(viewHaveNoSuperview: context.currentView)
        case .myself, .mySafeArea:
            return context.currentView
        case .previous, .previousSafeArea:
            return context.previousView
        }
    }
}

public extension RelatedAnchor {
    
    // MARK: X Axis
    
    static func left(of related: AnonymousRelation) -> RelatedAnchor<NSLayoutXAxisAnchor> {
        return .init(related: related, anchorKeyPath: \.leftAnchor)
    }
    
    static func right(of related: AnonymousRelation) -> RelatedAnchor<NSLayoutXAxisAnchor> {
        .init(related: related, anchorKeyPath: \.rightAnchor)
    }
    
    static func centerX(of related: AnonymousRelation) -> RelatedAnchor<NSLayoutXAxisAnchor> {
        .init(related: related, anchorKeyPath: \.centerXAnchor)
    }
    
    // MARK: Y Axis
    
    static func top(of related: AnonymousRelation) -> RelatedAnchor<NSLayoutYAxisAnchor> {
        .init(related: related, anchorKeyPath: \.topAnchor)
    }
    
    static func bottom(of related: AnonymousRelation) -> RelatedAnchor<NSLayoutYAxisAnchor> {
        .init(related: related, anchorKeyPath: \.bottomAnchor)
    }
    
    static func centerY(of related: AnonymousRelation) -> RelatedAnchor<NSLayoutYAxisAnchor> {
        .init(related: related, anchorKeyPath: \.centerYAnchor)
    }
    
    // MARK: Dimension

    static func width(of related: AnonymousRelation) -> RelatedAnchor<NSLayoutDimension> {
        .init(related: related, anchorKeyPath: \.widthAnchor)
    }
    
    static func height(of related: AnonymousRelation) -> RelatedAnchor<NSLayoutDimension> {
        .init(related: related, anchorKeyPath: \.heightAnchor)
    }
}

public extension RelatedAnchor where LayoutAnchor == NSLayoutYAxisAnchor {
    func getOffsettedAnchor(from context: PlanContext) -> AnchorWithOffset<LayoutAnchor>? {
        guard let relatedView = extractRelatedView(from: context) else { return nil }
        let anchor = relatedView[keyPath: anchorKeyPath]
        switch related {
        case .safeArea, .mySafeArea, .previousSafeArea:
            if #available(iOS 11.0, *) {
                return .init(anchor: relatedView.safeAreaLayoutGuide[equal: anchorKeyPath])
            }
            return .init(anchor: anchor, offset: relatedView.layoutMargins[equal: anchorKeyPath])
        case .keyboard:
            return .init(anchor: relatedView.keyboardLayoutGuide[equal: anchorKeyPath])
        case .keyboardSafeArea:
            return .init(anchor: relatedView.safeKeyboardLayoutGuide[equal: anchorKeyPath])
        default:
            return .init(anchor: anchor)
        }
    }
}

public extension RelatedAnchor where LayoutAnchor == NSLayoutXAxisAnchor {
    func getOffsettedAnchor(from context: PlanContext) -> AnchorWithOffset<LayoutAnchor>? {
        guard let relatedView = extractRelatedView(from: context) else { return nil }
        let anchor = relatedView[keyPath: anchorKeyPath]
        switch related {
        case .safeArea, .mySafeArea, .previousSafeArea:
            if #available(iOS 11.0, *) {
                return .init(anchor: relatedView.safeAreaLayoutGuide[equal: anchorKeyPath])
            }
            return .init(anchor: anchor, offset: relatedView.layoutMargins[equal: anchorKeyPath])
        case .keyboard:
            return .init(anchor: relatedView.keyboardLayoutGuide[equal: anchorKeyPath])
        case .keyboardSafeArea:
            return .init(anchor: relatedView.safeKeyboardLayoutGuide[equal: anchorKeyPath])
        default:
            return .init(anchor: anchor)
        }
    }
}

public extension RelatedAnchor where LayoutAnchor == NSLayoutDimension {
    func getOffsettedAnchor(from context: PlanContext) -> AnchorWithOffset<LayoutAnchor>? {
        guard let relatedView = extractRelatedView(from: context) else { return nil }
        let anchor = relatedView[keyPath: anchorKeyPath]
        switch related {
        case .safeArea, .mySafeArea, .previousSafeArea:
            if #available(iOS 11.0, *) {
                return .init(anchor: relatedView.safeAreaLayoutGuide[equal: anchorKeyPath])
            }
            return .init(anchor: anchor, offset: relatedView.layoutMargins[equal: anchorKeyPath])
        case .keyboard:
            return .init(anchor: relatedView.keyboardLayoutGuide[equal: anchorKeyPath])
        case .keyboardSafeArea:
            return .init(anchor: relatedView.safeKeyboardLayoutGuide[equal: anchorKeyPath])
        default:
            return .init(anchor: anchor)
        }
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
