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

// MARK: LayoutScheme

public class LayoutScheme<View: UIView>: RootViewPlan, ViewScheme {
    public override var context: PlanContext {
        get {
            guard let myContext = _context else {
                let newContext: PlanContext = PlanContext(delegate: nil, rootContextView: view, usingViewPlan: false)
                _context = newContext
                return newContext
            }
            return myContext
        } set {
            _context = newValue
        }
    }
    public var isStackContent: Bool = false
    public var view: UIView { viewInScheme }
    var viewInScheme: View
    public var constraintBuilders: [LayoutConstraintBuilder] = []
    
    init(view: View, subPlan: [ViewScheme] = []) {
        self.viewInScheme = view
        super.init(subPlan: subPlan)
    }
    
    public override func apply(for view: UIView) -> [NSLayoutConstraint] {
        context.applying = true
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
    
    override func buildWithContext(for view: UIView, _ builder: () -> ExtractedConstraints) -> ExtractedConstraints {
        context.currentView = view
        if context.usingViewPlan {
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
        if viewInScheme is Planned, context.usingViewPlan, context.rootContextView == viewInScheme {
            fatalError("Draftsman Error: Planned view or view controller should be managed its own content")
        }
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
