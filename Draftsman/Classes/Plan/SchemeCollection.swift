//
//  SchemeCollection.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 07/07/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

open class SchemeCollection: ViewPlan {
    public var context: PlanContext = PlanContext(currentView: UIView())
    public var subPlan: [ViewScheme]
    
    public init(subPlan: [ViewScheme]) {
        self.subPlan = subPlan
    }
    
    open func build(for view: UIView) -> [NSLayoutConstraint] {
        context.currentView = view
        var constraints: [NSLayoutConstraint] = []
        subPlan.forEach { scheme in
            scheme.context = context
            let viewScheme = scheme.view
            viewScheme.translatesAutoresizingMaskIntoConstraints = false
            if let stack = view as? UIStackView, scheme.isStackContent {
                stack.addArrangedSubview(viewScheme)
            } else {
                view.addSubview(viewScheme)
            }
            if let controller = view.nextViewController,
               let schemeController = viewScheme.nextViewController,
               controller != schemeController {
                controller.addChild(schemeController)
            }
            constraints.append(contentsOf: scheme.build())
        }
        return constraints
    }
    
    @discardableResult
    open func apply(for view: UIView) -> [NSLayoutConstraint] {
        return subPlan.reduce([]) { subConstraints, scheme in
            scheme.context = context
            var mutableConstraints = subConstraints
            mutableConstraints.append(contentsOf: scheme.apply())
            return mutableConstraints
        }
    }
}
#endif
