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
    
    func cleanSubViews() {
        let subViews = subviews
        for subView in subViews {
            subView.cleanSubViews()
            subView.removeFromSuperview()
        }
    }
    
    func removeAllPlannedConstraints() {
        removeAll(identifiedConstraints: [uniqueKey])
        let allSubviewsKeys: [String] = getAllSubViews().compactMap { $0.uniqueKey }
        mostTopParentForLayout.removeAll(identifiedConstraints: allSubviewsKeys)
    }
    
    func removeAll(identifiedConstraints: [String]) {
        let relatedConstraints = constraints.filter { constraint in
            identifiedConstraints.contains {
                ((constraint.identifier ?? "") =~ "draftsman_\($0)") ||
                    (constraint.identifier ?? "") == $0
            }
        }
        removeConstraints(relatedConstraints)
        for subview in subviews {
            subview.removeAll(identifiedConstraints: identifiedConstraints)
        }
    }
    
    func getAllSubViews() -> [UIView] {
        var childrens: [UIView] = subviews
        for view in self.subviews {
            childrens.append(contentsOf: view.getAllSubViews())
        }
        return childrens
    }
    
    var mostTopParentForLayout: UIView {
        var currentParent = self
        while let parent = currentParent.superview {
            if let cell = parent as? UITableViewCell {
                currentParent = cell
                break
            } else if let cell = parent as? UICollectionViewCell {
                currentParent = cell
                break
            }
            currentParent = parent
        }
        return currentParent
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
