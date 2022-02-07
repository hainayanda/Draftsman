//
//  PlanComponent.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 07/07/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public protocol PlanComponent: AnyObject { }

public protocol ViewPlan: PlanComponent {
    var context: PlanContext { get set }
    var subPlan: [ViewScheme] { get }
    @discardableResult
    func build(for view: UIView) -> [NSLayoutConstraint]
    @discardableResult
    func apply(for view: UIView) -> [NSLayoutConstraint]
}

final class VoidView: UIView {
    
    override func addSubview(_ view: UIView) { }
    
    override func didMoveToSuperview() {
        removeFromSuperview()
    }
}

final class VoidViewPlan: ViewPlan {
    lazy var context: PlanContext = .default
    
    var subPlan: [ViewScheme] = []
    
    func build(for view: UIView) -> [NSLayoutConstraint] { [] }
    
    @discardableResult
    func apply(for view: UIView) -> [NSLayoutConstraint] { [] }
}

final class VoidPlanComponent: PlanComponent {
    var plan: ViewPlan { VoidViewPlan() }
}
#endif
