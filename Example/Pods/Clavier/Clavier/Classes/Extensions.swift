//
//  Extensions.swift
//  Clavier
//
//  Created by Nayanda Haberty on 20/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

extension UIView {
    public var keyboardLayoutGuide: KeyboardLayoutGuide {
        return keyboardLayoutGuideFactory(usingSafeArea: false)
    }
    
    public var safeKeyboardLayoutGuide: KeyboardLayoutGuide {
        return keyboardLayoutGuideFactory(usingSafeArea: true)
    }
    
    func keyboardLayoutGuideFactory(usingSafeArea: Bool) -> KeyboardLayoutGuide {
        for guide in layoutGuides {
            if let keyboardGuide = guide as? KeyboardLayoutGuide,
               keyboardGuide.usingSafeArea == usingSafeArea {
                return keyboardGuide
            }
        }
        let keyboardGuide = KeyboardLayoutGuide(usingSafeArea: usingSafeArea)
        addLayoutGuide(keyboardGuide)
        return keyboardGuide
    }
} 

extension CGRect {
    func insets(of innerFrame: CGRect) -> UIEdgeInsets {
        let topInset = innerFrame.origin.y
        let leftInset = innerFrame.origin.x
        let maxX = topInset + innerFrame.size.height
        let bottomInset = size.height - maxX
        let maxY = leftInset + innerFrame.size.width
        let rightInset = size.width - maxY
        return UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    }
    
    func innerFrame(with insets: UIEdgeInsets) -> CGRect {
        let x = insets.left
        let y = insets.top
        let width = size.width - insets.left - insets.right
        let height = size.height - insets.top - insets.bottom
        return CGRect(x: x, y: y, width: width, height: height)
    }
}
#endif
