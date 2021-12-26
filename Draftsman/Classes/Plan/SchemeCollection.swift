//
//  SchemeCollection.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 07/07/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

open class SchemeCollection: ViewPlan {
    public var context: PlanContext
    public var subPlan: [ViewScheme]
    
    public init(subPlan: [ViewScheme]) {
        self.context = PlanContext(currentView: UIView())
        self.subPlan = subPlan
    }
    
    open func build(for view: UIView) -> [NSLayoutConstraint] {
        context.currentView = view
        if context.inViewPlan {
            removeSubviewThatNotInPlan(for: view)
        }
        let constraints: [NSLayoutConstraint] = subPlan.reduce([]) { partialResult, scheme in
            var nextConstraints = buildScheme(scheme, forView: view)
            nextConstraints.append(contentsOf: partialResult)
            return nextConstraints
        }
        return combinedWithCurrentConstraints(for: view, toCombined: constraints)
    }
    
    @discardableResult
    open func apply(for view: UIView) -> [NSLayoutConstraint] {
        let constraints = build(for: view)
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    func combinedWithCurrentConstraints(for view: UIView, toCombined: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        let currentConstraints = view.mostTopView.allConstraints
        let combinedConstraints: [NSLayoutConstraint] = toCombined.compactMap { constraint in
            guard let found = currentConstraints.first(where: { $0 ~= constraint }) else {
                return constraint
            }
            found.resembling(constraint)
            return found
        }
        return combinedConstraints
    }
    
    func buildScheme(_ scheme: ViewScheme, forView view: UIView) -> [NSLayoutConstraint] {
        scheme.context = context
        let viewScheme = scheme.view
        viewScheme.translatesAutoresizingMaskIntoConstraints = false
        if let stack = view as? UIStackView, scheme.isStackContent {
            if stack.arrangedSubviews.contains(viewScheme) {
                viewScheme.removeFromSuperview()
            }
            stack.addArrangedSubview(viewScheme)
        } else {
            view.addSubview(viewScheme)
        }
        if let controller = view.nextViewController,
           let schemeController = viewScheme.nextViewController,
           controller != schemeController {
            controller.addChild(schemeController)
        }
        return scheme.build()
    }
    
    func removeSubviewThatNotInPlan(for view: UIView) {
        view.subviews.forEach { subview in
            if !subPlan.contains(where: { $0.view == subview }) {
                subview.removeFromSuperview()
            }
        }
    }
}
#endif
