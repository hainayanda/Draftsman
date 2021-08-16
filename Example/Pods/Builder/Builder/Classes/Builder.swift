//
//  Builder.swift
//  Builder
//
//  Created by Nayanda Haberty on 15/08/21.
//

import Foundation

public func builder<B: Buildable>(_ type: B.Type) -> Builder<B> {
    Builder(object: .init())
}

public func builder<Object>(_ object: Object) -> Builder<Object> {
    Builder(object: object)
}

@dynamicMemberLookup
public final class Builder<Object> {
    var object: Object
    
    init(object: Object) {
        self.object = object
    }
    
    public subscript<Property>(
        dynamicMember keyPath: WritableKeyPath<Object, Property>) -> PropertyAssigner<Object, Property, Builder<Object>> {
        return PropertyAssigner(keypathOwner: object, keyPath: keyPath) { value in
            self.object[keyPath: keyPath] = value
            return self
        }
    }
    
    public func build() -> Object { object }
}
