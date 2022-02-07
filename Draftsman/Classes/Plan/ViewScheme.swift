//
//  ViewScheme.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 07/02/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: ViewScheme

protocol ViewScheming: ViewScheme, ViewPlaning {
    var constraintBuilders: [LayoutConstraintBuilder] { get set }
    var isStackContent: Bool { get set }
}

public protocol ViewScheme: ViewPlan {
    var view: UIView { get }
    var isStackContent: Bool { get }
    func insert(@LayoutPlan _ layouter: () -> ViewPlan) -> Self
    func build() -> [NSLayoutConstraint]
    @discardableResult
    func apply() -> [NSLayoutConstraint]
}

public protocol StackScheme: ViewScheme {
    func insertStacked(@LayoutPlan _ layouter: () -> ViewPlan) -> Self
}

public extension ViewScheme {
    
    func build() -> [NSLayoutConstraint] {
        build(for: view)
    }
    
    @discardableResult
    func apply() -> [NSLayoutConstraint] {
        apply(for: view)
    }
}
#endif
