//
//  ViewPlanBuilder.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 06/04/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

open class ViewPlanBuilder: ViewPlan {
    var plans: [ViewDraft]
    var allPlans: [ViewDraft] { plans }
    open var insertablePlans: [ViewDraft] { plans }
    var constraintBuilders: [ConstraintBuilder] = []
    public var context: PlanContext?
    
    public init(plans: [ViewDraft]) {
        self.plans = plans
    }
    
    open func build(for view: UIView) -> [NSLayoutConstraint] {
        prepareBuild(for: view)
        return buildSubview(plans: plans, for: getContext(for: view)) {
            view.addSubview($0)
        }.validUniques
    }
    
    @discardableResult
    open func apply(to view: UIView) -> [NSLayoutConstraint] {
        let constraints = build(for: view)
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    func getContext(for view: UIView) -> PlanContext {
        let context = context ?? PlanContext(view: view)
        context.currentView = view
        return context
    }
    
    func removeAssociatedSubview(in view: UIView) {
        guard let root = context?.root else { return }
        view.subviews.forEach { subview in
            guard subview.isPartOf(planned: root),
                  !allPlans.contains(where: { $0.view == subview }) else { return }
            subview.removeFromSuperview()
            if let currentViewController = view.responderViewController,
                let subViewController = subview.responderViewController,
                subViewController != currentViewController {
                subViewController.removeFromParent()
            }
        }
    }
    
    func buildSubview(plans: [ViewDraft], for context: PlanContext, doAdd: (UIView) -> Void) -> [NSLayoutConstraint] {
        let viewController = context.currentViewController
        return plans.reduce([]) { partialResults, plan in
            if let root = context.root {
                plan.view.makeAssociated(with: root)
            }
            doAdd(plan.view)
            if let currentViewController = viewController,
               let subViewController = plan.view.responderViewController,
                subViewController != currentViewController {
                currentViewController.addChild(subViewController)
            }
            plan.context = context
            return partialResults.added(withContentsOf: plan.build())
        }
    }
    
    func prepareBuild(for view: UIView) {
        removeAssociatedSubview(in: view)
        if shouldNotTranslatesAutoresizingMaskIntoConstraints(for: view) {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func shouldNotTranslatesAutoresizingMaskIntoConstraints(for view: UIView) -> Bool {
        if view is UITableViewCell || view is UICollectionViewCell {
            return false
        }
        guard let responder = view.next else {
            return false
        }
        if responder is UIViewController {
            return false
        } else if let cell = responder as? UITableViewCell, cell.contentView == view {
            return false
        } else if let cell = responder as? UICollectionViewCell, cell.contentView == view {
            return false
        } else {
            return true
        }
    }
}
#endif
