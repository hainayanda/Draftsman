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
    
    public init(subPlan: [ViewScheme], inViewPlan: Bool = false) {
        self.context = PlanContext(currentView: UIView(), inViewPlan: inViewPlan)
        self.subPlan = subPlan
    }
    
    open func build(for view: UIView) -> [NSLayoutConstraint] {
        context.currentView = view
        if context.inViewPlan {
            removeSubviewThatNotInPlan(for: view)
        }
        let constraints: [NSLayoutConstraint] = subPlan.reduce([]) { partialResult, scheme in
            var nextResult = partialResult
            nextResult.append(contentsOf: buildScheme(scheme, forView: view))
            return nextResult
        }
        return constraints
    }
    
    @discardableResult
    open func apply(for view: UIView) -> [NSLayoutConstraint] {
        let constraints = build(for: view)
        let extracted = extractConstraintToRemoveAndToActivate(for: view, withNewConstraints: constraints)
        if context.inViewPlan {
            NSLayoutConstraint.deactivate(extracted.toRemoved)
        }
        NSLayoutConstraint.activate(extracted.toActivated)
        return extracted.toActivated
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
        view.bringSubviewToFront(viewScheme)
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
    
    func extractConstraintToRemoveAndToActivate(
        for view: UIView,
        withNewConstraints newConstraints: [NSLayoutConstraint]) -> (toRemoved: [NSLayoutConstraint], toActivated: [NSLayoutConstraint]) {
            var oldDraftsmanConstraints = view.allDraftsmanConstraints
            var toActivate: [NSLayoutConstraint] = []
            for constraint in newConstraints {
                var removeIndex: Int?
                for (index, oldConstraint) in oldDraftsmanConstraints.enumerated() where oldConstraint ~= constraint {
                    oldConstraint.resembling(constraint)
                    toActivate.append(oldConstraint)
                    removeIndex = index
                    break
                }
                if let removeIndex = removeIndex {
                    oldDraftsmanConstraints.remove(at: removeIndex)
                } else {
                    toActivate.append(constraint)
                }
            }
            return (toRemoved: oldDraftsmanConstraints, toActivated: toActivate)
        }
}
#endif
