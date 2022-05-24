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
            if let currentViewController = view.responderViewController,
                let subViewController = subview.responderViewController,
                subViewController != currentViewController {
                subViewController.removeFromParent()
            }
        }
    }
    
    func prepareBuild(for view: UIView) {
        removeAssociatedSubview(in: view)
        if shouldNotTranslatesAutoresizingMaskIntoConstraints(for: view) {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func buildRegularSubview(for context: PlanContext) -> [NSLayoutConstraint] {
        let view = context.currentView
        return buildSubview(plans: plans, for: context) {
            view.addSubview($0)
        }
    }
    
    func buildStackSubview(for context: PlanContext) -> [NSLayoutConstraint] {
        guard let stack = context.currentView as? UIStackView else { return [] }
        return buildSubview(plans: stackPlans, for: context) {
            stack.addArrangedSubview($0)
        }
    }
    
    func buildSubview(plans: [ViewDraft], for context: PlanContext, doAdd: (UIView) -> Void) -> [NSLayoutConstraint] {
        let viewController = context.currentViewController
        return plans.reduce([]) { partialResults, plan in
            if let root = context.root {
                plan.view.makeAssociated(with: root)
            }
            doAdd(plan.view)
            if let currentViewController = viewController,
               let subViewController = plan.view.responderViewController,
                subViewController != currentViewController {
                currentViewController.addChild(subViewController)
            }
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

extension LayoutDraft: StackDraft where View: UIStackView {
    
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
