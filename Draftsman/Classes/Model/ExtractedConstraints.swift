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
        self.toActivated = Array(Set(toActivated))
        self.toRemoved = Array(Set(toRemoved))
    }
}
#endif
