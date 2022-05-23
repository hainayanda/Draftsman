//
//  LayoutDraft.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 06/04/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

@resultBuilder
public struct LayoutDraft {
    public typealias Expression = DraftComponent?
    public typealias Component = [ViewScheme]
    public typealias Result = ViewDraft
    
    public static func buildExpression(_ expression: Expression) -> Component {
        expression?.insertableDrafts ?? []
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
        ViewDraftBuilder(drafts: component)
    }
}
#endif
