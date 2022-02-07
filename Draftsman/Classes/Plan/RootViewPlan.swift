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
    
    open override func build(for view: UIView) -> [NSLayoutConstraint] {
        buildAndExtractConstraint(for: view).toActivated
    }
    
    @discardableResult
    open override func apply(for view: UIView) -> [NSLayoutConstraint] {
        context.applying = true
        context.rootContextController = view.nextViewController
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
        if context.usingViewPlan {
            removeSubviewThatNotInPlan(for: view)
        }
        return builder()
    }
    
    func extractConstraints(for view: UIView, from constraints: [NSLayoutConstraint]) -> ExtractedConstraints {
        let currentConstraints = view.mostTopParentForConstraining.allConstraints
        let combinedConstraints = constraints.replaceAndResembleWithSimilar(from: currentConstraints)
        if context.usingViewPlan {
            let viewPlanId = context.rootContextView.uniqueKey
            let removedConstraints = currentConstraints.filter { $0.isPartOf(viewPlanId: viewPlanId) }
            return .init(toActivated: combinedConstraints, toRemoved: removedConstraints)
        }
        return .init(toActivated: combinedConstraints, toRemoved: [])
    }
}
#endif
