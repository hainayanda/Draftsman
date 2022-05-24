//
//  LayoutPlan.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 06/04/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

@resultBuilder
public struct LayoutPlan {
    public typealias Expression = PlanComponent?
    public typealias Component = [ViewDraft]
    public typealias Result = ViewPlan
    
    public static func buildExpression(_ expression: Expression) -> Component {
        expression?.insertablePlans ?? []
    }
    
    public static func buildOptional(_ component: Component?) -> Component {
        component ?? []
    }
    
    public static func buildEither(first component: Component) -> Component {
        component
    }
    
    public static func buildEither(second component: Component) -> Component {
        component
    }
    
    public static func buildArray(_ components: [Component]) -> Component {
        components.reduce([]) { partialResult, component in
            partialResult.added(withContentsOf: component)
        }
    }
    
    public static func buildBlock(_ components: Component...) -> Component {
        buildArray(components)
    }
    
    public static func buildFinalResult(_ component: Component) -> Result {
        ViewPlanBuilder(plans: component)
    }
}
#endif
