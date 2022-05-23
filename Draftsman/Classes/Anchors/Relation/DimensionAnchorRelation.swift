//
//  DimensionAnchorRelation.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 22/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: DimensionAnchorConstant

public class DimensionAnchorConstant<Root: ViewPlanBuilder & LayoutAnchor>: ConstraintBuilderRootRecoverable<Root> {
    let anchor: AnchorExtractable<NSLayoutDimension>
    let relation: NSLayoutConstraint.Relation
    let constant: CGFloat
    
    init(
        root: Root,
        anchor: AnchorExtractable<NSLayoutDimension>,
        relation: NSLayoutConstraint.Relation,
        constant: CGFloat) {
            self.anchor = anchor
            self.relation = relation
            self.constant = constant
            super.init(root: root)
        }
    
    override func build(using context: PlanContext) -> [NSLayoutConstraint] {
        [
            anchor.anchor(from: context).constraint(relation, with: constant)
        ]
    }
}

// MARK: DimensionAnchorRelation

public class DimensionAnchorRelation<Root: ViewPlanBuilder & LayoutAnchor>: ConstraintBuilderRootRecoverable<Root> {
    let firstAnchor: AnchorExtractable<NSLayoutDimension>
    let secondAnchor: AnchorExtractable<NSLayoutDimension>
    let relation: NSLayoutConstraint.Relation
    
    init(
        root: Root,
        firstAnchor: AnchorExtractable<NSLayoutDimension>,
        secondAnchor: AnchorExtractable<NSLayoutDimension>,
        relation: NSLayoutConstraint.Relation) {
            self.firstAnchor = firstAnchor
            self.secondAnchor = secondAnchor
            self.relation = relation
            super.init(root: root)
        }
    
    override func build(using context: PlanContext) -> [NSLayoutConstraint] {
        [
            firstAnchor.anchor(from: context).constraint(relation, to: secondAnchor.anchor(from: context))
        ]
    }
}

extension DimensionAnchorRelation {
    
    public func added(by adder: CGFloat) -> DimensionAnchorWithConstantRelation<Root> {
        .init(parent: self, constant: adder)
    }
    
    public func substracted(by substractor: CGFloat) -> DimensionAnchorWithConstantRelation<Root> {
        .init(parent: self, constant: -substractor)
    }
    
    public func multiplied(by multiplier: CGFloat) -> DimensionAnchorWithMultiplierRelation<Root> {
        .init(parent: self, multiplier: multiplier)
    }
}

// MARK: DimensionAnchorWithConstantRelation

public class DimensionAnchorWithConstantRelation<Root: ViewPlanBuilder & LayoutAnchor>: ConstraintBuilderRootRecoverable<Root> {
    let parent: DimensionAnchorRelation<Root>
    let constant: CGFloat
    
    init(parent: DimensionAnchorRelation<Root>, constant: CGFloat) {
        self.parent = parent
        self.constant = constant
        super.init(root: parent.root)
    }
    
    override func build(using context: PlanContext) -> [NSLayoutConstraint] {
        [
            parent.firstAnchor.anchor(from: context).constraint(
                parent.relation,
                to: parent.secondAnchor.anchor(from: context),
                constant: constant
            )
        ]
    }
}

extension DimensionAnchorWithConstantRelation {
    
    public func multiplied(by multiplier: CGFloat) -> DimensionAnchorWithMultiplierAndConstantRelation<Root> {
        .init(parent: parent, multiplier: multiplier, constant: constant)
    }
}

// MARK: DimensionAnchorWithMultiplierRelation

public class DimensionAnchorWithMultiplierRelation<Root: ViewPlanBuilder & LayoutAnchor>: ConstraintBuilderRootRecoverable<Root> {
    let parent: DimensionAnchorRelation<Root>
    let multiplier: CGFloat
    
    init(parent: DimensionAnchorRelation<Root>, multiplier: CGFloat) {
        self.parent = parent
        self.multiplier = multiplier
        super.init(root: parent.root)
    }
    
    override func build(using context: PlanContext) -> [NSLayoutConstraint] {
        [
            parent.firstAnchor.anchor(from: context).constraint(
                parent.relation,
                to: parent.secondAnchor.anchor(from: context),
                multiplier: multiplier
            )
        ]
    }
}

extension DimensionAnchorWithMultiplierRelation {
    
    public func added(by adder: CGFloat) -> DimensionAnchorWithMultiplierAndConstantRelation<Root> {
        .init(parent: parent, multiplier: multiplier, constant: adder)
    }
    
    public func substracted(by substractor: CGFloat) -> DimensionAnchorWithMultiplierAndConstantRelation<Root> {
        .init(parent: parent, multiplier: multiplier, constant: -substractor)
    }
}

// MARK: DimensionAnchorWithConstantAndMultiplierRelation

public class DimensionAnchorWithMultiplierAndConstantRelation<Root: ViewPlanBuilder & LayoutAnchor>: ConstraintBuilderRootRecoverable<Root> {
    let parent: DimensionAnchorRelation<Root>
    let multiplier: CGFloat
    let constant: CGFloat
    
    init(parent: DimensionAnchorRelation<Root>, multiplier: CGFloat, constant: CGFloat) {
        self.parent = parent
        self.multiplier = multiplier
        self.constant = constant
        super.init(root: parent.root)
    }
    
    override func build(using context: PlanContext) -> [NSLayoutConstraint] {
        [
            parent.firstAnchor.anchor(from: context).constraint(
                parent.relation,
                to: parent.secondAnchor.anchor(from: context),
                multiplier: multiplier,
                constant: constant
            )
        ]
    }
}
#endif
