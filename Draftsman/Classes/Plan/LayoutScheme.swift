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

// MARK: ViewScheme

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

// MARK: LayoutScheme

public final class LayoutScheme<View: UIView>: RootViewPlan, ViewScheme {
    public var viewPlanId: String?
    public var originalViewPlanId: String?
    public var isFromViewPlan: Bool = false
    public var isStackContent: Bool = false
    public var view: UIView { viewInScheme }
    var viewInScheme: View
    public var constraintBuilders: [LayoutConstraintBuilder] = []
    
    init(view: View, subPlan: [ViewScheme] = [], originalViewPlanId: String? = nil) {
        self.originalViewPlanId = originalViewPlanId
        if let originalViewPlanId = originalViewPlanId {
            subPlan.markUnmarked(with: originalViewPlanId)
        }
        self.viewInScheme = view
        super.init(subPlan: subPlan)
    }
    
    public override func apply(for view: UIView) -> [NSLayoutConstraint] {
        context.rootContextController = view.nextViewController
        if let viewPlanId = originalViewPlanId ?? viewPlanId {
            context.viewPlanId = viewPlanId
            subPlan.markUnmarked(with: viewPlanId)
        }
        context.currentView = view
        let layoutConstraints = constraintBuilders.compactMap { $0.build(for: context) }
        let extractedConstraints = buildCurrent(with: layoutConstraints)
        NSLayoutConstraint.activate(extractedConstraints.toActivated)
        NSLayoutConstraint.deactivate(extractedConstraints.toRemoved)
        return extractedConstraints.toActivated
    }
    
    override func buildAndExtractConstraint(for view: UIView) -> ExtractedConstraints {
        context.currentView = view
        let layoutConstraints = constraintBuilders.compactMap { $0.build(for: context) }
        return buildWithContext(for: view) {
            buildCurrent(with: layoutConstraints)
        }
    }
    
    public func insert(@LayoutPlan _ layouter: () -> ViewPlan) -> Self {
        subPlanAccessed = true
        self.subPlan.append(contentsOf: layouter().subPlan)
        return self
    }
    
    override func extractAllViewPlanIds() -> [String] {
        managedViewPlanIds
    }
    
    override func buildWithContext(for view: UIView, _ builder: () -> ExtractedConstraints) -> ExtractedConstraints {
        let oldViewPlan = context.viewPlanId
        defer {
            context.viewPlanId = oldViewPlan
        }
        if let viewPlanId = viewPlanId ?? originalViewPlanId {
            context.viewPlanId = viewPlanId
        }
        context.currentView = view
        if context.inViewPlan {
            removeSubviewThatNotInPlan(for: view)
        }
        return builder()
    }
    
    func buildCurrent(with startedConstaints: [NSLayoutConstraint]) -> ExtractedConstraints {
        var constraints = startedConstaints
        constraints.append(contentsOf: buildWholeScheme(for: view))
        return extractConstraints(for: view, from: constraints)
    }
}

public extension LayoutScheme where View: UIStackView {
    func insertStacked(@LayoutPlan _ layouter: () -> ViewPlan) -> Self {
        subPlanAccessed = true
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
