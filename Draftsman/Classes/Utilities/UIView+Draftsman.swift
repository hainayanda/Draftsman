//
//  UIView+Draftsman.swift
//  Draftsman
//
//  Created by Nayanda Haberty (ID) on 27/08/20.
//

import Foundation
#if canImport(UIKit)
import UIKit

extension UIView.AssociatedKey {
    static var createdInPlan: String = "draftsman_Created_In_Plan"
}

public extension UIView {
    
    internal(set) var createdInPlan: Bool {
        get {
            (objc_getAssociatedObject(
                self, &AssociatedKey.createdInPlan) as? NSNumber
            )?.boolValue ?? false
        }
        set {
            objc_setAssociatedObject(
                self, &AssociatedKey.createdInPlan,
                NSNumber(value: newValue),
                .OBJC_ASSOCIATION_RETAIN
            )
        }
    }
    
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
    
    internal var mostTopParentForConstraining: UIView {
        guard let next = next else { return self }
        if next is UIViewController {
            return self
        } else if let tableCell = next as? UITableViewCell {
            return tableCell
        } else if let collectionCell = next as? UICollectionViewCell {
            return collectionCell
        } else if let view = next as? UIView {
            return view.mostTopParentForConstraining
        } else {
            return self
        }
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
    
    func ifRootOfController(do action: (UIViewController) -> Void) {
        guard let viewController = next as? UIViewController else { return }
        action(viewController)
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

public extension UIViewController {
    var createdInPlan: Bool {
        view.createdInPlan
    }
}
#endif
