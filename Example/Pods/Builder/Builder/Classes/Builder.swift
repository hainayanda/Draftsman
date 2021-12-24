//
//  Builder.swift
//  Builder
//
//  Created by Nayanda Haberty on 15/08/21.
//

import Foundation

public func builder<B: Buildable>(_ type: B.Type) -> Builder<B> {
    Builder(type)
}

public func builder<Object>(_ object: Object) -> Builder<Object> {
    Builder(object)
}

public protocol Maker: AnyObject {
    associatedtype Object
    
    var underlyingObject: Object { get set }
}

public extension Maker {
    func propertyAssigner<Property>(for keyPath: KeyPath<Object, Property>) -> PropertyAssigner<Object, Property, Self> {
        PropertyAssigner(keypathOwner: underlyingObject, keyPath: keyPath) { value, assignType  in
            switch assignType {
            case .directAssign:
                break;
            case .toParent:
                if Property.self is AnyClass {
                    return self
                }
                break;
            case .error:
                return self
            }
            guard let writable = keyPath as? WritableKeyPath<Object, Property> else {
                errorHappens("Failed to assign property keypath of \(String(describing: Object.self)) with property type \(String(describing: Property.self)) because its not writable")
                return self
            }
            self.underlyingObject[keyPath: writable] = value
            return self
        }
    }
}

@dynamicMemberLookup
public final class Builder<Object>: Maker {
    public var underlyingObject: Object
    
    init(_ object: Object) {
        self.underlyingObject = object
    }
    
    public subscript<Property>(
        dynamicMember keyPath: KeyPath<Object, Property>) -> PropertyAssigner<Object, Property, Builder<Object>> {
        propertyAssigner(for: keyPath)
    }
    
    public func build() -> Object { underlyingObject }
}

public extension Builder where Object: Buildable {
    convenience init(_ type: Object.Type) {
        self.init(.init())
    }
}
