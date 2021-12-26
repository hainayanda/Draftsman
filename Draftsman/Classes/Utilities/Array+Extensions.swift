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

extension Array where Element == ViewScheme {
    func markUnmarked(with viewPlanId: String) {
        forEach {
            if $0.viewPlanId == nil {
                $0.viewPlanId = viewPlanId
            }
            $0.subPlan.markUnmarked(with: viewPlanId)
        }
    }
}

extension Array where Element: Hashable {
    var unique: [Element] {
        Array(Set(self)).sorted {
            guard let leftIndex = self.firstIndex(of: $0),
                    let rightIndex = self.firstIndex(of: $1) else {
                return true
            }
            return leftIndex < rightIndex
        }
    }
}
