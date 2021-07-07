//
//  ViewScheme+Dimension.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 07/07/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension ViewScheme {
    
    // MARK: Width Anchor
    
    @discardableResult
    func width(
        _ relation: InterRelation<NSLayoutDimension>,
        multiplyBy multipier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: UILayoutPriority? = nil) -> Self {
        constraintBuilders.append(
            RelationDimensionConstraintBuilder(
                anchor: view.widthAnchor,
                relation,
                constant: constant,
                multiplier: multipier,
                priority: priority
            )
        )
        return self
    }
    
    @discardableResult
    func width(
        _ relation: InterRelation<RelatedAnchor<NSLayoutDimension>>,
        multiplyBy multipier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: UILayoutPriority? = nil) -> Self {
        constraintBuilders.append(
            AnonymousRelationDimensionConstraintBuilder(
                anchor: view.widthAnchor,
                relation,
                constant: constant,
                multiplier: multipier,
                priority: priority
            )
        )
        return self
    }
    
    @discardableResult
    func width(
        _ relation: InterRelation<AnonymousRelation>,
        multiplyBy multipier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: UILayoutPriority? = nil) -> Self {
        switch relation {
        case .equalTo(let relation):
            return width(.equalTo(.width(of: relation)), multiplyBy: multipier, constant: constant, priority: priority)
        case .moreThanTo(let relation):
            return width(.moreThanTo(.width(of: relation)), multiplyBy: multipier, constant: constant, priority: priority)
        case .lessThanTo(let relation):
            return width(.lessThanTo(.width(of: relation)), multiplyBy: multipier, constant: constant, priority: priority)
        }
    }
    
    @discardableResult
    func width(_ relation: InterRelation<CGFloat>, priority: UILayoutPriority? = nil) -> Self {
        constraintBuilders.append(
            ExplicitDimensionConstraintBuilder(
                anchor: view.widthAnchor,
                relation,
                priority: priority
            )
        )
        return self
    }
    
    // MARK: Height Anchor
    
    @discardableResult
    func height(
        _ relation: InterRelation<NSLayoutDimension>,
        multiplyBy multipier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: UILayoutPriority? = nil) -> Self {
        constraintBuilders.append(
            RelationDimensionConstraintBuilder(
                anchor: view.heightAnchor,
                relation,
                constant: constant,
                multiplier: multipier,
                priority: priority
            )
        )
        return self
    }
    
    @discardableResult
    func height(
        _ relation: InterRelation<RelatedAnchor<NSLayoutDimension>>,
        multiplyBy multipier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: UILayoutPriority? = nil) -> Self {
        constraintBuilders.append(
            AnonymousRelationDimensionConstraintBuilder(
                anchor: view.heightAnchor,
                relation,
                constant: constant,
                multiplier: multipier,
                priority: priority
            )
        )
        return self
    }
    
    @discardableResult
    func height(
        _ relation: InterRelation<AnonymousRelation>,
        multiplyBy multipier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: UILayoutPriority? = nil) -> Self {
        switch relation {
        case .equalTo(let relation):
            return height(.equalTo(.height(of: relation)), multiplyBy: multipier, constant: constant, priority: priority)
        case .moreThanTo(let relation):
            return height(.moreThanTo(.height(of: relation)), multiplyBy: multipier, constant: constant, priority: priority)
        case .lessThanTo(let relation):
            return height(.lessThanTo(.height(of: relation)), multiplyBy: multipier, constant: constant, priority: priority)
        }
    }
    
    @discardableResult
    func height(_ relation: InterRelation<CGFloat>, priority: UILayoutPriority? = nil) -> Self {
        constraintBuilders.append(
            ExplicitDimensionConstraintBuilder(
                anchor: view.heightAnchor,
                relation,
                priority: priority
            )
        )
        return self
    }
}
#endif
