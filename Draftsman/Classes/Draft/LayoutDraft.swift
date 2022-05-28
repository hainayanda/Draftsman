//
//  LayoutDraft.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 06/04/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

open class LayoutDraft<View: UIView>: ViewPlanBuilder, ViewDraft {
    public var underlyingView: View
    public var view: UIView { underlyingView }
    open override var insertablePlans: [ViewDraft] { [self] }
    var stackPlans: [ViewDraft] = []
    override var allPlans: [ViewDraft] {
        plans.added(withContentsOf: stackPlans)
    }
    
    public init(view: View, plans: [ViewDraft] = []) {
        self.underlyingView = view
        super.init(plans: plans)
    }
    
    open override func build(for view: UIView) -> [NSLayoutConstraint] {
        guard view === self.view else {
            fatalError("LayoutDraft can only be applied with its own view")
        }
        let currentConstraints = constraintBuilders.build(using: getContext(for: view))
        prepareBuild(for: view)
        let subviewConstraints = buildRegularSubview(for: getContext(for: view))
        let stackConstraints = buildStackSubview(for: getContext(for: view))
        return currentConstraints
            .added(withContentsOf: subviewConstraints)
            .added(withContentsOf: stackConstraints)
            .validUniques
    }
    
    @discardableResult
    open override func apply(to view: UIView) -> [NSLayoutConstraint] {
        guard view === self.view else {
            fatalError("LayoutDraft can only be applied with its own view")
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
    
    func buildRegularSubview(for context: PlanContext) -> [NSLayoutConstraint] {
        let view = context.currentView
        return buildSubview(plans: plans, for: context) {
            view.addSubview($0)
        }
    }
    
    func buildStackSubview(for context: PlanContext) -> [NSLayoutConstraint] {
        guard let stack = context.currentView as? StackCompatible else { return [] }
        return buildSubview(plans: stackPlans, for: context) {
            stack.addArrangedSubview($0)
        }
    }
}

extension LayoutDraft: StackDraft where View: StackCompatible {
    
    convenience init(view: View, plans: [ViewDraft] = [], stackPlans: [ViewDraft]) {
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
