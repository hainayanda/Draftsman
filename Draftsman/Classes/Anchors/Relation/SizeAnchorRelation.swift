//
//  SizeAnchorRelation.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 22/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: SizeAnchorConstant

public class SizeAnchorConstant<Root: ViewPlanBuilder & LayoutAnchor>: ConstraintBuilderRootRecoverable<Root> {
    let widthAnchor: NSLayoutDimension
    let heightAnchor: NSLayoutDimension
    let relation: NSLayoutConstraint.Relation
    let constant: CGSize
    
    init(
        root: Root,
        widthAnchor: NSLayoutDimension,
        heightAnchor: NSLayoutDimension,
        relation: NSLayoutConstraint.Relation,
        constant: CGSize) {
            self.widthAnchor = widthAnchor
            self.heightAnchor = heightAnchor
            self.relation = relation
            self.constant = constant
            super.init(root: root)
        }
    
    override func build(using context: PlanContext) -> [NSLayoutConstraint] {
        [
            widthAnchor.constraint(relation, with: constant.width),
            heightAnchor.constraint(relation, with: constant.height)
        ]
    }
}

// MARK: SizeAnchorRelation

public class SizeAnchorRelation<Root: ViewPlanBuilder & LayoutAnchor>: ConstraintBuilderRootRecoverable<Root> {
    let biWidthAnchor: DimensionAnchorPair
    let biHeightAnchor: DimensionAnchorPair
    let relation: NSLayoutConstraint.Relation
    
    init(
        root: Root,
        biWidthAnchor: DimensionAnchorPair,
        biHeightAnchor: DimensionAnchorPair,
        relation: NSLayoutConstraint.Relation) {
            self.biWidthAnchor = biWidthAnchor
            self.biHeightAnchor = biHeightAnchor
            self.relation = relation
            super.init(root: root)
        }
    
    override func build(using context: PlanContext) -> [NSLayoutConstraint] {
        [
            biWidthAnchor.build(with: context, for: relation),
            biHeightAnchor.build(with: context, for: relation)
        ]
    }
}

extension SizeAnchorRelation {
    
    public func added(by adder: CGSize) -> SizeAnchorWithConstantRelation<Root> {
        .init(parent: self, constant: adder)
    }

    public func substracted(by substractor: CGSize) -> SizeAnchorWithConstantRelation<Root> {
        .init(parent: self, constant: substractor.negative)
    }

    public func multiplied(by multiplier: CGFloat) -> SizeAnchorWithMultiplierRelation<Root> {
        .init(parent: self, multiplier: multiplier)
    }
}

// MARK: SizeAnchorWithConstantRelation

public class SizeAnchorWithConstantRelation<Root: ViewPlanBuilder & LayoutAnchor>: ConstraintBuilderRootRecoverable<Root> {
    let parent: SizeAnchorRelation<Root>
    let constant: CGSize
    
    init(parent: SizeAnchorRelation<Root>, constant: CGSize) {
        self.parent = parent
        self.constant = constant
        super.init(root: parent.root)
    }
    
    override func build(using context: PlanContext) -> [NSLayoutConstraint] {
        [
            parent.biWidthAnchor.build(with: context, for: parent.relation, constant: constant.width),
            parent.biHeightAnchor.build(with: context, for: parent.relation, constant: constant.height)
        ]
    }
}

extension SizeAnchorWithConstantRelation {
    
    public func multiplied(by multiplier: CGFloat) -> SizeAnchorWithMultiplierAndConstantRelation<Root> {
        .init(parent: parent, multiplier: multiplier, constant: constant)
    }
}

// MARK: SizeAnchorWithMultiplierRelation

public class SizeAnchorWithMultiplierRelation<Root: ViewPlanBuilder & LayoutAnchor>: ConstraintBuilderRootRecoverable<Root> {
    let parent: SizeAnchorRelation<Root>
    let multiplier: CGFloat
    
    init(parent: SizeAnchorRelation<Root>, multiplier: CGFloat) {
        self.parent = parent
        self.multiplier = multiplier
        super.init(root: parent.root)
    }
    
    override func build(using context: PlanContext) -> [NSLayoutConstraint] {
        [
            parent.biWidthAnchor.build(with: context, for: parent.relation, multiplier: multiplier),
            parent.biHeightAnchor.build(with: context, for: parent.relation, multiplier: multiplier)
        ]
    }
}

extension SizeAnchorWithMultiplierRelation {
    
    public func added(by adder: CGSize) -> SizeAnchorWithMultiplierAndConstantRelation<Root> {
        .init(parent: parent, multiplier: multiplier, constant: adder)
    }
    
    public func substracted(by substractor: CGSize) -> SizeAnchorWithMultiplierAndConstantRelation<Root> {
        .init(parent: parent, multiplier: multiplier, constant: substractor.negative)
    }
}

// MARK: SizeAnchorWithConstantAndMultiplierRelation

public class SizeAnchorWithMultiplierAndConstantRelation<Root: ViewPlanBuilder & LayoutAnchor>: ConstraintBuilderRootRecoverable<Root> {
    let parent: SizeAnchorRelation<Root>
    let multiplier: CGFloat
    let constant: CGSize
    
    init(parent: SizeAnchorRelation<Root>, multiplier: CGFloat, constant: CGSize) {
        self.parent = parent
        self.multiplier = multiplier
        self.constant = constant
        super.init(root: parent.root)
    }
    
    override func build(using context: PlanContext) -> [NSLayoutConstraint] {
        [
            parent.biWidthAnchor.build(
                with: context,
                for: parent.relation,
                multiplier: multiplier,
                constant: constant.width
            ),
            parent.biHeightAnchor.build(
                with: context,
                for: parent.relation,
                multiplier: multiplier,
                constant: constant.height
            )
        ]
    }
}
#endif
