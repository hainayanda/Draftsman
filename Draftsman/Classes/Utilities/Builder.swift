//
//  Builder.swift
//  Draftsman
//
//  Created by Nayanda Haberty (ID) on 30/09/20.
//

import Foundation
#if canImport(UIKit)
import UIKit

public protocol Buildable {
    init()
}

public func build<B: Buildable>(_ builder: (inout B) -> Void) -> B {
    var buildable = B.init()
    builder(&buildable)
    return buildable
}

public func build<Object>(_ object: Object, _ builder: (inout Object) -> Void) -> Object {
    var object = object
    builder(&object)
    return object
}

public func build<B: Buildable>(_ type: B.Type) -> BuildableBuilder<B> {
    .init(object: .init())
}

public func build<Object>(_ object: Object) -> BuildableBuilder<Object> {
    .init(object: object)
}

@dynamicMemberLookup
public class BuildableBuilder<Object> {
    public typealias PropertyAssigner<Property> = ((Property) -> BuildableBuilder<Object>)
    var object: Object
    
    init(object: Object) {
        self.object = object
    }
    
    public subscript<Property>(dynamicMember keyPath: WritableKeyPath<Object, Property>) -> PropertyAssigner<Property> {
        // retained on purpose
        return { value in
            self.object[keyPath: keyPath] = value
            return self
        }
    }
    
    public func build() -> Object { object }
}
#endif
