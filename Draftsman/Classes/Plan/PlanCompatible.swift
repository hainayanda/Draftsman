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
    
    @discardableResult
    func plan(
        withDelegate delegate: PlanDelegate? = nil,
        _ options: PlanningOption = .append,
        _ layouter: (LayoutPlaner<Self>) -> Void) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        return planing(withDelegate: delegate, options, layouter)
    }
    
    @discardableResult
    func planContent(
        withDelegate delegate: PlanDelegate? = nil,
        _ options: PlanningOption = .append,
        _ layouter: (LayoutPlan<Self>) -> Void) -> [NSLayoutConstraint] {
        planing(withDelegate: delegate, options) { myLayout in
            myLayout.planContent(layouter)
        }
    }
    
    internal func planing(
        withDelegate delegate: PlanDelegate? = nil,
        _ options: PlanningOption = .append,
        _ layouter: (LayoutPlaner<Self>) -> Void) -> [NSLayoutConstraint] {
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
        return constraints
    }
    
}

public extension PlanCompatible where Self: UIViewController {
    @discardableResult
    func plan(
        withDelegate delegate: PlanDelegate? = nil,
        _ options: PlanningOption = .append,
        _ layouter: (LayoutPlaner<UIView>) -> Void) -> [NSLayoutConstraint] {
        defer {
            notifyViewDidPlanned()
        }
        return view.plan(withDelegate: delegate, options, layouter)
    }
    
    @discardableResult
    func planContent(
        withDelegate delegate: PlanDelegate? = nil,
        _ options: PlanningOption = .append,
        _ layouter: (LayoutPlan<UIView>) -> Void) -> [NSLayoutConstraint] {
        defer {
            notifyViewDidPlanned()
        }
        return view.planContent(withDelegate: delegate, options, layouter)
    }
}

extension UIView: PlanCompatible { }

extension UIViewController: PlanCompatible { }
#endif
