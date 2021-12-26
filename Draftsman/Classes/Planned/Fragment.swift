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
    
    @available(*, deprecated, message: "Option will be ignored start from version 2.0.5. will be removed in next release")
    func planFragment(delegate: PlanDelegate? = nil, _ planOption: PlanningOption) {
        planFragment(delegate: delegate)
    }
    
    func planFragment(delegate: PlanDelegate? = nil) {
        applyPlan(delegate: delegate)
    }
    
    func applyPlan(delegate: PlanDelegate?) {
        fragmentWillPlanContent()
        let scheme = LayoutScheme(view: self, subPlan: viewPlan.subPlan, originalViewPlanId: self.uniqueKey)
        scheme.delegate = delegate
        scheme.apply()
        DispatchQueue.main.async { [weak self] in
            self?.layoutIfNeeded()
        }
        fragmentDidPlanContent()
    }
    
    func replanContent(delegate: PlanDelegate? = nil) {
        planFragment(delegate: delegate)
    }
}
#endif
