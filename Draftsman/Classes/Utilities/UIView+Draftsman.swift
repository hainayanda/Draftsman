//
//  UIView+Draftsman.swift
//  Draftsman
//
//  Created by Nayanda Haberty (ID) on 27/08/20.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension UIView {
    
    var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    var borderWidth: CGFloat {
        get {
            layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    var borderColor: CGColor? {
        get {
            layer.borderColor
        }
        set {
            layer.borderColor = newValue
        }
    }
    
    var mostTopView: UIView {
        superview?.mostTopView ?? self
    }
    
    var allConstraints: [NSLayoutConstraint] {
        subviews.reduce(constraints) { partialResult, subview in
            var nextResult = partialResult
            nextResult.append(contentsOf: subview.allConstraints)
            return nextResult
        }
    }
    
    var draftsmanConstraints: [NSLayoutConstraint] {
        constraints.filter { $0.isDraftsmanConstraint }
    }
    
    var allDraftsmanConstraints: [NSLayoutConstraint] {
        subviews.reduce(draftsmanConstraints) { partialResult, subview in
            var nextResult = partialResult
            nextResult.append(contentsOf: subview.allDraftsmanConstraints)
            return nextResult
        }
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
