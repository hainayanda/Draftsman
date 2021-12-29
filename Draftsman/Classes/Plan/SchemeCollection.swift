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
    var subPlanAccessed: Bool = false
    
    public init(subPlan: [ViewScheme]) {
        self.context = PlanContext(currentView: UIView())
        self.subPlan = subPlan
    }
    
    open func build(for view: UIView) -> [NSLayoutConstraint] {
        context.currentView = view
        if context.inViewPlan {
            removeSubviewThatNotInPlan(for: view)
        }
        let constraints = buildWholeScheme(for: view)
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
    
    func buildWholeScheme(for view: UIView) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        var stackIndex: Int = -1
        for plan in subPlan {
            if plan.isStackContent {
                stackIndex += 1
                constraints.append(contentsOf: buildStackScheme(plan, forView: view, at: stackIndex))
            } else {
                constraints.append(contentsOf: buildRegularScheme(plan, forView: view))
            }
        }
        return constraints
    }
    
    func buildRegularScheme(_ scheme: ViewScheme, forView view: UIView) -> [NSLayoutConstraint] {
        scheme.context = context
        let viewScheme = scheme.view
        view.addSubview(viewScheme)
        return buildSingleScheme(scheme, forView: view)
    }
    
    func buildStackScheme(_ scheme: ViewScheme, forView view: UIView, at index: Int) -> [NSLayoutConstraint] {
        guard let stack = view as? UIStackView else {
            return buildRegularScheme(scheme, forView: view)
        }
        scheme.context = context
        let viewScheme = scheme.view
        if context.inViewPlan, stack.arrangedSubviews.count > index {
            stack.insertArrangedSubview(viewScheme, at: index)
        } else {
            stack.addArrangedSubview(viewScheme)
        }
        return buildSingleScheme(scheme, forView: view)
    }
    
    func buildSingleScheme(_ scheme: ViewScheme, forView view: UIView) -> [NSLayoutConstraint] {
        let viewScheme = scheme.view
        viewScheme.translatesAutoresizingMaskIntoConstraints = false
        if let controller = view.nextViewController,
           let schemeController = viewScheme.nextViewController,
           controller != schemeController,
            !controller.children.contains(schemeController) {
            controller.addChild(schemeController)
        }
        return scheme.build()
    }
    
    func removeSubviewThatNotInPlan(for view: UIView) {
        guard subPlanAccessed else { return }
        view.subviews.forEach { subview in
            if !subPlan.contains(where: { $0.view == subview }) {
                subview.removeFromSuperview()
            }
        }
    }
}
#endif
