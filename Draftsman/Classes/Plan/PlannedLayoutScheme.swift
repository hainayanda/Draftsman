//
//  PlannedLayoutScheme.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 07/02/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

open class PlannedLayoutScheme<View: UIView>: LayoutScheme<View> {
    
    override func buildCurrent(with startedConstaints: [NSLayoutConstraint]) -> ExtractedConstraints {
        if context.applying {
            (viewInScheme as? UIViewPlanned)?.needPlanning = false
        }
        return super.buildCurrent(with: startedConstaints)
    }
    
    open override func insert(@LayoutPlan _ layouter: () -> ViewPlan) -> Self {
        if context.usingViewPlan, context.rootContextView == viewInScheme {
            fatalError("Draftsman Error: Planned view or view controller should be managed its own content")
        }
        subPlanAccessed = true
        self.subPlan.append(contentsOf: layouter().subPlan)
        return self
    }
}
#endif
