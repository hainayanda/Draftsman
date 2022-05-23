//
//  IdentifiedAnchorRelation.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 22/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: IdentifiedAnchorRelation

public class IdentifiedAnchorRelation<Root: ViewPlanBuilder & LayoutAnchor>: ConstraintBuilderRootRecoverable<Root> {
    let identifier: String
    let parent: ConstraintBuilder
    
    init(root: Root, parent: ConstraintBuilder, identifier: String) {
        self.parent = parent
        self.identifier = identifier
        super.init(root: root)
    }
    
    override func build(using context: PlanContext) -> [NSLayoutConstraint] {
        parent.build(using: context).compactMap {
            $0.identifier = identifier
            return $0
        }
    }
}
#endif
