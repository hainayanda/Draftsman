//
//  RootViewPlan.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 07/07/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

final class RootViewPlan: SchemeCollection {
    public weak var delegate: PlanDelegate?
    public var planOption: PlanningOption = .startClean
    
    override func build(for view: UIView) -> [NSLayoutConstraint] {
        context = PlanContext(delegate: delegate, currentView: view)
        return super.build(for: view)
    }
    
    @discardableResult
    override func apply(for view: UIView) -> [NSLayoutConstraint] {
        if planOption.shouldCleanAllConstraints {
            view.cleanSubViews()
        }
        let constraints = build(for: view)
        if planOption.shouldRemoveOldPlannedConstraints {
            view.removeAllPlannedConstraints()
        }
        if planOption.shouldRenew {
            let newConstraintsIds = constraints.compactMap { $0.identifier }
            view.mostTopParentForLayout.removeAll(identifiedConstraints: newConstraintsIds)
        }
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
}
#endif
