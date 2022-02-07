//
//  PlanContext.swift
//  Draftsman
//
//  Created by Nayanda Haberty (ID) on 27/08/20.
//

import Foundation
#if canImport(UIKit)
import UIKit

final class PlanContext {
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
            let usedToBeVoid = oldValue is VoidView
            previousView = usedToBeVoid ? nil : oldValue
            rootContextView = usedToBeVoid ? rootContextView : currentView
        }
    }
    let usingViewPlan: Bool
    var rootContextController: UIViewController?
    var rootContextView: UIView
    var previousView: UIView?
    var applying: Bool = false
    
    init(delegate: PlanDelegate? = nil, rootContextView: UIView, usingViewPlan: Bool) {
        self._delegate = delegate
        self.rootContextView = rootContextView
        self.currentView = rootContextView
        self.usingViewPlan = usingViewPlan
    }
}

extension PlanContext {
    static var `default`: PlanContext { PlanContext(delegate: nil, rootContextView: VoidView(), usingViewPlan: false) }
}
#endif
