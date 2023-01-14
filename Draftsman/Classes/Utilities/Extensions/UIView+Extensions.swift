//
//  UIView+Extensions.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 20/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

private var plannedIdentifierKey: String = "plannedIdentifierKey"

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
    
    @inlinable convenience init(
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

public protocol CellWithContentView: UIView {
    var contentView: UIView { get }
}

extension UITableViewCell: CellWithContentView { }
extension UICollectionViewCell: CellWithContentView { }

public extension UILabel {
    
    @inlinable convenience init(text: String?) {
        self.init()
        self.text = text
    }
    
    @inlinable convenience init(text: String? = nil, font: UIFont) {
        self.init()
        self.text = text
        self.font = font
    }
    
    @inlinable convenience init(text: String? = nil, textColor: UIColor) {
        self.init()
        self.text = text
        self.textColor = textColor
    }
    
    @inlinable convenience init(text: String? = nil, font: UIFont, textColor: UIColor) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
    }
}

public extension UITextField {
    
    @inlinable convenience init(placeholder: String?) {
        self.init()
        self.placeholder = placeholder
    }
    
    @inlinable convenience init(text: String?, placeholder: String? = nil) {
        self.init()
        self.text = text
        self.placeholder = placeholder
    }
    
    @inlinable convenience init(text: String? = nil, placeholder: String? = nil, font: UIFont) {
        self.init()
        self.text = text
        self.placeholder = placeholder
        self.font = font
    }
    
    @inlinable convenience init(text: String? = nil, placeholder: String? = nil, textColor: UIColor) {
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
    
    @inlinable convenience init(text: String?) {
        self.init()
        self.text = text
    }
    
    @inlinable convenience init(text: String? = nil, font: UIFont) {
        self.init(text: text)
        self.font = font
    }
    
    @inlinable convenience init(text: String? = nil, textColor: UIColor) {
        self.init()
        self.text = text
        self.textColor = textColor
    }
    
    @inlinable convenience init(text: String? = nil, font: UIFont, textColor: UIColor) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
    }
}

public extension UIButton {
    
    @inlinable convenience init(text: String?, textColor: UIColor) {
        self.init()
        self.setTitle(text, for: .normal)
        self.setTitleColor(textColor, for: .normal)
    }
}
#endif
