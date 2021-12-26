//
//  PlanCompatible.swift
//  Draftsman
//
//  Created by Nayanda Haberty (ID) on 28/08/20.
//

import Foundation
#if canImport(UIKit)
import UIKit

public protocol PlanConvertible: PlanComponent {
    var scheme: ViewScheme { get }
}

extension UIView: PlanConvertible {
    public var scheme: ViewScheme {
        plan
    }
}

extension UIViewController: PlanConvertible {
    public var scheme: ViewScheme {
        plan
    }
}

public extension PlanConvertible where Self: UIView {
    
    var plan: LayoutScheme<Self> {
        guard let planned = self as? Planned else {
            return LayoutScheme(view: self)
        }
        return LayoutScheme(view: self, subPlan: planned.viewPlan.subPlan, originalViewPlanId:  self.uniqueKey)
    }
    
    @discardableResult
    @available(*, deprecated, message: "Option will be ignored start from version 2.0.5. will be removed in next release")
    func planContent(
    withDelegate delegate: PlanDelegate? = nil,
    _ planOption: PlanningOption,
    @LayoutPlan _ layouter: () -> ViewPlan) -> [NSLayoutConstraint] {
        planContent(withDelegate: delegate, layouter)
    }
    
    @discardableResult
    func planContent(
    withDelegate delegate: PlanDelegate? = nil,
    @LayoutPlan _ layouter: () -> ViewPlan) -> [NSLayoutConstraint] {
        defer {
            DispatchQueue.main.async { [weak self] in
                self?.layoutIfNeeded()
            }
            notifyViewDidPlanned()
        }
        let viewPlan = layouter()
        let rootPlan = viewPlan as? RootViewPlan ?? RootViewPlan(subPlan: viewPlan.subPlan)
        rootPlan.delegate = delegate
        return rootPlan.apply(for: self)
    }
}

public extension PlanConvertible where Self: UIStackView {
    
    @discardableResult
    @available(*, deprecated, message: "Option will be ignored start from version 2.0.5. will be removed in next release")
    func planStackedContent(
    withDelegate delegate: PlanDelegate? = nil,
    _ planOption: PlanningOption,
    @LayoutPlan _ layouter: () -> ViewPlan) -> [NSLayoutConstraint] {
        planStackedContent(withDelegate: delegate, layouter)
    }
    
    @discardableResult
    func planStackedContent(
    withDelegate delegate: PlanDelegate? = nil,
    @LayoutPlan _ layouter: () -> ViewPlan) -> [NSLayoutConstraint] {
        defer {
            DispatchQueue.main.async { [weak self] in
                self?.layoutIfNeeded()
            }
            notifyViewDidPlanned()
        }
        let viewPlan = layouter()
        let rootPlan = RootViewPlan(
            subPlan: viewPlan.subPlan.compactMap {
                $0.isStackContent = true
                return $0
            }
        )
        rootPlan.delegate = delegate
        return rootPlan.apply(for: self)
    }
}

public extension PlanConvertible where Self: UIViewController {
    
    var plan: LayoutScheme<UIView> {
        guard let planned = self as? Planned else {
            return LayoutScheme(view: view)
        }
        return LayoutScheme(view: self.view, subPlan: planned.viewPlan.subPlan, originalViewPlanId:  self.uniqueKey)
    }
    
    @discardableResult
    @available(*, deprecated, message: "Option will be ignored start from version 2.0.5. will be removed in next release")
    func planContent(
    withDelegate delegate: PlanDelegate? = nil,
    _ planOption: PlanningOption,
    @LayoutPlan _ layouter: () -> ViewPlan) -> [NSLayoutConstraint] {
        planContent(withDelegate: delegate, layouter)
    }
    
    @discardableResult
    func planContent(
    withDelegate delegate: PlanDelegate? = nil,
    @LayoutPlan _ layouter: () -> ViewPlan) -> [NSLayoutConstraint] {
        defer {
            notifyViewDidPlanned()
        }
        return view.planContent(withDelegate: delegate, layouter)
    }
}
#endif
