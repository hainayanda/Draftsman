//
//  NSLayoutConstraint+Extensions.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 24/12/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

func ~= (_ lhs: NSLayoutConstraint, _ rhs: NSLayoutConstraint) -> Bool {
    lhs.firstAnchor == rhs.firstAnchor && lhs.secondAnchor == rhs.secondAnchor
    && lhs.relation == rhs.relation && lhs.identifier == rhs.identifier
    && lhs.multiplier == rhs.multiplier
}

extension NSLayoutConstraint {
    var isDraftsmanConstraint: Bool {
        guard let identifier = self.identifier, !identifier.isEmpty else { return false }
        return identifier =~ "^draftsman_"
    }
    
    func resembling(_ otherConstraints: NSLayoutConstraint) {
        self.constant = otherConstraints.constant
        self.priority = otherConstraints.priority
    }
}
#endif

