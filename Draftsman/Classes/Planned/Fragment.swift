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
    
    func applyPlan(delegate: PlanDelegate?) {
        fragmentWillPlanContent()
        let scheme = PlannedLayoutScheme(view: self, subPlan: viewPlan.subPlan)
        scheme.context = PlanContext(delegate: delegate, rootContextView: self, usingViewPlan: true)
        scheme.apply()
        DispatchQueue.main.async { [weak self] in
            self?.layoutIfNeeded()
        }
        fragmentDidPlanContent()
    }
}
#endif
