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
        let subPlan = (self as? Planned)?.viewPlan.subPlan ?? []
        return LayoutScheme(view: self, subPlan: subPlan)
    }
    
    @discardableResult
    func planContent(
        withDelegate delegate: PlanDelegate? = nil,
        _ planOption: PlanningOption = .append,
        @LayoutPlan _ layouter: () -> ViewPlan) -> [NSLayoutConstraint] {
        defer {
            notifyViewDidPlanned()
        }
        let viewPlan = layouter()
        let rootPlan = viewPlan as? RootViewPlan ?? RootViewPlan(subPlan: viewPlan.subPlan)
        rootPlan.planOption = planOption
        rootPlan.delegate = delegate
        return rootPlan.apply(for: self)
    }
}

public extension PlanConvertible where Self: UIStackView {
    
    @discardableResult
    func planStackedContent(
        withDelegate delegate: PlanDelegate? = nil,
        _ planOption: PlanningOption = .append,
        @LayoutPlan _ layouter: () -> ViewPlan) -> [NSLayoutConstraint] {
        defer {
            notifyViewDidPlanned()
        }
        let viewPlan = layouter()
        let rootPlan = RootViewPlan(
            subPlan: viewPlan.subPlan.compactMap {
                $0.isStackContent = true
                return $0
            }
        )
        rootPlan.planOption = planOption
        rootPlan.delegate = delegate
        return rootPlan.apply(for: self)
    }
}

public extension PlanConvertible where Self: UIViewController {
    
    var plan: LayoutScheme<UIView> {
        let subPlan = (self as? Planned)?.viewPlan.subPlan ?? []
        return LayoutScheme(view: view, subPlan: subPlan)
    }
    
    @discardableResult
    func planContent(
        withDelegate delegate: PlanDelegate? = nil,
        _ options: PlanningOption = .append,
        @LayoutPlan _ layouter: () -> ViewPlan) -> [NSLayoutConstraint] {
        defer {
            notifyViewDidPlanned()
        }
        return view.planContent(withDelegate: delegate, options, layouter)
    }
}
#endif
