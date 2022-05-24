//
//  PrioritizedAnchorRelation.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 19/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: PrioritizedAnchorRelation

public class PrioritizedAnchorRelation<Root: ViewPlanBuilder & LayoutAnchor>: ConstraintBuilderRootRecoverable<Root> {
    let priority: UILayoutPriority
    let parent: ConstraintBuilder
    
    init(root: Root, parent: ConstraintBuilder, priority: UILayoutPriority) {
        self.parent = parent
        self.priority = priority
        super.init(root: root)
    }
    
    override func build(using context: PlanContext) -> [NSLayoutConstraint] {
        parent.build(using: context).compactMap {
            $0.priority = priority
            return $0
        }
    }
}
#endif
