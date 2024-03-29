//
//  AnchorPair.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 19/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: AnchorPair

struct AnchorPair<Anchor: LayoutAxisAnchor> {
    let firstAnchor: AnchorExtractable<Anchor>
    let secondAnchor: AnchorExtractable<Anchor>
    let offsetSign: AnchorOffsetSign
    
    @inlinable func build(with context: PlanContext, for relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint {
        let first = firstAnchor.anchor(from: context)
        let second = secondAnchor.anchor(from: context)
        return first.constraint(relation, to: second)
    }
    
    @inlinable func build(with context: PlanContext, for relation: NSLayoutConstraint.Relation, offset: CGFloat) -> NSLayoutConstraint {
        let first = firstAnchor.anchor(from: context)
        let second = secondAnchor.anchor(from: context)
        return first.constraint(relation, to: second, constant: offsetSign.convert(offset: offset))
    }
}

struct DimensionAnchorPair {
    let firstAnchor: AnchorExtractable<NSLayoutDimension>
    let secondAnchor: AnchorExtractable<NSLayoutDimension>
    
    @inlinable func build(with context: PlanContext, for relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint {
        let first = firstAnchor.anchor(from: context)
        let second = secondAnchor.anchor(from: context)
        return first.constraint(relation, to: second)
    }
    
    @inlinable func build(with context: PlanContext, for relation: NSLayoutConstraint.Relation, constant: CGFloat) -> NSLayoutConstraint {
        let first = firstAnchor.anchor(from: context)
        let second = secondAnchor.anchor(from: context)
        return first.constraint(relation, to: second, constant: constant)
    }
    
    @inlinable func build(with context: PlanContext, for relation: NSLayoutConstraint.Relation, multiplier: CGFloat) -> NSLayoutConstraint {
        let first = firstAnchor.anchor(from: context)
        let second = secondAnchor.anchor(from: context)
        return first.constraint(relation, to: second, multiplier: multiplier)
    }
    
    @inlinable func build(with context: PlanContext, for relation: NSLayoutConstraint.Relation, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        let first = firstAnchor.anchor(from: context)
        let second = secondAnchor.anchor(from: context)
        return first.constraint(relation, to: second, multiplier: multiplier, constant: constant)
    }
}
#endif
