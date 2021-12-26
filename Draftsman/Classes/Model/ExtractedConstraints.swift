//
//  ExtractedConstraints.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 26/12/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

struct ExtractedConstraints {
    
    let toActivated: [NSLayoutConstraint]
    let toRemoved: [NSLayoutConstraint]
    
    init(toActivated: [NSLayoutConstraint], toRemoved: [NSLayoutConstraint]) {
        let toActivatedUnique = toActivated.unique
        let toRemovedUnique = toRemoved.unique
        self.toActivated = toActivatedUnique
        self.toRemoved = toRemovedUnique.filter { !toActivatedUnique.contains($0) }
    }
}
#endif
