//
//  PropertyAssigner.swift
//  Builder
//
//  Created by Nayanda Haberty on 16/08/21.
//

import Foundation

public enum AssigningType {
    case directAssign
    case toParent
    case error
}

@dynamicCallable
@dynamicMemberLookup
public final class PropertyAssigner<PropertyOwner, Property, ReturnValue> {
    var keypathOwner: PropertyOwner
    var keyPath: KeyPath<PropertyOwner, Property>
    var parentAsigning: (Property, AssigningType) -> ReturnValue
    
    public init(
        keypathOwner: PropertyOwner,
        keyPath: KeyPath<PropertyOwner, Property>,
        whenAssigned parentAsigning: @escaping (Property, AssigningType) -> ReturnValue) {
        self.keypathOwner = keypathOwner
        self.keyPath = keyPath
        self.parentAsigning = parentAsigning
    }
    
    public func dynamicallyCall(withArguments arguments: [Property]) -> ReturnValue {
        parentAsigning(arguments[0], .directAssign)
    }
    
    public subscript<SubProperty>(
        dynamicMember keyPath: KeyPath<Property, SubProperty>) -> PropertyAssigner<Property, SubProperty, ReturnValue> {
        var property = keypathOwner[keyPath: self.keyPath]
        return .init(keypathOwner: property, keyPath: keyPath) { value, assignType  in
            switch assignType {
            case .directAssign:
                break;
            case .toParent:
                if SubProperty.self is AnyClass {
                    return self.parentAsigning(property, .toParent)
                }
                break;
            case .error:
                return self.parentAsigning(property, .error)
            }
            guard let writable = keyPath as? WritableKeyPath<Property, SubProperty> else {
                errorHappens("Failed to assign property keypath of \(String(describing: Property.self)) with property type \(String(describing: SubProperty.self)) because its not writable")
                return self.parentAsigning(property, .toParent)
            }
            property[keyPath: writable] = value
            return self.parentAsigning(property, .toParent)
        }
    }
}
