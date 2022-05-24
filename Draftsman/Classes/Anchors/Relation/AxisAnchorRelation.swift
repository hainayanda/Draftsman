//
//  AxisAnchorRelation.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 22/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: AxisAnchorRelation

public class AxisAnchorRelation<Root: ViewPlanBuilder & LayoutAnchor>: ConstraintBuilderRootRecoverable<Root> {
    let xPair: AnchorPair<NSLayoutXAxisAnchor>
    let yPair: AnchorPair<NSLayoutYAxisAnchor>
    let relation: NSLayoutConstraint.Relation
    var xRelation: NSLayoutConstraint.Relation {
        xPair.offsetSign.convert(relation: relation)
    }
    var yRelation: NSLayoutConstraint.Relation {
        yPair.offsetSign.convert(relation: relation)
    }
    
    init(
        root: Root,
        xPair: AnchorPair<NSLayoutXAxisAnchor>,
        yPair: AnchorPair<NSLayoutYAxisAnchor>,
        relation: NSLayoutConstraint.Relation) {
            self.xPair = xPair
            self.yPair = yPair
            self.relation = relation
            super.init(root: root)
        }
    
    override func build(using context: PlanContext) -> [NSLayoutConstraint] {
        [
            xPair.build(with: context, for: xRelation),
            yPair.build(with: context, for: yRelation)
        ]
    }
}

extension AxisAnchorRelation {
    
    public func offset(by space: CGFloat) -> AxisAnchorWithConstantRelation<Root> {
        .init(parent: self, constant: CGPoint(x: space, y: space))
    }
    
    public func inset(by space: CGFloat) -> AxisAnchorWithConstantRelation<Root> {
        .init(parent: self, constant: CGPoint(x: -space, y: -space))
    }
    
    public func offsetted(using space: AxisOffsets) -> AxisAnchorWithConstantRelation<Root> {
        .init(parent: self, constant: space)
    }
    
    public func insetted(using space: AxisInsets) -> AxisAnchorWithConstantRelation<Root> {
        .init(parent: self, constant: space.negative)
    }
}

// MARK: AxisAnchorWithConstantRelation

public class AxisAnchorWithConstantRelation<Root: ViewPlanBuilder & LayoutAnchor>: ConstraintBuilderRootRecoverable<Root> {
    let parent: AxisAnchorRelation<Root>
    let constant: PairConstant
    
    init(parent: AxisAnchorRelation<Root>, constant: PairConstant) {
        self.parent = parent
        self.constant = constant
        super.init(root: parent.root)
    }
    
    override func build(using context: PlanContext) -> [NSLayoutConstraint] {
        [
            parent.xPair.build(with: context, for: parent.xRelation, offset: constant.firstConstant),
            parent.yPair.build(with: context, for: parent.yRelation, offset: constant.secondConstant)
        ]
    }
}
#endif
