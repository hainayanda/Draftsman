//
//  QuadAnchorRelation.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 22/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: QuadAnchorRelation

public class QuadAnchorRelation<Root: ViewPlanBuilder & LayoutAnchor>: ConstraintBuilderRootRecoverable<Root> {
    let firstBiXPair: AnchorPair<NSLayoutXAxisAnchor>
    let secondBiXPair: AnchorPair<NSLayoutXAxisAnchor>
    let firstBiYPair: AnchorPair<NSLayoutYAxisAnchor>
    let secondBiYPair: AnchorPair<NSLayoutYAxisAnchor>
    let relation: NSLayoutConstraint.Relation
    var firstBiXRelation: NSLayoutConstraint.Relation {
        firstBiXPair.offsetSign.convert(relation: relation)
    }
    var secondBiXRelation: NSLayoutConstraint.Relation {
        secondBiXPair.offsetSign.convert(relation: relation)
    }
    var firstBiYRelation: NSLayoutConstraint.Relation {
        firstBiYPair.offsetSign.convert(relation: relation)
    }
    var secondBiYRelation: NSLayoutConstraint.Relation {
        secondBiYPair.offsetSign.convert(relation: relation)
    }
    
    init(
        root: Root,
        firstBiXPair: AnchorPair<NSLayoutXAxisAnchor>,
        secondBiXPair: AnchorPair<NSLayoutXAxisAnchor>,
        firstBiYPair: AnchorPair<NSLayoutYAxisAnchor>,
        secondBiYPair: AnchorPair<NSLayoutYAxisAnchor>,
        relation: NSLayoutConstraint.Relation) {
            self.firstBiXPair = firstBiXPair
            self.secondBiXPair = secondBiXPair
            self.firstBiYPair = firstBiYPair
            self.secondBiYPair = secondBiYPair
            self.relation = relation
            super.init(root: root)
        }
    
    override func build(using context: PlanContext) -> [NSLayoutConstraint] {
        [
            firstBiXPair.build(with: context, for: firstBiXRelation),
            secondBiXPair.build(with: context, for: secondBiXRelation),
            firstBiYPair.build(with: context, for: firstBiYRelation),
            secondBiYPair.build(with: context, for: secondBiYRelation)
        ]
    }
}

extension QuadAnchorRelation {
    
    public func offset(by space: CGFloat) -> QuadAnchorWithConstantRelation<Root> {
        offsetted(using: .init(top: space, left: space, bottom: space, right: space))
    }
    
    public func inset(by space: CGFloat) -> QuadAnchorWithConstantRelation<Root> {
        insetted(using: .init(top: space, left: space, bottom: space, right: space))
    }
    
    public func offsetted(using space: EdgeOffsets) -> QuadAnchorWithConstantRelation<Root> {
        .init(parent: self, constant: space)
    }
    
    public func insetted(using space: EdgeInsets) -> QuadAnchorWithConstantRelation<Root> {
        .init(parent: self, constant: space.negative)
    }
}

// MARK: QuadAnchorWithConstantRelation

public class QuadAnchorWithConstantRelation<Root: ViewPlanBuilder & LayoutAnchor>: ConstraintBuilderRootRecoverable<Root> {
    let parent: QuadAnchorRelation<Root>
    let constant: UIEdgeInsets
    
    init(parent: QuadAnchorRelation<Root>, constant: UIEdgeInsets) {
        self.parent = parent
        self.constant = constant
        super.init(root: parent.root)
    }
    
    override func build(using context: PlanContext) -> [NSLayoutConstraint] {
        [
            parent.firstBiXPair.build(
                with: context,
                for: parent.firstBiXRelation,
                offset: constant.left
            ),
            parent.secondBiXPair.build(
                with: context,
                for: parent.secondBiXRelation,
                offset: constant.right
            ),
            parent.firstBiYPair.build(
                with: context,
                for: parent.firstBiYRelation,
                offset: constant.top
            ),
            parent.secondBiYPair.build(
                with: context,
                for: parent.secondBiYRelation,
                offset: constant.bottom
            )
        ]
    }
}
#endif
