//
//  TriConstant.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 19/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: Protocol

struct TriConstant {
    let uniConstant: CGFloat
    let firstBiConstant: CGFloat
    let secondBiConstant: CGFloat
}

extension TriConstant {
    var negative: TriConstant {
        .init(
            uniConstant: -uniConstant,
            firstBiConstant: -firstBiConstant,
            secondBiConstant: -secondBiConstant
        )
    }
}
#endif
