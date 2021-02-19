//
//  Enumeration+Extensions.swift
//  Draftsman
//
//  Created by Nayanda Haberty (ID) on 28/08/20.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension LayoutRelation where Related == InsetsConvertible {
    
    var asTopRelation: LayoutRelation<CGFloat> {
        switch self {
        case .equal:
            return .equal
        case .moreThan:
            return .moreThan
        case .lessThan:
            return .lessThan
        case .equalTo(let insets):
            return .equalTo(insets.vertical.top)
        case .moreThanTo(let insets):
            return .moreThanTo(insets.vertical.top)
        case .lessThanTo(let insets):
            return .lessThanTo(insets.vertical.top)
        }
    }
    
    var asBottomRelation: LayoutRelation<CGFloat> {
        switch self {
        case .equal:
            return .equal
        case .moreThan:
            return .moreThan
        case .lessThan:
            return .lessThan
        case .equalTo(let insets):
            return .equalTo(insets.vertical.bottom)
        case .moreThanTo(let insets):
            return .moreThanTo(insets.vertical.bottom)
        case .lessThanTo(let insets):
            return .lessThanTo(insets.vertical.bottom)
        }
    }
    
    var asLeftRelation: LayoutRelation<CGFloat> {
        switch self {
        case .equal:
            return .equal
        case .moreThan:
            return .moreThan
        case .lessThan:
            return .lessThan
        case .equalTo(let insets):
            return .equalTo(insets.horizontal.left)
        case .moreThanTo(let insets):
            return .moreThanTo(insets.horizontal.left)
        case .lessThanTo(let insets):
            return .lessThanTo(insets.horizontal.left)
        }
    }
    
    var asRightRelation: LayoutRelation<CGFloat> {
        switch self {
        case .equal:
            return .equal
        case .moreThan:
            return .moreThan
        case .lessThan:
            return .lessThan
        case .equalTo(let insets):
            return .equalTo(insets.horizontal.right)
        case .moreThanTo(let insets):
            return .moreThanTo(insets.horizontal.right)
        case .lessThanTo(let insets):
            return .lessThanTo(insets.horizontal.right)
        }
    }
}

public extension LayoutRelation where Related == CoordinateOffsets {
    var asXRelation: LayoutRelation<CGFloat> {
        switch self {
        case .equal:
            return .equal
        case .moreThan:
            return .moreThan
        case .lessThan:
            return .lessThan
        case .equalTo(let offsets):
            return .equalTo(offsets.xOffset)
        case .moreThanTo(let offsets):
            return .moreThanTo(offsets.xOffset)
        case .lessThanTo(let offsets):
            return .lessThanTo(offsets.xOffset)
        }
    }
    
    var asYRelation: LayoutRelation<CGFloat> {
        switch self {
        case .equal:
            return .equal
        case .moreThan:
            return .moreThan
        case .lessThan:
            return .lessThan
        case .equalTo(let offsets):
            return .equalTo(offsets.yOffset)
        case .moreThanTo(let offsets):
            return .moreThanTo(offsets.yOffset)
        case .lessThanTo(let offsets):
            return .lessThanTo(offsets.yOffset)
        }
    }
}

public extension LayoutRelation where Related == CGFloat {
    var distance: CGFloat {
        switch self {
        case .moreThanTo(let distance), .lessThanTo(let distance), .equalTo(let distance):
            return distance
        case .moreThan, .lessThan, .equal:
            return 0
        }
    }
    func add(offset: CGFloat) -> LayoutRelation<CGFloat> {
        guard offset != 0 else { return self }
        switch self {
        case .equal:
            return .equalTo(offset)
        case .lessThan:
            return .lessThanTo(offset)
        case .moreThan:
            return .moreThanTo(offset)
        case .equalTo(let current):
            return .equalTo(current + offset)
        case .moreThanTo(let current):
            return .moreThanTo(current + offset)
        case .lessThanTo(let current):
            return .lessThanTo(current + offset)
        }
    }
}

public extension InterRelation {
    func mapped<NewRelated>(_ mapper: (Related) -> NewRelated) -> InterRelation<NewRelated> {
        switch self {
        case .equalTo(let related):
            return .equalTo(mapper(related))
        case .moreThanTo(let related):
            return .moreThanTo(mapper(related))
        case .lessThanTo(let related):
            return .lessThanTo(mapper(related))
        }
    }
}

public extension InterRelation where Related == CGSize {
    var asHeightRelation: InterRelation<CGFloat> {
        mapped { $0.height }
    }
    var asWidthRelation: InterRelation<CGFloat> {
        mapped { $0.width }
    }
}

public extension InterRelation where Related == UIView {
    var asHeightRelation: InterRelation<NSLayoutDimension> {
        mapped { $0.heightAnchor }
    }
    var asWidthRelation: InterRelation<NSLayoutDimension> {
        mapped { $0.widthAnchor }
    }
}

public extension RelatedPosition {
    var position: LayoutEdge {
        switch self {
        case .topOf(_), .topOfAndParallelWith(_):
            return .top
        case .bottomOf(_), .bottomOfAndParallelWith(_):
            return .bottom
        case .leftOf(_), .leftOfAndParallelWith(_):
            return .left
        case .rightOf(_), .rightOfAndParallelWith(_):
            return .right
        }
    }
    var shouldParallel: Bool {
        switch self {
        case .topOfAndParallelWith(_), .bottomOfAndParallelWith(_), .leftOfAndParallelWith(_), .rightOfAndParallelWith(_):
            return true
        default:
            return false
        }
    }
    var view: UIView {
        switch self {
        case .topOf(let view), .topOfAndParallelWith(let view),
             .bottomOf(let view), .bottomOfAndParallelWith(let view),
             .leftOf(let view), .leftOfAndParallelWith(let view),
             .rightOf(let view), .rightOfAndParallelWith(let view):
            return view
        }
    }
}

extension NSLayoutConstraint.Attribute {
    var asString: String {
        switch self {
        case .left:
            return "left"
        case .right:
            return "right"
        case .top:
            return "top"
        case .bottom:
            return "bottom"
        case .leading:
            return "leading"
        case .trailing:
            return "trailing"
        case .width:
            return "width"
        case .height:
            return "height"
        case .centerX:
            return "centerX"
        case .centerY:
            return "centerY"
        case .lastBaseline:
            return "lastBaseline"
        case .firstBaseline:
            return "firstBaseline"
        case .leftMargin:
            return "leftMargin"
        case .rightMargin:
            return "rightMargin"
        case .topMargin:
            return "topMargin"
        case .bottomMargin:
            return "bottomMargin"
        case .leadingMargin:
            return "leadingMargin"
        case .trailingMargin:
            return "trailingMargin"
        case .centerXWithinMargins:
            return "centerXWithinMargins"
        case .centerYWithinMargins:
            return "centerYWithinMargins"
        case .notAnAttribute:
            return "notAnAttribute"
        @unknown default:
            return "default"
        }
    }
}
#endif
