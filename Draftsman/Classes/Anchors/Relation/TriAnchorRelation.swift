//
//  TriAnchorRelation.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 22/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: TriAnchorRelation

public class TriAnchorRelation<Root: ViewPlanBuilder & LayoutAnchor, UniAnchor: LayoutAxisAnchor, BiAnchor: LayoutAxisAnchor>:  ConstraintBuilderRootRecoverable<Root> {
    let type: TriAnchorType
    let uniPair: AnchorPair<UniAnchor>
    let firstBiPair: AnchorPair<BiAnchor>
    let secondBiPair: AnchorPair<BiAnchor>
    let relation: NSLayoutConstraint.Relation
    var uniRelation: NSLayoutConstraint.Relation {
        uniPair.offsetSign.convert(relation: relation)
    }
    var firstBiRelation: NSLayoutConstraint.Relation {
        firstBiPair.offsetSign.convert(relation: relation)
    }
    var secondBiRelation: NSLayoutConstraint.Relation {
        secondBiPair.offsetSign.convert(relation: relation)
    }
    
    init(
        root: Root,
        type: TriAnchorType,
        uniPair: AnchorPair<UniAnchor>,
        firstBiPair: AnchorPair<BiAnchor>,
        secondBiPair: AnchorPair<BiAnchor>,
        relation: NSLayoutConstraint.Relation) {
            self.type = type
            self.uniPair = uniPair
            self.firstBiPair = firstBiPair
            self.secondBiPair = secondBiPair
            self.relation = relation
            super.init(root: root)
        }
    
    override func build(using context: PlanContext) -> [NSLayoutConstraint] {
        [
            uniPair.build(with: context, for: uniRelation),
            firstBiPair.build(with: context, for: firstBiRelation),
            secondBiPair.build(with: context, for: secondBiRelation)
        ]
    }
}

extension TriAnchorRelation {
    
    public func offset(by space: CGFloat) -> TriAnchorWithConstantRelation<Root, UniAnchor, BiAnchor> {
        offsetted(using: TriConstant(uniConstant: space, firstBiConstant: space, secondBiConstant: space))
    }
    
    public func inset(by space: CGFloat) -> TriAnchorWithConstantRelation<Root, UniAnchor, BiAnchor> {
        insetted(using: TriConstant(uniConstant: space, firstBiConstant: space, secondBiConstant: space))
    }
    
    public func offsetted(using space: EdgeOffsets) -> TriAnchorWithConstantRelation<Root, UniAnchor, BiAnchor> {
        switch type {
        case .allButTop:
            return offsetted(
                using: .init(
                    uniConstant: space.bottom,
                    firstBiConstant: space.left,
                    secondBiConstant: space.right
                )
            )
        case .allButLeft:
            return offsetted(
                using: .init(
                    uniConstant: space.right,
                    firstBiConstant: space.top,
                    secondBiConstant: space.bottom
                )
            )
        case .allButRight:
            return offsetted(
                using: .init(
                    uniConstant: space.left,
                    firstBiConstant: space.top,
                    secondBiConstant: space.bottom
                )
            )
        case .allButBottom:
            return offsetted(
                using: .init(
                    uniConstant: space.top,
                    firstBiConstant: space.left,
                    secondBiConstant: space.right
                )
            )
        }
    }
    
    public func insetted(using space: EdgeInsets) -> TriAnchorWithConstantRelation<Root, UniAnchor, BiAnchor> {
        switch type {
        case .allButTop:
            return insetted(
                using: .init(
                    uniConstant: space.bottom,
                    firstBiConstant: space.left,
                    secondBiConstant: space.right
                )
            )
        case .allButLeft:
            return insetted(
                using: .init(
                    uniConstant: space.right,
                    firstBiConstant: space.top,
                    secondBiConstant: space.bottom
                )
            )
        case .allButRight:
            return insetted(
                using: .init(
                    uniConstant: space.left,
                    firstBiConstant: space.top,
                    secondBiConstant: space.bottom
                )
            )
        case .allButBottom:
            return insetted(
                using: .init(
                    uniConstant: space.top,
                    firstBiConstant: space.left,
                    secondBiConstant: space.right
                )
            )
        }
    }
    
    func offsetted(using space: TriConstant) -> TriAnchorWithConstantRelation<Root, UniAnchor, BiAnchor> {
        .init(parent: self, constant: space)
    }
    
    func insetted(using space: TriConstant) -> TriAnchorWithConstantRelation<Root, UniAnchor, BiAnchor> {
        .init(parent: self, constant: space.negative)
    }
}

// MARK: TriAnchorWithConstantRelation

public class TriAnchorWithConstantRelation<Root: ViewPlanBuilder & LayoutAnchor, UniAnchor: LayoutAxisAnchor, BiAnchor: LayoutAxisAnchor>:  ConstraintBuilderRootRecoverable<Root> {
    let parent: TriAnchorRelation<Root, UniAnchor, BiAnchor>
    let constant: TriConstant
    
    init(parent: TriAnchorRelation<Root, UniAnchor, BiAnchor>, constant: TriConstant) {
        self.parent = parent
        self.constant = constant
        super.init(root: parent.root)
    }
    
    override func build(using context: PlanContext) -> [NSLayoutConstraint] {
        [
            parent.uniPair.build(
                with: context,
                for: parent.uniRelation,
                offset: constant.uniConstant
            ),
            parent.firstBiPair.build(
                with: context,
                for: parent.firstBiRelation,
                offset: constant.firstBiConstant
            ),
            parent.secondBiPair.build(
                with: context,
                for: parent.secondBiRelation,
                offset: constant.secondBiConstant
            )
        ]
    }
}
#endif
