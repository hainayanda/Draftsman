//
//  ViewPlan.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 06/04/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

typealias EmptyViewPlan = [UIView]

public protocol ViewPlan: PlanComponent {
    func build(for view: UIView) -> [NSLayoutConstraint]
    @discardableResult
    func apply(to view: UIView) -> [NSLayoutConstraint]
}

public protocol ViewDraft: ViewPlan, AnyObject {
    var context: PlanContext? { get set }
    var view: UIView { get }
    func build() -> [NSLayoutConstraint]
    @discardableResult
    func apply() -> [NSLayoutConstraint]
    func insert(@LayoutPlan _ layouter: () -> ViewPlan) -> Self
    func resistVerticalExpansion(_ priority: UILayoutPriority) -> Self
    func resistHorizontalExpansion(_ priority: UILayoutPriority) -> Self
    func resistVerticalCompression(_ priority: UILayoutPriority) -> Self
    func resistHorizontalCompression(_ priority: UILayoutPriority) -> Self
    func resistSizeExpansion(_ priority: UILayoutPriority) -> Self
    func resistSizeCompression(_ priority: UILayoutPriority) -> Self
    func resistSizeAdjustment(_ priority: UILayoutPriority) -> Self
}

public protocol StackDraft: ViewDraft {
    func insertStacked(@LayoutPlan _ layouter: () -> ViewPlan) -> Self
}

extension ViewDraft {
    @discardableResult
    @inlinable public func build() -> [NSLayoutConstraint] {
        self.build(for: view)
    }
    
    @discardableResult
    @inlinable public func apply() -> [NSLayoutConstraint] {
        self.apply(to: view)
    }
}

extension ViewDraft {
    
    @inlinable public func resistVerticalExpansion(_ priority: UILayoutPriority) -> Self {
        view.setContentHuggingPriority(priority, for: .vertical)
        return self
    }
    
    @inlinable public func resistHorizontalExpansion(_ priority: UILayoutPriority) -> Self {
        view.setContentHuggingPriority(priority, for: .horizontal)
        return self
    }
    
    @inlinable public func resistVerticalCompression(_ priority: UILayoutPriority) -> Self {
        view.setContentCompressionResistancePriority(priority, for: .vertical)
        return self
    }
    
    @inlinable public func resistHorizontalCompression(_ priority: UILayoutPriority) -> Self {
        view.setContentCompressionResistancePriority(priority, for: .horizontal)
        return self
    }
    @inlinable public func resistSizeExpansion(_ priority: UILayoutPriority) -> Self {
        resistVerticalExpansion(priority).resistHorizontalExpansion(priority)
    }
    @inlinable public func resistSizeCompression(_ priority: UILayoutPriority) -> Self {
        resistVerticalCompression(priority).resistHorizontalCompression(priority)
    }
    @inlinable public func resistSizeAdjustment(_ priority: UILayoutPriority) -> Self {
        resistSizeExpansion(priority).resistSizeCompression(priority)
    }
}
#endif
