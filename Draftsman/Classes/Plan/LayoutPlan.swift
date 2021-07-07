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
    public typealias Component = PlanComponent
    public typealias Result = ViewPlan
    
    public static func buildBlock(_ components: Component...) -> Result {
        return RootViewPlan(subPlan: components.compactMap { convertToScheme(component: $0) })
    }
    
    public static func buildOptional(_ component: Component?) -> Component {
        guard let component = component else { return VoidPlanComponent() }
        return component
    }
    
    public static func buildEither(first component: Component) -> Component {
        component
    }
    
    public static func buildEither(second component: Component) -> Component {
        component
    }
    
    public static func buildArray(_ components: [Component]) -> Component {
        SchemeCollection(subPlan: components.compactMap { convertToScheme(component: $0) })
    }
    
    static func convertToScheme(component: Component) -> ViewScheme? {
        if let scheme = component as? ViewScheme {
            return scheme
        } else if let convertible = component as? PlanConvertible {
            return convertible.scheme
        }
        return nil
    }
    
}
#endif
