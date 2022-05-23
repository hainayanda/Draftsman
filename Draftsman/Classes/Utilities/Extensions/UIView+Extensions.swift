//
//  UIView+Extensions.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 20/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit
fileprivate var draftedIdentifierKey: String = "draftedIdentifierKey"

extension UIView {
    
    var draftedIdentifier: ObjectIdentifier? {
        get {
            objc_getAssociatedObject(self, &draftedIdentifierKey) as? ObjectIdentifier
        }
        set {
            objc_setAssociatedObject(self, &draftedIdentifierKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func isPartOf(drafted: Drafted) -> Bool {
        draftedIdentifier == drafted.draftedIdentifier
    }
    
    func makeAssociated(with drafted: Drafted) {
        self.draftedIdentifier = drafted.draftedIdentifier
    }
}

public extension UIStackView {
    
    convenience init(
        axis: NSLayoutConstraint.Axis,
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill,
        spacing: CGFloat = .zero) {
        self.init()
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
    }
}

public extension UILabel {
    
    convenience init(text: String?) {
        self.init()
        self.text = text
    }
    
    convenience init(text: String?, font: UIFont) {
        self.init()
        self.text = text
        self.font = font
    }
}

public extension UIButton {
    
    convenience init(text: String?) {
        self.init()
        self.setTitle(text, for: .normal)
    }
}
#endif
