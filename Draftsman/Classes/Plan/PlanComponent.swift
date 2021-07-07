//
//  PlanComponent.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 07/07/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public protocol PlanComponent: class { }

public protocol ViewPlan: PlanComponent {
    var context: PlanContext { get set }
    var subPlan: [ViewScheme] { get }
    @discardableResult
    func buildPlan(for view: UIView) -> [NSLayoutConstraint]
    @discardableResult
    func apply(for view: UIView) -> [NSLayoutConstraint]
}

final class VoidViewPlan: ViewPlan {
    var context: PlanContext = PlanContext(currentView: UIView())
    var subPlan: [ViewScheme] = []
    func buildPlan(for view: UIView) -> [NSLayoutConstraint] { [] }
    func apply(for view: UIView) -> [NSLayoutConstraint] { [] }
}

final class VoidPlanComponent: PlanComponent {
    var plan: ViewPlan { VoidViewPlan() }
}
#endif
