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
    var needPlanning: Bool { get }
    
    @LayoutPlan
    var viewPlan: ViewPlan { get }
    
    func applyPlan(delegate: PlanDelegate?)
}

public extension Planned {
    func applyPlan() {
        applyPlan(delegate: nil)
    }
}

typealias UIViewPlanned = UIView & Planned

extension UIView.AssociatedKey {
    static var needPlanning: String = "draftsman_Self_Planned"
}

public extension Planned where Self: UIView {
    
    internal(set) var needPlanning: Bool {
        get {
            (objc_getAssociatedObject(
                self, &AssociatedKey.needPlanning) as? NSNumber
            )?.boolValue ?? true
        }
        set {
            objc_setAssociatedObject(
                self, &AssociatedKey.needPlanning,
                NSNumber(value: newValue),
                .OBJC_ASSOCIATION_RETAIN
            )
        }
    }
    
    func applyPlan(delegate: PlanDelegate?) {
        let scheme = PlannedLayoutScheme(view: self, subPlan: viewPlan.subPlan)
        scheme.context = PlanContext(delegate: delegate, rootContextView: self, usingViewPlan: true)
        scheme.apply()
        DispatchQueue.main.async { [weak self] in
            self?.layoutIfNeeded()
        }
    }
}

public extension Planned where Self: UIViewController {
    
    internal(set) var needPlanning: Bool {
        get {
            (objc_getAssociatedObject(
                self,
                &UIView.AssociatedKey.needPlanning) as? NSNumber
            )?.boolValue ?? true
        }
        set {
            objc_setAssociatedObject(
                self,
                &UIView.AssociatedKey.needPlanning,
                NSNumber(value: newValue),
                .OBJC_ASSOCIATION_RETAIN
            )
        }
    }
    
    func applyPlan(delegate: PlanDelegate?) {
        let scheme = PlannedLayoutScheme(view: self.view, subPlan: viewPlan.subPlan)
        scheme.context = PlanContext(delegate: delegate, rootContextView: self.view, usingViewPlan: true)
        scheme.apply()
        DispatchQueue.main.async { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
}
#endif
