//
//  PairAnchorRelation.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 22/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: PairAnchorRelation

public class PairAnchorRelation<Root: ViewPlanBuilder & LayoutAnchor, Anchor: LayoutAxisAnchor>: ConstraintBuilderRootRecoverable<Root> {
    /// could be left, top, or leading
    let firstPair: AnchorPair<Anchor>
    /// could be right, bottom, or trailing
    let secondPair: AnchorPair<Anchor>
    let relation: NSLayoutConstraint.Relation
    var firstRelation: NSLayoutConstraint.Relation {
        firstPair.offsetSign.convert(relation: relation)
    }
    var secondRelation: NSLayoutConstraint.Relation {
        secondPair.offsetSign.convert(relation: relation)
    }
    
    init(
        root: Root,
        firstPair: AnchorPair<Anchor>,
        secondPair: AnchorPair<Anchor>,
        relation: NSLayoutConstraint.Relation) {
            self.firstPair = firstPair
            self.secondPair = secondPair
            self.relation = relation
            super.init(root: root)
        }
    
    override func build(using context: PlanContext) -> [NSLayoutConstraint] {
        [
            firstPair.build(with: context, for: firstRelation),
            secondPair.build(with: context, for: secondRelation)
        ]
    }
}

extension PairAnchorRelation {
    
    public func offset(by space: CGFloat) -> PairAnchorWithConstantRelation<Root, Anchor> {
        .init(
            parent: self,
            constant: AgnosticPairConstant(firstConstant: space, secondConstant: space)
        )
    }
    
    public func inset(by space: CGFloat) -> PairAnchorWithConstantRelation<Root, Anchor> {
        .init(
            parent: self,
            constant: AgnosticPairConstant(firstConstant: -space, secondConstant: -space)
        )
    }
}

extension PairAnchorRelation where Anchor == NSLayoutXAxisAnchor {
    
    public func offsetted(using space: HorizontalOffsets) -> PairAnchorWithConstantRelation<Root, Anchor> {
        .init(parent: self, constant: space)
    }
    
    public func insetted(using space: HorizontalInsets) -> PairAnchorWithConstantRelation<Root, Anchor> {
        .init(parent: self, constant: space.negative)
    }
}

extension PairAnchorRelation where Anchor == NSLayoutYAxisAnchor {
    
    public func offsetted(using space: VerticalOffsets) -> PairAnchorWithConstantRelation<Root, Anchor> {
        .init(parent: self, constant: space)
    }
    
    public func insetted(using space: VerticalInsets) -> PairAnchorWithConstantRelation<Root, Anchor> {
        .init(parent: self, constant: space.negative)
    }
}

// MARK: PairAnchorWithConstantRelation

public class PairAnchorWithConstantRelation<Root: ViewPlanBuilder & LayoutAnchor, Anchor: LayoutAxisAnchor>: ConstraintBuilderRootRecoverable<Root> {
    let parent: PairAnchorRelation<Root, Anchor>
    let constant: PairConstant
    
    init(parent: PairAnchorRelation<Root, Anchor>, constant: PairConstant) {
        self.parent = parent
        self.constant = constant
        super.init(root: parent.root)
    }
    
    override func build(using context: PlanContext) -> [NSLayoutConstraint] {
        [
            parent.firstPair.build(
                with: context,
                for: parent.firstRelation,
                offset: constant.firstConstant
            ),
            parent.secondPair.build(
                with: context,
                for: parent.secondRelation,
                offset: constant.secondConstant
            )
        ]
    }
}
#endif
