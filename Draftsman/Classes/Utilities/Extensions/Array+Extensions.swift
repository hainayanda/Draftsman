//
//  Array+Extensions.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 06/04/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

extension Array where Element == NSLayoutConstraint {
    
    var validUniques: [NSLayoutConstraint] {
        var mappedUniques: [String: NSLayoutConstraint] = [:]
        return reversed().reduce([]) { partialResult, constraint in
            guard let identifier = constraint.draftsmanIdentifier,
                  mappedUniques[identifier] == nil else {
                return partialResult
            }
            mappedUniques[identifier] = constraint
            return partialResult.inserted(with: constraint, at: 0)
        }
    }
}
#endif

extension Array {
    @inlinable func added(with element: Element) -> [Element] {
        var newArray = self
        newArray.append(element)
        return newArray
    }
    
    @inlinable func added<S: Sequence>(withContentsOf sequence: S) -> [Element] where S.Element == Element {
        var newArray = self
        newArray.append(contentsOf: sequence)
        return newArray
    }
    
    @inlinable func inserted(with element: Element, at index: Int) -> [Element] {
        var newArray = self
        newArray.insert(element, at: index)
        return newArray
    }
}

extension Array where Element: NSLayoutConstraint {
    func groupedByDraftsmanIdentifier() -> [String: NSLayoutConstraint] {
        reduce([:]) { partialResult, constraint in
            guard let draftsmanIdentifier = constraint.draftsmanIdentifier else {
                return partialResult
            }
            var result = partialResult
            result[draftsmanIdentifier] = constraint
            return result
        }
    }
}
