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
public final class LayoutSchemeBuilder<View: UIView>: Maker {
    public var underlyingObject: View {
        get { scheme.underlyingView }
        set { scheme.underlyingView = newValue }
    }
    let scheme: LayoutScheme<View>
    public var drf: LayoutScheme<View> { scheme }
    
    init(_ scheme: LayoutScheme<View>) {
        self.scheme = scheme
    }
    
    public subscript<Property>(
        dynamicMember keyPath: KeyPath<Object, Property>) -> PropertyAssigner<Object, Property, LayoutSchemeBuilder<Object>> {
            propertyAssigner(for: keyPath)
        }
}

extension LayoutSchemeBuilder: DraftComponent {
    public var insertableDrafts: [ViewScheme] {
        scheme.insertableDrafts
    }
    
}
#endif
