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
    open var insertablePlans: [ViewDraft] { plans }
    var constraintBuilders: [ConstraintBuilder] = []
    public var context: PlanContext?
    
    public init(plans: [ViewDraft]) {
        self.plans = plans
    }
    
    open func build(for view: UIView) -> [NSLayoutConstraint] {
        let context = context ?? PlanContext(view: view)
        context.currentView = view
        let viewController = view.responderViewController
        return insertablePlans.reduce(constraintBuilders.build(using: context)) { partialResults, plan in
            if let root = context.root {
                plan.view.makeAssociated(with: root)
            }
            view.addSubview(plan.view)
            if let currentViewController = viewController,
               let subViewController = plan.view.responderViewController,
                subViewController != currentViewController {
                currentViewController.addChild(subViewController)
            }
            plan.context = context
            return partialResults.added(withContentsOf: plan.build())
        }.validUniques
    }
    
    @discardableResult
    open func apply(to view: UIView) -> [NSLayoutConstraint] {
        let constraints = build(for: view)
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
}
#endif
