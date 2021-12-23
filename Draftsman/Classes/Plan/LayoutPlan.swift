//
//  PlannedLayout.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 06/07/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

@resultBuilder
public struct LayoutPlan {
    public typealias Expression = PlanComponent
    public typealias Component = [PlanComponent]
    public typealias Result = ViewPlan
    
    public static func buildExpression(_ expression: Expression) -> Component {
        [expression]
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
        RootViewPlan(subPlan: component.asSchemes)
    }
    
}
#endif
