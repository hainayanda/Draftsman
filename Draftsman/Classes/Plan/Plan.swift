//
//  Plan.swift
//  Draftsman
//
//  Created by Nayanda Haberty (ID) on 27/08/20.
//

import Foundation
#if canImport(UIKit)
import UIKit

public protocol Plan: class {
    var plannedConstraints: [NSLayoutConstraint] { get set }
}

public protocol Planer: Plan {
    associatedtype View: UIView
    var view: View { get }
    var context: PlanContext { get }
    @discardableResult
    func planContent(_ planer: (LayoutPlan<View>) -> Void) -> Self
}
#endif
