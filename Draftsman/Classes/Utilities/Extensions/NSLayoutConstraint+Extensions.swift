//
//  DraftsmanConstraint.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 06/04/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

private var draftsmanIdentifierKey: String = "draftsmanIdentifierKey"

extension NSLayoutConstraint {
    var draftsmanIdentifier: String? {
        get {
            objc_getAssociatedObject(self, &draftsmanIdentifierKey) as? String
        }
        set {
            objc_setAssociatedObject(self, &draftsmanIdentifierKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func with(draftsmanIdentifier identifier: String) -> Self {
        draftsmanIdentifier = identifier
        return self
    }
    
    @inlinable func copyValue(from constraint: NSLayoutConstraint) {
        identifier = constraint.identifier
        constant = constraint.constant
        priority = constraint.priority
    }
}
#endif
