//
//  PlanCompatible.swift
//  Draftsman
//
//  Created by Nayanda Haberty (ID) on 28/08/20.
//

import Foundation
#if canImport(UIKit)
import UIKit

public protocol PlanCompatible { }

public extension PlanCompatible where Self: UIView {
    
    func plan(withDelegate delegate: PlanDelegate? = nil, _ options: PlanningOption = .append, _ layouter: (LayoutPlaner<Self>) -> Void) {
        translatesAutoresizingMaskIntoConstraints = false
        planing(withDelegate: delegate, options, layouter)
    }
    
    func planContent(withDelegate delegate: PlanDelegate? = nil, _ options: PlanningOption = .append, _ layouter: (LayoutPlan<Self>) -> Void) {
        planing(withDelegate: delegate, options) { myLayout in
            myLayout.planContent(layouter)
        }
    }
    
    func planing(withDelegate delegate: PlanDelegate? = nil, _ options: PlanningOption = .append, _ layouter: (LayoutPlaner<Self>) -> Void) {
        if options.shouldRemoveOldPlannedConstraints {
            removeAllPlannedConstraints()
        }
        if options.shouldCleanAllConstraints {
            cleanSubViews()
        }
        let viewLayout = LayoutPlaner(view: self, context: .init(delegate: delegate, currentView: self))
        layouter(viewLayout)
        let constraints = viewLayout.plannedConstraints
        switch options {
        case .renew:
            let newConstraintsIds = constraints.compactMap { $0.identifier }
            mostTopParentForLayout.removeAll(identifiedConstraints: newConstraintsIds)
        default:
            break
        }
        NSLayoutConstraint.activate(constraints)
        self.notifyViewDidPlanned()
    }
    
}

public extension PlanCompatible where Self: UIViewController {
    func plan(withDelegate delegate: PlanDelegate? = nil, _ options: PlanningOption = .append, _ layouter: (LayoutPlaner<UIView>) -> Void) {
        view.plan(withDelegate: delegate, options, layouter)
        notifyViewDidPlanned()
    }
    
    func planContent(withDelegate delegate: PlanDelegate? = nil, _ options: PlanningOption = .append, _ layouter: (LayoutPlan<UIView>) -> Void) {
        view.planContent(withDelegate: delegate, options, layouter)
        notifyViewDidPlanned()
    }
}

extension UIView: PlanCompatible { }

extension UIViewController: PlanCompatible { }
#endif
