//
//  CGFloat+Extensions.swift
//  Gizmo
//
//  Created by Nayanda Haberty on 15/08/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension CGFloat {
    
    /// Return `True` if the value is valid for UI dimension
    @inlinable var isValidUIDimension: Bool {
        isFinite && self > .zero
    }
    @inlinable var isNotVisible: Bool { self <= .zero }
    @inlinable var isVisible: Bool { !isNotVisible }
}
#endif
