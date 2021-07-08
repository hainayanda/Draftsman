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
    func build() -> [NSLayoutConstraint]
    @discardableResult
    func apply() -> [NSLayoutConstraint]
}

public extension ViewScheme {
    func build() -> [NSLayoutConstraint] {
        build(for: view)
    }
    
    @discardableResult
    func apply() -> [NSLayoutConstraint] {
        apply(for: view)
    }
}

@dynamicMemberLookup
public final class LayoutScheme<View: UIView>: SchemeCollection, ViewScheme {
    public typealias LayoutSchemeBuilder<Property> = ((Property) -> LayoutScheme<View>)
    
    public var isStackContent: Bool = false
    public var view: UIView { viewInScheme }
    var viewInScheme: View
    public var constraintBuilders: [LayoutConstraintBuilder] = []
    
    init(view: View, subPlan: [ViewScheme] = []) {
        self.viewInScheme = view
        super.init(subPlan: subPlan)
        self.context = PlanContext(currentView: view)
    }
    
    public subscript<Property>(dynamicMember keyPath: WritableKeyPath<View, Property>) -> LayoutSchemeBuilder<Property> {
        // retained on purpose
        return { value in
            self.viewInScheme[keyPath: keyPath] = value
            return self
        }
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
