//
//  PlanContext.swift
//  Draftsman
//
//  Created by Nayanda Haberty (ID) on 27/08/20.
//

import Foundation
#if canImport(UIKit)
import UIKit

public final class PlanContext {
    weak var _delegate: PlanDelegate?
    var delegate: PlanDelegate {
        _delegate ?? DefaultPlanDelegate.shared
    }
    var currentPriority: UILayoutPriority = 999
    var mutatingPriority: UILayoutPriority {
        let newPriority: UILayoutPriority = .init(rawValue: currentPriority.rawValue - 1)
        currentPriority = newPriority
        return newPriority
    }
    var currentView: UIView {
        didSet {
            guard currentView != oldValue else { return }
            previousView = oldValue
        }
    }
    var inViewPlan: Bool {
        guard let planId: String = viewPlanId else { return false }
        return !planId.isEmpty
    }
    var rootContextController: UIViewController?
    var viewPlanId: String?
    var previousView: UIView?
    
    init(delegate: PlanDelegate? = nil, currentView: UIView, viewPlanId: String? = nil) {
        self.viewPlanId = viewPlanId
        self._delegate = delegate
        self.currentView = currentView
    }
}
#endif
