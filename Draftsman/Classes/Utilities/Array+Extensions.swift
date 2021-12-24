//
//  Array+Extensions.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 23/12/21.
//

import Foundation

extension Array where Element == PlanComponent {
    var asSchemes: [ViewScheme] {
        compactMap {
            if let scheme = $0 as? ViewScheme {
                return scheme
            } else if let convertible = $0 as? PlanConvertible {
                return convertible.scheme
            }
            return nil
        }
    }
}

extension Array {
    func added<S: Sequence>(withContentsOf sequence: S) -> Self where S.Element == Element {
        var array: Self = self
        array.append(contentsOf: sequence)
        return array
    }
}