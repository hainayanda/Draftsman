//
//  LayoutScheme.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 07/07/21.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Builder

public protocol ViewScheme: ViewPlan {
    var originalViewPlanId: String? { get set }
    var viewPlanId: String? { get set }
    var managedViewPlanIds: [String] { get }
    var isStackContent: Bool { get set }
    var view: UIView { get }
    var constraintBuilders: [LayoutConstraintBuilder] { get set }
    func insert(@LayoutPlan _ layouter: () -> ViewPlan) -> Self
    func build() -> [NSLayoutConstraint]
    @discardableResult
    func apply() -> [NSLayoutConstraint]
}

public extension ViewScheme {
    var managedViewPlanIds: [String] {
        var start: [String] = []
        if let originalPlanId = originalViewPlanId {
            start.append(originalPlanId)
        }
        if let viewPlanId = viewPlanId {
            start.append(viewPlanId)
        }
        let allPlanIds = subPlan.reduce(start) { partialResult, scheme in
            var nextResult = partialResult
            nextResult.append(contentsOf: scheme.managedViewPlanIds)
            return nextResult
        }
        return allPlanIds.unique
    }
    
    func build() -> [NSLayoutConstraint] {
        build(for: view)
    }
    
    @discardableResult
    func apply() -> [NSLayoutConstraint] {
        apply(for: view)
    }
}

public final class LayoutScheme<View: UIView>: RootViewPlan, ViewScheme {
    public var viewPlanId: String?
    public var originalViewPlanId: String?
    public var isFromViewPlan: Bool = false
    public var isStackContent: Bool = false
    public var view: UIView { viewInScheme }
    var viewInScheme: View
    public var constraintBuilders: [LayoutConstraintBuilder] = []
    
    init(view: View, subPlan: [ViewScheme] = [], inViewPlan: Bool = false) {
        self.viewInScheme = view
        super.init(subPlan: subPlan, inViewPlan: inViewPlan)
    }
    
    public override func build(for view: UIView) -> [NSLayoutConstraint] {
        context.currentView = view
        var constraints = constraintBuilders.compactMap { $0.build(for: context) }
        constraints.append(contentsOf: super.build(for: view) )
        return constraints
    }
    
    @discardableResult
    public override func apply(for view: UIView) -> [NSLayoutConstraint] {
        let constraints = build(for: view)
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    public func insert(@LayoutPlan _ layouter: () -> ViewPlan) -> Self {
        self.subPlan.append(contentsOf: layouter().subPlan)
        return self
    }
}

public extension LayoutScheme where View: UIStackView {
    func insertStacked(@LayoutPlan _ layouter: () -> ViewPlan) -> Self {
        self.subPlan.append(
            contentsOf:
                layouter().subPlan.compactMap {
                    $0.isStackContent = true
                    return $0
                }
        )
        return self
    }
}
#endif
