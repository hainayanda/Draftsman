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
    
    func plan(into link: LinkedView<Self>) -> LayoutScheme<Self> {
        let justCreated = CFGetRetainCount(self) <= 2
        if justCreated {
            self.createdInPlan = true
        }
        guard justCreated,
                let linkedView = link._wrappedValue else {
            link._wrappedValue = self
            return self.plan
        }
        return linkedView.plan
    }
    
    var plan: LayoutScheme<Self> {
        let justCreated = CFGetRetainCount(self) <= 2
        if justCreated {
            self.createdInPlan = true
        }
        if let planned = self as? Planned {
            if planned.needPlanning {
                return PlannedLayoutScheme(view: self, subPlan: planned.viewPlan.subPlan)
            } else {
                return PlannedLayoutScheme(view: self)
            }
        }
        return LayoutScheme(view: self)
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
        rootPlan.context = PlanContext(delegate: delegate, rootContextView: self, usingViewPlan: false)
        return rootPlan.apply(for: self)
    }
}

public extension PlanConvertible where Self: UIStackView {
    
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
                ($0 as? ViewScheming)?.isStackContent = true
                return $0
            }
        )
        rootPlan.context = PlanContext(delegate: delegate, rootContextView: self, usingViewPlan: false)
        return rootPlan.apply(for: self)
    }
}

public extension PlanConvertible where Self: UIViewController {
    
    var plan: LayoutScheme<UIView> {
        let justCreated = CFGetRetainCount(self) <= 2
        if justCreated {
            self.view.createdInPlan = true
        }
        if let planned = self as? Planned {
            if planned.needPlanning {
                return PlannedLayoutScheme(view: self.view, subPlan: planned.viewPlan.subPlan)
            } else {
                return PlannedLayoutScheme(view: self.view)
            }
        }
        return LayoutScheme(view: self.view)
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
