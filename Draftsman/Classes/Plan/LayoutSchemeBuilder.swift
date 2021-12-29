//
//  LayoutSchemeBuilder.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 24/12/21.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Builder

public extension LayoutScheme {
    var builder: LayoutSchemeBuilder<View> {
        LayoutSchemeBuilder<View>(self)
    }
}

@dynamicMemberLookup
public final class LayoutSchemeBuilder<Object: UIView>: Maker {
    public var underlyingObject: Object {
        get { plan.viewInScheme }
        set { plan.viewInScheme = newValue }
    }
    public let plan: LayoutScheme<Object>
    
    init(_ plan: LayoutScheme<Object>) {
        self.plan = plan
    }
    
    public subscript<Property>(
        dynamicMember keyPath: KeyPath<Object, Property>) -> PropertyAssigner<Object, Property, LayoutSchemeBuilder<Object>> {
            propertyAssigner(for: keyPath)
        }
}

extension LayoutSchemeBuilder: PlanConvertible {
    public var scheme: ViewScheme { plan }
}
#endif
