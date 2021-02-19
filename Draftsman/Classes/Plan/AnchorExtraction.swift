//
//  AnchorExtraction.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 24/12/20.
//

import Foundation
#if canImport(UIKit)
import UIKit

extension UILayoutGuide {
    func anchor(of dimension: LayoutDimension) -> NSLayoutDimension{
        switch dimension {
        case .width:
            return widthAnchor
        default:
            return heightAnchor
        }
    }
}

extension UIView {
    func anchor(of dimension: LayoutDimension) -> NSLayoutDimension{
        switch dimension {
        case .width:
            return widthAnchor
        default:
            return heightAnchor
        }
    }
}
#endif
