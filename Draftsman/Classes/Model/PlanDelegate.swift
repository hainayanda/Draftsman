//
//  PlanDelegate.swift
//  Draftsman
//
//  Created by Nayanda Haberty (ID) on 27/08/20.
//

import Foundation
#if canImport(UIKit)
import UIKit

public protocol PlanDelegate: AnyObject {
    func planer(viewHaveNoSuperview view: UIView) -> UIView?
    func planer(neededViewControllerFor viewController: UIViewController) -> UIViewController?
    func planer(_ view: UIView, errorWhenPlanning error: DraftsmanError)
}

public final class DefaultPlanDelegate: PlanDelegate {
    static var shared: PlanDelegate = DefaultPlanDelegate()
}

public extension PlanDelegate {
    func planer(viewHaveNoSuperview view: UIView) -> UIView? { nil }
    func planer(_ view: UIView, errorWhenPlanning error: DraftsmanError) { }
    func planer(neededViewControllerFor viewController: UIViewController) -> UIViewController? {
        self as? UIViewController ?? (self as? UIView)?.nextViewController
    }
}
#endif
