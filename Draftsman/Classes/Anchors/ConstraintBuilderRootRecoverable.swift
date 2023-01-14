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
public class ConstraintBuilderRootRecoverable<Root: ViewPlanBuilder & LayoutAnchor>: ConstraintBuilder, PlanComponent {
    
    public typealias Layout = Root.Layout
    /// To avoid retain cycle
    var root: Root!
    
    @inlinable public var insertablePlans: [ViewDraft] {
        backToRoot { $0.insertablePlans }
    }
    
    init(root: Root) {
        self.root = root
    }
    
    @inlinable func build(using context: PlanContext) -> [NSLayoutConstraint] {
        fatalError("build(using:) should be overridden")
    }
    
    public func backToRoot<Return>(then doWork: (Root) -> Return) -> Return {
        // once back to root, this object will not be usable again and retain cycle is removed
        defer { root = nil }
        root.constraintBuilders.append(self)
        return doWork(root)
    }
    
    @inlinable public subscript<Property>(
        dynamicMember keyPath: KeyPath<Root, Property>) -> Property {
            backToRoot { $0[keyPath: keyPath] }
        }
}

extension ConstraintBuilderRootRecoverable where Root: ViewDraft {
    @discardableResult
    @inlinable public func insert(@LayoutPlan _ layouter: () -> ViewPlan) -> Root {
        backToRoot { $0.insert(layouter) }
    }
    
    @inlinable public func build() -> [NSLayoutConstraint] {
        backToRoot { $0.build() }
    }
    
    @discardableResult
    @inlinable public func apply() -> [NSLayoutConstraint] {
        backToRoot { $0.apply() }
    }
}

extension ConstraintBuilderRootRecoverable where Root: StackDraft {
    @discardableResult
    @inlinable public func insertStacked(@LayoutPlan _ layouter: () -> ViewPlan) -> Root {
        backToRoot { $0.insertStacked(layouter) }
    }
}

extension ConstraintBuilderRootRecoverable {
    @inlinable public func priority(_ prio: Float) -> PrioritizedAnchorRelation<Root> {
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

extension ConstraintBuilderRootRecoverable where Root: ViewDraft {
    
    @inlinable public func resistVerticalExpansion(_ priority: UILayoutPriority) -> Root {
        backToRoot { $0.resistVerticalExpansion(priority) }
    }
    
    @inlinable public func resistHorizontalExpansion(_ priority: UILayoutPriority) -> Root {
        backToRoot { $0.resistHorizontalExpansion(priority) }
    }
    
    @inlinable public func resistVerticalCompression(_ priority: UILayoutPriority) -> Root {
        backToRoot { $0.resistVerticalCompression(priority) }
    }
    
    @inlinable public func resistHorizontalCompression(_ priority: UILayoutPriority) -> Root {
        backToRoot { $0.resistHorizontalCompression(priority) }
    }
}
#endif
