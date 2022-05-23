//
//  Enumeration.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 23/04/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

public enum AnchorOffsetSign {
    case positive
    case negative
    
    func convert(relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint.Relation {
        switch self {
        case .positive:
            return relation
        case .negative:
            switch relation {
            case .lessThanOrEqual:
                return .greaterThanOrEqual
            case .greaterThanOrEqual:
                return .lessThanOrEqual
            default:
                return relation
            }
        }
    }
    
    func convert(offset: CGFloat) -> CGFloat {
        switch self {
        case .positive:
            return offset
        case .negative:
            return -offset
        }
    }
    
    func convert(inset: CGFloat) -> CGFloat {
        convert(offset: -inset)
    }
}

public enum AnonymousLayout {
    case mySelf
    case parent
    case safeArea
    case keyboard
    case keyboardSafeArea
    case previous
    case previousSafeArea
}

public enum XAnonymousAnchor {
    case left(of: AnonymousLayout)
    case leading(of: AnonymousLayout)
    case right(of: AnonymousLayout)
    case trailing(of: AnonymousLayout)
    case centerX(of: AnonymousLayout)
    
    var keypath: KeyPath<LayoutWithAnchors, NSLayoutXAxisAnchor> {
        switch self {
        case .left:
            return \.leftAnchor
        case .leading:
            return \.leadingAnchor
        case .right:
            return \.rightAnchor
        case .trailing:
            return \.trailingAnchor
        case .centerX:
            return \.centerXAnchor
        }
    }
    
    var anonymousLayout: AnonymousLayout {
        switch self {
        case .left(let anonymous), .leading(let anonymous),
                .right(let anonymous), .trailing(let anonymous),
                .centerX(let anonymous):
            return anonymous
        }
    }
}

public enum YAnonymousAnchor {
    case top(of: AnonymousLayout)
    case bottom(of: AnonymousLayout)
    case centerY(of: AnonymousLayout)
    
    var keypath: KeyPath<LayoutWithAnchors, NSLayoutYAxisAnchor> {
        switch self {
        case .top:
            return \.topAnchor
        case .bottom:
            return \.bottomAnchor
        case .centerY:
            return \.centerYAnchor
        }
    }
    
    var anonymousLayout: AnonymousLayout {
        switch self {
        case .top(let anonymous), .bottom(let anonymous),
                .centerY(let anonymous):
            return anonymous
        }
    }
}

public enum XYAnonymousAnchor {
    case topLeft(of: AnonymousLayout)
    case topLeading(of: AnonymousLayout)
    case topRight(of: AnonymousLayout)
    case topTrailing(of: AnonymousLayout)
    case bottomLeft(of: AnonymousLayout)
    case bottomLeading(of: AnonymousLayout)
    case bottomRight(of: AnonymousLayout)
    case bottomTrailing(of: AnonymousLayout)
    case center(of: AnonymousLayout)
    case centerLeft(of: AnonymousLayout)
    case centerLeading(of: AnonymousLayout)
    case centerRight(of: AnonymousLayout)
    case centerTrailing(of: AnonymousLayout)
    case centerTop(of: AnonymousLayout)
    case centerBottom(of: AnonymousLayout)
    
    var anonymousLayout: AnonymousLayout {
        switch self {
        case .topLeft(let anonymous), .topLeading(let anonymous),
                .topRight(let anonymous), .topTrailing(let anonymous),
                .bottomLeft(let anonymous), .bottomLeading(let anonymous),
                .bottomRight(let anonymous), .bottomTrailing(let anonymous),
                .center(let anonymous), .centerLeft(let anonymous),
                .centerLeading(let anonymous), .centerRight(let anonymous),
                .centerTrailing(let anonymous), .centerTop(let anonymous),
                .centerBottom(let anonymous):
            return anonymous
        }
    }
    
    var xKeyPath: KeyPath<LayoutWithAnchors, NSLayoutXAxisAnchor> {
        switch self {
        case .topLeft, .bottomLeft, .centerLeft:
            return \.leftAnchor
        case .topLeading, .bottomLeading, .centerLeading:
            return \.leadingAnchor
        case .topRight, .bottomRight, .centerRight:
            return \.rightAnchor
        case .topTrailing, .bottomTrailing, .centerTrailing:
            return \.trailingAnchor
        case .center, .centerTop, .centerBottom:
            return \.centerXAnchor
        }
    }
    
    var yKeyPath: KeyPath<LayoutWithAnchors, NSLayoutYAxisAnchor> {
        switch self {
        case .topLeft, .topLeading, .topRight, .topTrailing, .centerTop:
            return \.topAnchor
        case .bottomLeft, .bottomLeading, .bottomRight, .bottomTrailing, .centerBottom:
            return \.bottomAnchor
        case .center, .centerLeft, .centerLeading, .centerRight, .centerTrailing:
            return \.centerYAnchor
        }
    }
}

public enum DimensionAnonymousAnchor {
    case height(of: AnonymousLayout)
    case width(of: AnonymousLayout)
    
    var keypath: KeyPath<LayoutWithAnchors, NSLayoutDimension> {
        switch self {
        case .height:
            return \.heightAnchor
        case .width:
            return \.widthAnchor
        }
    }
    
    var anonymousLayout: AnonymousLayout {
        switch self {
        case .height(let anonymous), .width(let anonymous):
            return anonymous
        }
    }
}
#endif
