//
//  LayoutScheme.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 07/07/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public protocol ViewScheme: ViewPlan {
    var isStackContent: Bool { get set }
    var view: UIView { get }
    var constraintBuilders: [LayoutConstraintBuilder] { get set }
    func insert(@LayoutPlan _ layouter: () -> ViewPlan) -> Self
    func buildPlan() -> [NSLayoutConstraint]
    @discardableResult
    func apply() -> [NSLayoutConstraint]
}

public extension ViewScheme {
    func buildPlan() -> [NSLayoutConstraint] {
        buildPlan(for: view)
    }
    
    @discardableResult
    func apply() -> [NSLayoutConstraint] {
        apply(for: view)
    }
}

public final class LayoutScheme<View: UIView>: SchemeCollection, ViewScheme {
    public var isStackContent: Bool = false
    public var view: UIView
    public var constraintBuilders: [LayoutConstraintBuilder] = []
    
    init(view: View, subPlan: [ViewScheme] = []) {
        self.view = view
        super.init(subPlan: subPlan)
        self.context = PlanContext(currentView: view)
    }
    
    public override func buildPlan(for view: UIView) -> [NSLayoutConstraint] {
        context.currentView = view
        view.translatesAutoresizingMaskIntoConstraints = false
        var constraints = constraintBuilders.compactMap { $0.build(for: context) }
        constraints.append(contentsOf: super.buildPlan(for: view) )
        return constraints
    }
    
    public override func apply(for view: UIView) -> [NSLayoutConstraint] {
        let constraints = buildPlan(for: view)
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
