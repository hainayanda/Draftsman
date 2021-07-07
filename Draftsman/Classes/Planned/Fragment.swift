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
    
    func planFragment(delegate: PlanDelegate? = nil, _ planOption: PlanningOption = .renew) {
        fragmentWillPlanContent()
        let scheme = LayoutScheme(view: self, subPlan: viewPlan.subPlan)
        scheme.context = PlanContext(delegate: delegate, currentView: self)
        scheme.apply()
        fragmentDidPlanContent()
    }
    
    func replanContent(delegate: PlanDelegate? = nil, _ planOption: PlanningOption = .renew) {
        removeAllPlannedConstraints()
        planFragment(delegate: delegate, planOption)
    }
}
#endif
