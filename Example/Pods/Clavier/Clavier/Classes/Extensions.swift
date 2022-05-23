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
    public var clavierLayoutGuide: UILayoutGuide {
        return clavierLayoutGuideFactory(usingSafeArea: false)
    }
    
    public var safeClavierLayoutGuide: UILayoutGuide {
        return clavierLayoutGuideFactory(usingSafeArea: true)
    }
    
    func clavierLayoutGuideFactory(usingSafeArea: Bool) -> UILayoutGuide {
        guard #available(iOS 15.0, *) else {
            return oldiOSKeyboardLayoutGuide(usingSafeArea)
        }
        return iOS15KeyboardLayoutGuide(usingSafeArea)
    }
    
    @available(iOS 15.0, *)
    func iOS15KeyboardLayoutGuide(_ usingSafeArea: Bool) -> UILayoutGuide {
        if usingSafeArea {
            for guide in layoutGuides {
                if let keyboardGuide = guide as? SafeAreaKeyboardLayoutGuide {
                    return keyboardGuide
                }
            }
            let keyboardGuide = SafeAreaKeyboardLayoutGuide()
            addLayoutGuide(keyboardGuide)
            return keyboardGuide
        } else {
            return keyboardLayoutGuide
        }
    }
    
    func oldiOSKeyboardLayoutGuide(_ usingSafeArea: Bool) -> UILayoutGuide {
        for guide in layoutGuides {
            if let keyboardGuide = guide as? ClavierLayoutGuide,
               keyboardGuide.usingSafeArea == usingSafeArea {
                return keyboardGuide
            }
        }
        let keyboardGuide = ClavierLayoutGuide(usingSafeArea: usingSafeArea)
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
