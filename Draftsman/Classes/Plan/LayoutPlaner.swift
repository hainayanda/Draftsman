//
//  ViewLayout.swift
//  Draftsman
//
//  Created by Nayanda Haberty (ID) on 27/08/20.
//

import Foundation
#if canImport(UIKit)
import UIKit

public class LayoutPlaner<View: UIView>: Planer {
    public typealias PropertyPlaner<Property> = ((Property) -> LayoutPlaner<View>)
    
    public var plannedConstraints: [NSLayoutConstraint] = []
    public var view: View
    public var context: PlanContext
    
    init(view: View, context: PlanContext) {
        self.view = view
        self.context = context
        self.context.currentView = view
    }
    
    @discardableResult
    public func planContent(_ containerBuilder: (LayoutPlan<View>) -> Void) -> Self {
        defer {
            context.currentView = view
        }
        let container = LayoutPlan(view: self.view, context: context)
        containerBuilder(container)
        for layoutable in container.fittedPlans {
            plannedConstraints.append(contentsOf: layoutable.plannedConstraints)
        }
        view.notifyViewDidPlanned()
        return self
    }
}
#endif
