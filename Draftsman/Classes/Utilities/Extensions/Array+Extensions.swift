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
        var uniques: [NSLayoutConstraint] = []
        var mappedUniques: [String: NSLayoutConstraint] = [:]
        for constraint in self.reversed() {
            guard let identifier = constraint.draftsmanIdentifier,
                  mappedUniques[identifier] == nil else {
                continue
            }
            mappedUniques[identifier] = constraint
            uniques.insert(constraint, at: 0)
        }
        return uniques
    }
}
#endif

extension Array {
    func added(with element: Element) -> [Element] {
        var newArray = self
        newArray.append(element)
        return newArray
    }
    
    func added<S: Sequence>(withContentsOf sequence: S) -> [Element] where S.Element == Element{
        var newArray = self
        newArray.append(contentsOf: sequence)
        return newArray
    }
}
