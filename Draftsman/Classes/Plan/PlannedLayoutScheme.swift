//
//  PlannedLayoutScheme.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 07/02/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

public final class PlannedLayoutScheme<View: UIView>: LayoutScheme<View> {
    
    override func buildCurrent(with startedConstaints: [NSLayoutConstraint]) -> ExtractedConstraints {
        if context.applying {
            (viewInScheme as? UIViewPlanned)?.selfPlanned = true
        }
        return super.buildCurrent(with: startedConstaints)
    }
    
    public override func insert(@LayoutPlan _ layouter: () -> ViewPlan) -> Self {
        if context.usingViewPlan, context.rootContextView == viewInScheme {
            fatalError("Draftsman Error: Planned view or view controller should be managed its own content")
        }
        subPlanAccessed = true
        self.subPlan.append(contentsOf: layouter().subPlan)
        return self
    }
}
#endif
