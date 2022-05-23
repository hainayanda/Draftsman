//
//  LayoutScheme.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 06/04/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

open class LayoutScheme<View: UIView>: ViewPlanBuilder, ViewScheme {
    public var underlyingView: View
    public var view: UIView { underlyingView }
    open override var insertablePlans: [ViewScheme] { [self] }
    var stackPlans: [ViewScheme] = []
    
    public init(view: View, plans: [ViewScheme] = []) {
        self.underlyingView = view
        super.init(plans: plans)
    }
    
    open override func build(for view: UIView) -> [NSLayoutConstraint] {
        guard view === self.view else {
            fatalError("LayoutScheme can only be applied with its own view")
        }
        let context = getContext(for: view)
        let currentConstraints = constraintBuilders.build(using: context)
        prepareBuild(for: view)
        let subviewConstraints = buildSubview(for: context)
        let stackConstraints = buildStackSubview(for: context)
        return currentConstraints
            .added(withContentsOf: subviewConstraints)
            .added(withContentsOf: stackConstraints)
            .validUniques
    }
    
    @discardableResult
    open override func apply(to view: UIView) -> [NSLayoutConstraint] {
        guard view === self.view else {
            fatalError("LayoutScheme can only be applied with its own view")
        }
        let constraints = build(for: view)
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    public func insert(@LayoutPlan _ layouter: () -> ViewPlan) -> Self {
        let viewPlan = layouter()
        plans.append(contentsOf: viewPlan.insertablePlans)
        return self
    }
    
    func getContext(for view: UIView) -> PlanContext {
        let context = context ?? PlanContext(view: view)
        context.currentView = view
        return context
    }
    
    func removeAssociatedSubview(in view: UIView) {
        guard let root = context?.root else { return }
        view.subviews.forEach { subview in
            guard subview.isPartOf(planned: root),
                  !plans.contains(where: { $0.view == subview }),
                  !stackPlans.contains(where: { $0.view == subview }) else { return }
            subview.removeFromSuperview()
        }
    }
    
    func prepareBuild(for view: UIView) {
        removeAssociatedSubview(in: view)
        if shouldNotTranslatesAutoresizingMaskIntoConstraints(for: view) {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func buildSubview(for context: PlanContext) -> [NSLayoutConstraint] {
        let view = context.currentView
        return plans.reduce([]) { partialResults, plan in
            if let root = context.root {
                plan.view.makeAssociated(with: root)
            }
            view.addSubview(plan.view)
            plan.context = context
            return partialResults.added(withContentsOf: plan.build())
        }
    }
    
    func buildStackSubview(for context: PlanContext) -> [NSLayoutConstraint] {
        let view = context.currentView
        guard let stack = view as? UIStackView else { return [] }
        return stackPlans.reduce([]) { partialResults, plan in
            if let root = context.root {
                plan.view.makeAssociated(with: root)
            }
            stack.addArrangedSubview(plan.view)
            plan.context = context
            return partialResults.added(withContentsOf: plan.build())
        }
    }
    
    func shouldNotTranslatesAutoresizingMaskIntoConstraints(for view: UIView) -> Bool {
        if view is UITableViewCell || view is UICollectionViewCell {
            return false
        }
        guard let responder = view.next else {
            return false
        }
        if responder is UIViewController {
            return false
        } else if let cell = responder as? UITableViewCell, cell.contentView == view {
            return false
        } else if let cell = responder as? UICollectionViewCell, cell.contentView == view {
            return false
        } else {
            return true
        }
    }
}

extension LayoutScheme: StackScheme where View: UIStackView {
    
    convenience init(view: View, plans: [ViewScheme] = [], stackPlans: [ViewScheme]) {
        self.init(view: view, plans: plans)
        self.stackPlans = stackPlans
    }
    
    public func insertStacked(@LayoutPlan _ layouter: () -> ViewPlan) -> Self {
        let viewPlan = layouter()
        stackPlans.append(contentsOf: viewPlan.insertablePlans)
        return self
    }
}

#endif
