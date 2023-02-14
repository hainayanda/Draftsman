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
    
    public init(root: Root, view: View, plans: [ViewDraft], stackPlans: [ViewDraft] = []) {
        self.root = root
        super.init(view: view, plans: plans, stackPlans: stackPlans)
    }
    
    func buildAndPopulate(for view: UIView) -> PopulatedConstraints {
        guard view === self.view else {
            fatalError("PlannedDraft can only be applied with its own view")
        }
        context = context ?? PlanContext(root: root, view: view)
        let oldConstraints = root.appliedConstraints
        let constraints = super.build(for: view)
        let oldConstraintsGrouped = oldConstraints.groupedByDraftsmanIdentifier()
        var keepedConstraintsGrouped: [String: NSLayoutConstraint] = [:]
        let addedConstraints = constraints.filter {
            guard let draftsmanIdentifier = $0.draftsmanIdentifier else {
                return false
            }
            guard let sameConstraint = oldConstraintsGrouped[draftsmanIdentifier] else {
                return true
            }
            sameConstraint.copyValue(from: $0)
            keepedConstraintsGrouped[draftsmanIdentifier] = sameConstraint
            return false
        }
        let removedConstraints = oldConstraints.filter {
            guard let draftsmanIdentifier = $0.draftsmanIdentifier else { return true }
            return keepedConstraintsGrouped[draftsmanIdentifier] == nil
        }
        return (removedConstraints, Array(keepedConstraintsGrouped.values), addedConstraints)
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
