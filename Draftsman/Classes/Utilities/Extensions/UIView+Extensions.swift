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
