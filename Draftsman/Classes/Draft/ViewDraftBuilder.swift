//
//  ViewDraftBuilder.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 06/04/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

open class ViewDraftBuilder: ViewDraft {
    var drafts: [ViewScheme]
    open var insertableDrafts: [ViewScheme] { drafts }
    var constraintBuilders: [ConstraintBuilder] = []
    public var context: DraftContext?
    
    public init(drafts: [ViewScheme]) {
        self.drafts = drafts
    }
    
    open func build(for view: UIView) -> [NSLayoutConstraint] {
        let context = context ?? DraftContext(view: view)
        context.currentView = view
        return insertableDrafts.reduce(constraintBuilders.build(using: context)) { partialResults, draft in
            view.addSubview(draft.view)
            return partialResults.added(withContentsOf: draft.build())
        }.validUniques
    }
    
    @discardableResult
    open func apply(to view: UIView) -> [NSLayoutConstraint] {
        let constraints = build(for: view)
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
}
#endif
