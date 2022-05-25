//
//  PlannedDraft.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 06/04/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

open class PlannedDraft<Root: Planned, View: UIView>: LayoutDraft<View> {
    typealias PopulatedConstraints = (removed: [NSLayoutConstraint], keeped: [NSLayoutConstraint], added: [NSLayoutConstraint])
    var root: Root
    
    public init(root: Root, view: View, plans: [ViewDraft]) {
        self.root = root
        super.init(view: view, plans: plans)
    }
    
    func buildAndPopulate(for view: UIView) -> PopulatedConstraints {
        guard view === self.view else {
            fatalError("PlannedDraft can only be applied with its own view")
        }
        context = context ?? PlanContext(root: root, view: view)
        let oldConstraints = root.appliedConstraints
        let constraints = super.build(for: view).validUniques
        var addedConstraints: [NSLayoutConstraint] = []
        var keepedConstraints: [NSLayoutConstraint] = []
        for constraint in constraints {
            if let sameConstraint = oldConstraints.first(where: constraint.isSameDraftsmanConstraint) {
                sameConstraint.constant = constraint.constant
                sameConstraint.priority = constraint.priority
                sameConstraint.identifier = constraint.identifier
                keepedConstraints.append(sameConstraint)
            } else {
                addedConstraints.append(constraint)
            }
        }
        let removedConstraints: [NSLayoutConstraint] = oldConstraints.filter { old in
            !keepedConstraints.contains(where: old.isSameDraftsmanConstraint)
        }
        return (removedConstraints, keepedConstraints, addedConstraints)
    }
    
    open override func build(for view: UIView) -> [NSLayoutConstraint] {
        guard view === self.view else {
            fatalError("PlannedDraft can only be applied with its own view")
        }
        let populated = buildAndPopulate(for: view)
        let activeConstraints = populated.keeped.added(withContentsOf: populated.added)
        return activeConstraints
    }
    
    @discardableResult
    open override func apply(to view: UIView) -> [NSLayoutConstraint] {
        guard view === self.view else {
            fatalError("PlannedDraft can only be applied with its own view")
        }
        let populated = buildAndPopulate(for: view)
        let activeConstraints = populated.keeped.added(withContentsOf: populated.added)
        NSLayoutConstraint.deactivate(populated.removed)
        NSLayoutConstraint.activate(activeConstraints)
        return activeConstraints
    }
}
#endif
