//
//  RootViewPlan.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 07/07/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

open class RootViewPlan: SchemeCollection {
    weak var delegate: PlanDelegate?
    
    open override func build(for view: UIView) -> [NSLayoutConstraint] {
        buildAndExtractConstraint(for: view).toActivated
    }
    
    @discardableResult
    open override func apply(for view: UIView) -> [NSLayoutConstraint] {
        let constraints = buildAndExtractConstraint(for: view)
        NSLayoutConstraint.deactivate(constraints.toRemoved)
        NSLayoutConstraint.activate(constraints.toActivated)
        return constraints.toActivated
    }
    
    func buildAndExtractConstraint(for view: UIView) -> ExtractedConstraints {
        buildWithContext(for: view) {
            let constraints = buildWholeScheme(for: view)
            return extractConstraints(for: view, from: constraints)
        }
    }
    
    func buildWithContext(for view: UIView, _ builder: () -> ExtractedConstraints) -> ExtractedConstraints {
        context.currentView = view
        if context.inViewPlan {
            removeSubviewThatNotInPlan(for: view)
        }
        return builder()
    }
    
    func extractAllViewPlanIds() -> [String] {
        subPlan.reduce([]) { partialResult, scheme in
            var nextResult = partialResult
            nextResult.append(contentsOf: scheme.managedViewPlanIds)
            return nextResult
        }.unique
    }
    
    func extractConstraints(for view: UIView, from constraints: [NSLayoutConstraint]) -> ExtractedConstraints {
        let currentConstraints = view.rootViewConstraints.allConstraints
        let combinedConstraints: [NSLayoutConstraint] = constraints.compactMap { constraint in
            guard let found = currentConstraints.first(where: { $0 ~= constraint }) else {
                return constraint
            }
            found.resembling(constraint)
            return found
        }
        if context.inViewPlan {
            let viewPlanIds = extractAllViewPlanIds()
            let removedConstraints = currentConstraints.filter { constraint in
                for viewPlanId in viewPlanIds where constraint.isPartOf(viewPlanId: viewPlanId) {
                    return true
                }
                return false
            }
            return .init(toActivated: combinedConstraints, toRemoved: removedConstraints)
        }
        return .init(toActivated: combinedConstraints, toRemoved: [])
    }
}
#endif
