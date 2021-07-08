//
//  Fragment.swift
//  Draftsman
//
//  Created by Nayanda Haberty (ID) on 27/08/20.
//

import Foundation
#if canImport(UIKit)
import UIKit

public protocol Fragment: Planned {
    func fragmentWillPlanContent()
    func fragmentDidPlanContent()
}

public extension Fragment {
    func fragmentWillPlanContent() { }
    func fragmentDidPlanContent() { }
}

public extension Fragment where Self: UIView {
    
    func planFragment(delegate: PlanDelegate? = nil, _ planOption: PlanningOption = .startClean) {
        fragmentWillPlanContent()
        let plan = RootViewPlan(subPlan: viewPlan.subPlan)
        plan.delegate = delegate
        plan.planOption = planOption
        plan.apply(for: self)
        fragmentDidPlanContent()
    }
    
    func replanContent(delegate: PlanDelegate? = nil, _ planOption: PlanningOption = .startClean) {
        removeAllPlannedConstraints()
        planFragment(delegate: delegate, planOption)
    }
}
#endif
