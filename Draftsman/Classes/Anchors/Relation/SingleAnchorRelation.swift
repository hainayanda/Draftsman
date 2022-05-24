//
//  SingleAnchorRelation.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 22/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: SingleAnchorRelation

public class SingleAnchorRelation<Root: ViewPlanBuilder & LayoutAnchor, Anchor: LayoutAxisAnchor>: ConstraintBuilderRootRecoverable<Root> {
    let firstAnchor: AnchorExtractable<Anchor>
    let secondAnchor: AnchorExtractable<Anchor>
    let relation: NSLayoutConstraint.Relation
    let offsetSign: AnchorOffsetSign
    
    init(root: Root, firstAnchor: AnchorExtractable<Anchor>, secondAnchor: AnchorExtractable<Anchor>, relation: NSLayoutConstraint.Relation, offsetSign: AnchorOffsetSign) {
        self.firstAnchor = firstAnchor
        self.secondAnchor = secondAnchor
        self.relation = offsetSign.convert(relation: relation)
        self.offsetSign = offsetSign
        super.init(root: root)
    }
    
    override func build(using context: PlanContext) -> [NSLayoutConstraint] {
        let first = firstAnchor.anchor(from: context)
        let second = secondAnchor.anchor(from: context)
        return [first.constraint(relation, to: second)]
    }
}

extension SingleAnchorRelation {
    
    public func offset(by space: CGFloat) -> SingleAnchorWithConstantRelation<Root, Anchor> {
        constant(space)
    }
    
    public func inset(by space: CGFloat) -> SingleAnchorWithConstantRelation<Root, Anchor> {
        constant(-space)
    }
    
    public func constant(_ space: CGFloat) -> SingleAnchorWithConstantRelation<Root, Anchor> {
        .init(parent: self, constant: space)
    }
}

// MARK: SingleAnchorWithConstantRelation

public class SingleAnchorWithConstantRelation<Root: ViewPlanBuilder & LayoutAnchor, Anchor: LayoutAxisAnchor>: ConstraintBuilderRootRecoverable<Root> {
    let parent: SingleAnchorRelation<Root, Anchor>
    let constant: CGFloat
    
    init(parent: SingleAnchorRelation<Root, Anchor>, constant: CGFloat) {
        self.parent = parent
        self.constant = constant
        super.init(root: parent.root)
    }
    
    override func build(using context: PlanContext) -> [NSLayoutConstraint] {
        let first = parent.firstAnchor.anchor(from: context)
        let second = parent.secondAnchor.anchor(from: context)
        let relation = parent.relation
        let constant = parent.offsetSign.convert(offset: constant)
        return [
            first.constraint(relation, to: second, constant: constant)
        ]
    }
}
#endif
