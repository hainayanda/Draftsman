//
//  PropertyAssigner.swift
//  Builder
//
//  Created by Nayanda Haberty on 16/08/21.
//

import Foundation

@dynamicCallable
@dynamicMemberLookup
public final class PropertyAssigner<PropertyOwner, Property, ReturnValue> {
    var keypathOwner: PropertyOwner
    var keyPath: WritableKeyPath<PropertyOwner, Property>
    var parentAsigning: (Property) -> ReturnValue
    
    internal init(
        keypathOwner: PropertyOwner,
        keyPath: WritableKeyPath<PropertyOwner, Property>,
        whenAssigned parentAsigning: @escaping (Property) -> ReturnValue) {
        self.keypathOwner = keypathOwner
        self.keyPath = keyPath
        self.parentAsigning = parentAsigning
    }
    
    public func dynamicallyCall(withArguments arguments: [Property]) -> ReturnValue {
        parentAsigning(arguments[0])
    }
    
    public subscript<SubProperty>(
        dynamicMember keyPath: WritableKeyPath<Property, SubProperty>) -> PropertyAssigner<Property, SubProperty, ReturnValue> {
        var property = keypathOwner[keyPath: self.keyPath]
        return .init(keypathOwner: property, keyPath: keyPath) { value in
            property[keyPath: keyPath] = value
            return self.parentAsigning(property)
        }
    }
}
