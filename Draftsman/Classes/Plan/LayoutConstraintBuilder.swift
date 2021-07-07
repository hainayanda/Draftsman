//
//  LayoutConstraintBuilder.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 07/07/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public protocol LayoutConstraintBuilder {
    func build(for context: PlanContext) -> NSLayoutConstraint?
}

class AxisConstraintBuilder<AnchorType: AnyObject, Anchor: NSLayoutAnchor<AnchorType>, OtherAnchor>
: LayoutConstraintBuilder {
    var anchor: Anchor
    var relation: LayoutRelation<CGFloat>
    var otherAnchor: OtherAnchor
    var priority: UILayoutPriority?
    var sign: NumberSign
    
    init(
        anchor: Anchor,
        sign: NumberSign,
        _ relation: LayoutRelation<CGFloat>,
        to otherAnchor: OtherAnchor,
        priority: UILayoutPriority?) {
        self.anchor = anchor
        self.relation = relation
        self.otherAnchor = otherAnchor
        self.priority = priority
        self.sign = sign
    }
    
    func build(for context: PlanContext) -> NSLayoutConstraint? {
        nil
    }
}

final class ExplicitAxisConstraintBuilder<AnchorType: AnyObject, Anchor: NSLayoutAnchor<AnchorType>>
: AxisConstraintBuilder<AnchorType, Anchor, Anchor> {
    
    override func build(for context: PlanContext) -> NSLayoutConstraint? {
        let constraint: NSLayoutConstraint
        switch relation.convertedBy(sign: sign) {
        case .moreThanTo(let space):
            constraint = anchor.constraint(greaterThanOrEqualTo: otherAnchor, constant: space)
        case .lessThanTo(let space):
            constraint = anchor.constraint(lessThanOrEqualTo: otherAnchor, constant: space)
        case .equalTo(let space):
            constraint = anchor.constraint(equalTo: otherAnchor, constant: space)
        case .moreThan:
            constraint = anchor.constraint(greaterThanOrEqualTo: otherAnchor)
        case .lessThan:
            constraint = anchor.constraint(lessThanOrEqualTo: otherAnchor)
        case .equal:
            constraint = anchor.constraint(equalTo: otherAnchor)
        }
        constraint.priority = priority ?? context.mutatingPriority
        constraint.identifier = "draftsman_\(anchor.uniqueKey)_to_\(otherAnchor.uniqueKey)"
        return constraint
    }
}

final class AnonymousXAxisConstraintBuilder
: AxisConstraintBuilder<NSLayoutXAxisAnchor, NSLayoutXAxisAnchor, RelatedAnchor<NSLayoutXAxisAnchor>> {
    override func build(for context: PlanContext) -> NSLayoutConstraint? {
        guard let offsettedAnchor = self.otherAnchor.getOffsettedAnchor(from: context) else {
            return nil
        }
        let constant = offsettedAnchor.offset
        let otherAnchor = offsettedAnchor.anchor
        return ExplicitAxisConstraintBuilder(
            anchor: anchor,
            sign: sign,
            relation.add(offset: constant),
            to: otherAnchor,
            priority: priority
        ).build(for: context)
    }
}

final class AnonymousYAxisConstraintBuilder
: AxisConstraintBuilder<NSLayoutYAxisAnchor, NSLayoutYAxisAnchor, RelatedAnchor<NSLayoutYAxisAnchor>> {
    override func build(for context: PlanContext) -> NSLayoutConstraint? {
        guard let offsettedAnchor = self.otherAnchor.getOffsettedAnchor(from: context) else {
            return nil
        }
        let constant = offsettedAnchor.offset
        let otherAnchor = offsettedAnchor.anchor
        return ExplicitAxisConstraintBuilder(
            anchor: anchor,
            sign: sign,
            relation.add(offset: constant),
            to: otherAnchor,
            priority: priority
        ).build(for: context)
    }
}

class DimensionConstraintBuilder<OtherAnchor>: LayoutConstraintBuilder {
    typealias Anchor = NSLayoutDimension
    var anchor: Anchor
    var relation: InterRelation<OtherAnchor>
    var priority: UILayoutPriority?
    
    init(anchor: Anchor, _ relation: InterRelation<OtherAnchor>, priority: UILayoutPriority?) {
        self.anchor = anchor
        self.relation = relation
        self.priority = priority
    }
    
    func build(for context: PlanContext) -> NSLayoutConstraint? {
        nil
    }
}

final class ExplicitDimensionConstraintBuilder: DimensionConstraintBuilder<CGFloat> {
    override func build(for context: PlanContext) -> NSLayoutConstraint? {
        let constraint: NSLayoutConstraint
        let identifer: String
        switch relation {
        case .moreThanTo(let dimension):
            constraint = anchor.constraint(greaterThanOrEqualToConstant: dimension)
            identifer = "more_than_to"
        case .lessThanTo(let dimension):
            constraint = anchor.constraint(lessThanOrEqualToConstant: dimension)
            identifer = "less_than_to"
        case .equalTo(let dimension):
            constraint = anchor.constraint(equalToConstant: dimension)
            identifer = "equal_to"
        }
        constraint.priority = priority ?? context.mutatingPriority
        constraint.identifier = "draftsman_\(anchor.uniqueKey)_\(identifer)"
        return constraint
    }
}

final class RelationDimensionConstraintBuilder: DimensionConstraintBuilder<NSLayoutDimension> {
    
    var constant: CGFloat
    var multiplier: CGFloat
    
    init(
        anchor: Anchor,
        _ relation: InterRelation<NSLayoutDimension>,
        constant: CGFloat,
        multiplier: CGFloat,
        priority: UILayoutPriority?) {
        self.constant = constant
        self.multiplier = multiplier
        super.init(anchor: anchor, relation, priority: priority)
    }
    
    override func build(for context: PlanContext) -> NSLayoutConstraint? {
        let constraint: NSLayoutConstraint
        let identifer: String
        switch relation {
        case .moreThanTo(let otherAnchor):
            constraint = anchor.constraint(greaterThanOrEqualTo: otherAnchor, multiplier: multiplier, constant: constant)
            identifer = "more_than_to_\(otherAnchor.uniqueKey)"
        case .lessThanTo(let otherAnchor):
            constraint = anchor.constraint(lessThanOrEqualTo: otherAnchor, multiplier: multiplier, constant: constant)
            identifer = "less_than_to_\(otherAnchor.uniqueKey)"
        case .equalTo(let otherAnchor):
            constraint = anchor.constraint(equalTo: otherAnchor, multiplier: multiplier, constant: constant)
            identifer = "equal_to_\(otherAnchor.uniqueKey)"
        }
        constraint.priority = priority ?? context.mutatingPriority
        constraint.identifier = "draftsman_\(anchor.uniqueKey)_\(identifer)"
        return constraint
    }
}

final class AnonymousRelationDimensionConstraintBuilder
: DimensionConstraintBuilder<RelatedAnchor<NSLayoutDimension>> {
    
    var constant: CGFloat
    var multiplier: CGFloat
    
    init(
        anchor: Anchor,
        _ relation: InterRelation<RelatedAnchor<NSLayoutDimension>>,
        constant: CGFloat,
        multiplier: CGFloat,
        priority: UILayoutPriority?) {
        self.constant = constant
        self.multiplier = multiplier
        super.init(anchor: anchor, relation, priority: priority)
    }
    
    var related: RelatedAnchor<NSLayoutDimension> {
        switch relation {
        case .equalTo(let related), .lessThanTo(let related), .moreThanTo(let related):
            return related
        }
    }
    
    func convertedRelation(for context: PlanContext) -> InterRelation<NSLayoutDimension>? {
        guard let offsettedAnchor = related.getOffsettedAnchor(from: context) else {
            return nil
        }
        switch relation {
        case .equalTo:
            return .equalTo(offsettedAnchor.anchor)
        case .lessThanTo:
            return .lessThanTo(offsettedAnchor.anchor)
        case .moreThanTo:
            return .moreThanTo(offsettedAnchor.anchor)
        }
    }
    
    override func build(for context: PlanContext) -> NSLayoutConstraint? {
        guard let offsettedAnchor = self.related.getOffsettedAnchor(from: context),
              let relation = convertedRelation(for: context) else {
            return nil
        }
        return RelationDimensionConstraintBuilder(
            anchor: anchor,
            relation,
            constant: offsettedAnchor.offset,
            multiplier: multiplier,
            priority: priority
        ).build(for: context)
    }
}
#endif
