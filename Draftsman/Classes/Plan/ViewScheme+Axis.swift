//
//  ViewScheme+Axis.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 07/07/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension ViewScheme {
    
    // MARK: Top Anchor
    
    @discardableResult
    func top(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: NSLayoutYAxisAnchor,
        priority: UILayoutPriority? = nil) -> Self {
        constraintBuilders.append(
            ExplicitAxisConstraintBuilder(
                anchor: view.topAnchor,
                sign: .positive,
                relation,
                to: anchor,
                priority: priority
            )
        )
        return self
    }
    
    @discardableResult
    func top(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: RelatedAnchor<NSLayoutYAxisAnchor>,
        priority: UILayoutPriority? = nil) -> Self {
        constraintBuilders.append(
            AnonymousYAxisConstraintBuilder(
                anchor: view.topAnchor,
                sign: .positive,
                relation,
                to: anchor,
                priority: priority
            )
        )
        return self
    }
    
    @discardableResult
    func top(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: AnonymousRelation,
        priority: UILayoutPriority? = nil) -> Self {
        top(relation, to: .top(of: anchor), priority: priority)
    }
    
    // MARK: Right Anchor
    
    @discardableResult
    func left(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: NSLayoutXAxisAnchor,
        priority: UILayoutPriority? = nil) -> Self {
        constraintBuilders.append(
            ExplicitAxisConstraintBuilder(
                anchor: view.leftAnchor,
                sign: .positive,
                relation,
                to: anchor,
                priority: priority
            )
        )
        return self
    }
    
    @discardableResult
    func left(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: RelatedAnchor<NSLayoutXAxisAnchor>,
        priority: UILayoutPriority? = nil) -> Self {
        constraintBuilders.append(
            AnonymousXAxisConstraintBuilder(
                anchor: view.leftAnchor,
                sign: .positive,
                relation,
                to: anchor,
                priority: priority
            )
        )
        return self
    }
    
    @discardableResult
    func left(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: AnonymousRelation,
        priority: UILayoutPriority? = nil) -> Self {
        left(relation, to: .left(of: anchor), priority: priority)
    }
    
    // MARK: Bottom Anchor
    
    @discardableResult
    func bottom(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: NSLayoutYAxisAnchor,
        priority: UILayoutPriority? = nil) -> Self {
        constraintBuilders.append(
            ExplicitAxisConstraintBuilder(
                anchor: view.bottomAnchor,
                sign: .negative,
                relation,
                to: anchor,
                priority: priority
            )
        )
        return self
    }
    
    @discardableResult
    func bottom(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: RelatedAnchor<NSLayoutYAxisAnchor>,
        priority: UILayoutPriority? = nil) -> Self {
        constraintBuilders.append(
            AnonymousYAxisConstraintBuilder(
                anchor: view.bottomAnchor,
                sign: .negative,
                relation,
                to: anchor,
                priority: priority
            )
        )
        return self
    }
    
    @discardableResult
    func bottom(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: AnonymousRelation,
        priority: UILayoutPriority? = nil) -> Self {
        bottom(relation, to: .bottom(of: anchor), priority: priority)
    }
    
    // MARK: Right Anchor
    
    @discardableResult
    func right(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: NSLayoutXAxisAnchor,
        priority: UILayoutPriority? = nil) -> Self {
        constraintBuilders.append(
            ExplicitAxisConstraintBuilder(
                anchor: view.rightAnchor,
                sign: .negative,
                relation,
                to: anchor,
                priority: priority
            )
        )
        return self
    }
    
    @discardableResult
    func right(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: RelatedAnchor<NSLayoutXAxisAnchor>,
        priority: UILayoutPriority? = nil) -> Self {
        constraintBuilders.append(
            AnonymousXAxisConstraintBuilder(
                anchor: view.rightAnchor,
                sign: .negative,
                relation,
                to: anchor,
                priority: priority
            )
        )
        return self
    }
    
    @discardableResult
    func right(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: AnonymousRelation,
        priority: UILayoutPriority? = nil) -> Self {
        right(relation, to: .right(of: anchor), priority: priority)
    }
    
    // MARK: Center Y Anchor
    
    @discardableResult
    func centerY(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: NSLayoutYAxisAnchor,
        priority: UILayoutPriority? = nil) -> Self {
        constraintBuilders.append(
            ExplicitAxisConstraintBuilder(
                anchor: view.centerYAnchor,
                sign: .positive,
                relation,
                to: anchor,
                priority: priority
            )
        )
        return self
    }
    
    @discardableResult
    func centerY(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: RelatedAnchor<NSLayoutYAxisAnchor>,
        priority: UILayoutPriority? = nil) -> Self {
        constraintBuilders.append(
            AnonymousYAxisConstraintBuilder(
                anchor: view.centerYAnchor,
                sign: .positive,
                relation,
                to: anchor,
                priority: priority
            )
        )
        return self
    }
    
    @discardableResult
    func centerY(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: AnonymousRelation,
        priority: UILayoutPriority? = nil) -> Self {
        centerY(relation, to: .centerY(of: anchor), priority: priority)
    }
    
    // MARK: Center X Anchor
    
    @discardableResult
    func centerX(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: NSLayoutXAxisAnchor,
        priority: UILayoutPriority? = nil) -> Self {
        constraintBuilders.append(
            ExplicitAxisConstraintBuilder(
                anchor: view.centerXAnchor,
                sign: .positive,
                relation,
                to: anchor,
                priority: priority
            )
        )
        return self
    }
    
    @discardableResult
    func centerX(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: RelatedAnchor<NSLayoutXAxisAnchor>,
        priority: UILayoutPriority? = nil) -> Self {
        constraintBuilders.append(
            AnonymousXAxisConstraintBuilder(
                anchor: view.centerXAnchor,
                sign: .positive,
                relation,
                to: anchor,
                priority: priority
            )
        )
        return self
    }
    
    @discardableResult
    func centerX(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: AnonymousRelation,
        priority: UILayoutPriority? = nil) -> Self {
        centerX(relation, to: .centerX(of: anchor), priority: priority)
    }
}
#endif
