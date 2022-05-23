//
//  DraftedScheme.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 06/04/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

open class DraftedScheme<Root: Drafted, View: UIView>: LayoutScheme<View> {
    typealias PopulatedConstraints = (removed: [NSLayoutConstraint], keeped: [NSLayoutConstraint], added: [NSLayoutConstraint])
    var root: Root
    
    public init(root: Root, view: View, drafts: [ViewScheme]) {
        self.root = root
        super.init(view: view, drafts: drafts)
    }
    
    func buildAndPopulate(for view: UIView) -> PopulatedConstraints {
        guard view === self.view else {
            fatalError("DraftedScheme can only be applied with its own view")
        }
        context = context ?? DraftContext(root: root, view: view)
        let oldConstraints = root.appliedConstraints
        let constraints = super.build(for: view).validUniques
        var addedConstraints: [NSLayoutConstraint] = []
        var keepedConstraints: [NSLayoutConstraint] = []
        for constraint in constraints {
            if let sameConstraint = oldConstraints.first(where: constraint.isSameDraftsmanConstraint) {
                sameConstraint.constant = constraint.constant
                sameConstraint.priority = constraint.priority
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
            fatalError("DraftedScheme can only be applied with its own view")
        }
        let populated = buildAndPopulate(for: view)
        let activeConstraints = populated.keeped.added(withContentsOf: populated.added)
        return activeConstraints
    }
    
    @discardableResult
    open override func apply(to view: UIView) -> [NSLayoutConstraint] {
        guard view === self.view else {
            fatalError("DraftedScheme can only be applied with its own view")
        }
        let populated = buildAndPopulate(for: view)
        let activeConstraints = populated.keeped.added(withContentsOf: populated.added)
        NSLayoutConstraint.deactivate(populated.removed)
        NSLayoutConstraint.activate(activeConstraints)
        return activeConstraints
    }
}
#endif
