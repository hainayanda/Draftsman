//
//  ConstraintBuilder.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 23/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

protocol ConstraintBuilder {
    func build(using context: PlanContext) -> [NSLayoutConstraint]
}

extension Array where Element == ConstraintBuilder {
    func build(using context: PlanContext) -> [NSLayoutConstraint] {
        reduce([]) { partialResult, builder in
            var result = partialResult
            result.append(contentsOf: builder.build(using: context))
            return result
        }
    }
}
#endif
