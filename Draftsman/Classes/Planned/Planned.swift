//
//  Outlined.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 07/07/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public protocol Planned {
    @LayoutPlan
    var viewPlan: ViewPlan { get }
    
    func applyPlan(delegate: PlanDelegate?)
}

public extension Planned {
    func applyPlan() {
        applyPlan(delegate: nil)
    }
}

public extension Planned where Self: UIView {
    func applyPlan(delegate: PlanDelegate?) {
        let scheme = LayoutScheme(view: self, subPlan: viewPlan.subPlan, originalViewPlanId:  self.uniqueKey)
        scheme.delegate = delegate
        scheme.apply()
        DispatchQueue.main.async { [weak self] in
            self?.layoutIfNeeded()
        }
    }
}

public extension Planned where Self: UIViewController {
    func applyPlan(delegate: PlanDelegate?) {
        let scheme = LayoutScheme(view: self.view, subPlan: viewPlan.subPlan, originalViewPlanId:  self.uniqueKey)
        scheme.delegate = delegate
        scheme.apply()
        DispatchQueue.main.async { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
}
#endif
