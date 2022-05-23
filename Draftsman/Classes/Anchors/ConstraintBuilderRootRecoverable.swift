//
//  ConstraintBuilderRootRecoverable.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 20/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

@dynamicMemberLookup
public class ConstraintBuilderRootRecoverable<Root: ViewDraftBuilder & LayoutAnchor>: ConstraintBuilder, DraftComponent {
    
    public typealias Layout = Root.Layout
    /// To avoid retain cycle
    var root: Root!
    public var insertableDrafts: [ViewScheme] {
        backToRoot { $0.insertableDrafts }
    }
    
    init(root: Root) {
        self.root = root
    }
    
    func build(using context: DraftContext) -> [NSLayoutConstraint] {
        fatalError("build(using:) should be overridden")
    }
    
    func backToRoot<Return>(then doWork: (Root) -> Return) -> Return {
        // once back to root, this object will not be usable again and retain cycle is removed
        defer { root = nil }
        root.constraintBuilders.append(self)
        return doWork(root)
    }
    
    public subscript<Property>(
        dynamicMember keyPath: KeyPath<Root, Property>) -> Property {
            backToRoot { $0[keyPath: keyPath] }
        }
}

extension ConstraintBuilderRootRecoverable where Root: ViewScheme {
    public func insert(@LayoutDraft _ layouter: () -> ViewDraft) -> Root {
        backToRoot { $0.insert(layouter) }
    }
}

extension ConstraintBuilderRootRecoverable where Root: StackScheme {
    public func insertStacked(@LayoutDraft _ layouter: () -> ViewDraft) -> Root {
        backToRoot { $0.insertStacked(layouter) }
    }
}

extension ConstraintBuilderRootRecoverable {
    public func priority(_ prio: Float) -> PrioritizedAnchorRelation<Root> {
        backToRoot { _ in priority(UILayoutPriority(rawValue: prio)) }
    }
    
    public func priority(_ prio: UILayoutPriority) -> PrioritizedAnchorRelation<Root> {
        backToRoot {
            PrioritizedAnchorRelation(root: $0, parent: self, priority: prio)
        }
    }
}

extension ConstraintBuilderRootRecoverable {
    public func identifier(_ id: String) -> IdentifiedAnchorRelation<Root> {
        backToRoot {
            IdentifiedAnchorRelation(root: $0, parent: self, identifier: id)
        }
    }
}

extension ConstraintBuilderRootRecoverable where Root: ViewScheme {
    
    public func resistVerticalExpansion(_ priority: UILayoutPriority) -> Root {
        backToRoot { $0.resistVerticalExpansion(priority) }
    }
    
    public func resistHorizontalExpansion(_ priority: UILayoutPriority) -> Root {
        backToRoot { $0.resistHorizontalExpansion(priority) }
    }
    
    public func resistVerticalCompression(_ priority: UILayoutPriority) -> Root {
        backToRoot { $0.resistVerticalCompression(priority) }
    }
    
    public func resistHorizontalCompression(_ priority: UILayoutPriority) -> Root {
        backToRoot { $0.resistHorizontalCompression(priority) }
    }
}
#endif
