//
//  ViewDraft.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 06/04/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

public protocol ViewDraft: DraftComponent {
    func build(for view: UIView) -> [NSLayoutConstraint]
    @discardableResult
    func apply(to view: UIView) -> [NSLayoutConstraint]
}

public protocol ViewScheme: ViewDraft, AnyObject {
    var context: DraftContext? { get set }
    var view: UIView { get }
    func build() -> [NSLayoutConstraint]
    @discardableResult
    func apply() -> [NSLayoutConstraint]
    func insert(@LayoutDraft _ layouter: () -> ViewDraft) -> Self
    func resistVerticalExpansion(_ priority: UILayoutPriority) -> Self
    func resistHorizontalExpansion(_ priority: UILayoutPriority) -> Self
    func resistVerticalCompression(_ priority: UILayoutPriority) -> Self
    func resistHorizontalCompression(_ priority: UILayoutPriority) -> Self
}

public protocol StackScheme: ViewScheme {
    func insertStacked(@LayoutDraft _ layouter: () -> ViewDraft) -> Self
}

extension ViewScheme {
    @discardableResult
    public func build() -> [NSLayoutConstraint] {
        self.build(for: view)
    }
    
    @discardableResult
    public func apply() -> [NSLayoutConstraint] {
        self.apply(to: view)
    }
}

extension ViewScheme {
    
    public func resistVerticalExpansion(_ priority: UILayoutPriority) -> Self {
        view.setContentHuggingPriority(priority, for: .vertical)
        return self
    }
    
    public func resistHorizontalExpansion(_ priority: UILayoutPriority) -> Self {
        view.setContentHuggingPriority(priority, for: .horizontal)
        return self
    }
    
    public func resistVerticalCompression(_ priority: UILayoutPriority) -> Self {
        view.setContentCompressionResistancePriority(priority, for: .vertical)
        return self
    }
    
    public func resistHorizontalCompression(_ priority: UILayoutPriority) -> Self {
        view.setContentCompressionResistancePriority(priority, for: .horizontal)
        return self
    }
}
#endif
