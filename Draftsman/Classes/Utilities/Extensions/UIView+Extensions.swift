//
//  UIView+Extensions.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 20/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit
fileprivate var plannedIdentifierKey: String = "plannedIdentifierKey"

extension UIView {
    
    var planIdentifier: ObjectIdentifier? {
        get {
            objc_getAssociatedObject(self, &plannedIdentifierKey) as? ObjectIdentifier
        }
        set {
            objc_setAssociatedObject(self, &plannedIdentifierKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func isPartOf(planned: Planned) -> Bool {
        planIdentifier == planned.planIdentifier
    }
    
    func makeAssociated(with planned: Planned) {
        self.planIdentifier = planned.planIdentifier
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
    
    convenience init(text: String? = nil, font: UIFont) {
        self.init()
        self.text = text
        self.font = font
    }
    
    convenience init(text: String? = nil, textColor: UIColor) {
        self.init()
        self.text = text
        self.textColor = textColor
    }
    
    convenience init(text: String? = nil, font: UIFont, textColor: UIColor) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
    }
}

public extension UITextField {
    
    convenience init(placeholder: String?) {
        self.init()
        self.placeholder = placeholder
    }
    
    convenience init(text: String?, placeholder: String? = nil) {
        self.init()
        self.text = text
        self.placeholder = placeholder
    }
    
    convenience init(text: String? = nil, placeholder: String? = nil, font: UIFont) {
        self.init()
        self.text = text
        self.placeholder = placeholder
        self.font = font
    }
    
    convenience init(text: String? = nil, placeholder: String? = nil, textColor: UIColor) {
        self.init()
        self.text = text
        self.placeholder = placeholder
        self.textColor = textColor
    }
    
    convenience init(text: String? = nil, placeholder: String? = nil, font: UIFont, textColor: UIColor) {
        self.init()
        self.text = text
        self.placeholder = placeholder
        self.font = font
        self.textColor = textColor
    }
}

public extension UITextView {
    
    convenience init(text: String?) {
        self.init()
        self.text = text
    }
    
    convenience init(text: String? = nil, font: UIFont) {
        self.init(text: text)
        self.font = font
    }
    
    convenience init(text: String? = nil, textColor: UIColor) {
        self.init()
        self.text = text
        self.textColor = textColor
    }
    
    convenience init(text: String? = nil, font: UIFont, textColor: UIColor) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
    }
}

public extension UIButton {
    
    convenience init(text: String?, textColor: UIColor) {
        self.init()
        self.setTitle(text, for: .normal)
        self.setTitleColor(textColor, for: .normal)
    }
}
#endif
