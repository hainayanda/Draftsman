//
//  SchemeCollection.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 07/07/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

open class SchemeCollection: ViewPlaning {
    private var _context: PlanContext?
    var context: PlanContext {
        get {
            guard let myContext = _context else {
                let newContext: PlanContext = createContextIfNeeded()
                _context = newContext
                return newContext
            }
            return myContext
        } set {
            _context = newValue
        }
    }
    
    public var subPlan: [ViewScheme]
    var subPlanAccessed: Bool = false
    
    init(subPlan: [ViewScheme]) {
        self.subPlan = subPlan
    }
    
    func createContextIfNeeded() -> PlanContext { .default }
    
    open func build(for view: UIView) -> [NSLayoutConstraint] {
        context.currentView = view
        if context.usingViewPlan {
            removeSubviewThatNotInPlan(for: view)
        }
        let constraints = buildWholeScheme(for: view)
        return constraints.replaceAndResembleWithSimilar(
            from: view.mostTopParentForConstraining.allConstraints
        )
    }
    
    @discardableResult
    open func apply(for view: UIView) -> [NSLayoutConstraint] {
        context.applying = true
        context.rootContextController = view.nextViewController
        let constraints = build(for: view)
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    func removeSubviewThatNotInPlan(for view: UIView) {
        guard subPlanAccessed else { return }
        view.subviews.forEach { subview in
            if !subPlan.contains(where: { $0.view == subview }) {
                subview.removeFromSuperview()
            }
        }
    }
    
    func buildWholeScheme(for view: UIView) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        var stackIndex: Int = -1
        for plan in subPlan {
            guard let scheming = plan as? ViewScheming else { continue }
            if plan.isStackContent {
                stackIndex += 1
                constraints.append(contentsOf: buildStackScheme(scheming, forView: view, at: stackIndex))
            } else {
                constraints.append(contentsOf: buildRegularScheme(scheming, forView: view))
            }
        }
        return constraints
    }
    
    private func buildRegularScheme(_ scheme: ViewScheming, forView view: UIView) -> [NSLayoutConstraint] {
        scheme.context = context
        let viewScheme = scheme.view
        view.addSubview(viewScheme)
        return buildSingleScheme(scheme, forView: view)
    }
    
    private func buildStackScheme(_ scheme: ViewScheming, forView view: UIView, at index: Int) -> [NSLayoutConstraint] {
        guard let stack = view as? UIStackView else {
            return buildRegularScheme(scheme, forView: view)
        }
        scheme.context = context
        let viewScheme = scheme.view
        if context.usingViewPlan, stack.arrangedSubviews.count > index {
            stack.insertArrangedSubview(viewScheme, at: index)
        } else {
            stack.addArrangedSubview(viewScheme)
        }
        return buildSingleScheme(scheme, forView: view)
    }
    
    private func buildSingleScheme(_ scheme: ViewScheming, forView view: UIView) -> [NSLayoutConstraint] {
        let viewScheme = scheme.view
        viewScheme.translatesAutoresizingMaskIntoConstraints = false
        viewScheme.ifRootOfController { schemeController in
            guard let controller = context.rootContextController,
                    controller != schemeController,
                  !controller.children.contains(schemeController) else {
                      return
                  }
            controller.addChild(schemeController)
        }
        return scheme.build()
    }
}
#endif
