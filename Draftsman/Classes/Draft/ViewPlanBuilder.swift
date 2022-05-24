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
        return insertablePlans.reduce(constraintBuilders.build(using: context)) { partialResults, plan in
            view.addSubview(plan.view)
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
