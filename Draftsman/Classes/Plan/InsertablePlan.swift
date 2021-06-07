//
//  InsertablePlan.swift
//  Draftsman
//
//  Created by Nayanda Haberty (ID) on 27/08/20.
//

import Foundation
#if canImport(UIKit)
import UIKit

public protocol InsertablePlan: class {
    var fittedPlans: [Plan] { get set }
    var context: PlanContext { get }
    @discardableResult
    func fit<V: UIView>(_ view: V) -> LayoutPlaner<V>
    @discardableResult
    func fit(_ viewController: UIViewController) -> LayoutPlaner<UIView>
}

public protocol InsertableViewPlan: InsertablePlan {
    associatedtype View: UIView
    var view: View { get }
}

public extension InsertableViewPlan where View: UIStackView {
    @discardableResult
    func fitStacked<V>(_ view: V) -> LayoutPlaner<V> where V : UIView {
        let possibleFragmentView = view as? FragmentView
        possibleFragmentView?.inPlanning = true
        defer {
            possibleFragmentView?.inPlanning = false
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addArrangedSubview(view)
        let plan = LayoutPlaner(view: view, context: context)
        fittedPlans.append(plan)
        if let molecule = view as? Fragment {
            molecule.fragmentWillPlanContent()
            plan.planContent(molecule.planContent(_:))
            molecule.fragmentDidPlanContent()
        }
        return plan
    }
    
    @discardableResult
    func fitStacked(_ viewController: UIViewController) -> LayoutPlaner<UIView> {
        if let parentController: UIViewController = view.parentViewController
            ?? context.delegate.planer(neededViewControllerFor: viewController) {
            parentController.addChild(viewController)
        } else {
            context.delegate.planer(
                view,
                errorWhenPlanning: .init(
                    errorDescription: "Draftsman Error: ",
                    failureReason: "Try to put UIViewController when view is not in UIViewController"
                )
            )
        }
        return fitStacked(viewController.view)
    }
}

public extension InsertableViewPlan {
    @discardableResult
    func fit<V: UIView>(_ view: V) -> LayoutPlaner<V> {
        let possibleFragmentView = view as? FragmentView
        possibleFragmentView?.inPlanning = true
        defer {
            possibleFragmentView?.inPlanning = false
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        let plan = LayoutPlaner(view: view, context: context)
        fittedPlans.append(plan)
        if let molecule = view as? Fragment {
            molecule.fragmentWillPlanContent()
            plan.planContent(molecule.planContent(_:))
            molecule.fragmentDidPlanContent()
        }
        return plan
    }
    
    @discardableResult
    func fit(_ viewController: UIViewController) -> LayoutPlaner<UIView> {
        if let parentController: UIViewController = view.parentViewController
            ?? context.delegate.planer(neededViewControllerFor: viewController) {
            parentController.addChild(viewController)
        } else {
            context.delegate.planer(
                view,
                errorWhenPlanning: .whenFitting(
                    UIViewController.self,
                    into: Self.self,
                    failureReason: "Try to put UIViewController when view is not in UIViewController"
                )
            )
        }
        return fit(viewController.view)
    }
}

public class LayoutPlan<View: UIView>: InsertableViewPlan {
    public var view: View
    public var fittedPlans: [Plan] = []
    public var context: PlanContext
    
    init(view: View, context: PlanContext) {
        self.view = view
        self.context = context
    }
}
#endif
