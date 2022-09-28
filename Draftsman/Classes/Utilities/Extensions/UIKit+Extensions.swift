//
//  UIKit+Extensions.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 19/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: Convenience Init

public extension CGSize {
    @inlinable init(sides: CGFloat) {
        self.init(width: sides, height: sides)
    }
}

public extension UIEdgeInsets {
    @inlinable init(horizontalInset: HorizontalConstant, verticalInset: VerticalConstant) {
        self.init(
            top: verticalInset.top,
            left: horizontalInset.leading,
            bottom: verticalInset.bottom,
            right: horizontalInset.trailing
        )
    }
    
    @inlinable init(vertical: CGFloat, horizontal: CGFloat) {
        self.init(
            top: vertical,
            left: horizontal,
            bottom: vertical,
            right: horizontal
        )
    }
    
    @inlinable init(insets: CGFloat) {
        self.init(
            top: insets,
            left: insets,
            bottom: insets,
            right: insets
        )
    }
    
    @inlinable init(vertical: CGFloat, left: CGFloat = .zero, right: CGFloat = .zero) {
        self.init(
            top: vertical,
            left: left,
            bottom: vertical,
            right: right
        )
    }
    
    @inlinable init(horizontal: CGFloat, top: CGFloat = .zero, bottom: CGFloat = .zero) {
        self.init(
            top: top,
            left: horizontal,
            bottom: bottom,
            right: horizontal
        )
    }
}

// MARK: Negative

extension UIEdgeInsets {
    @inlinable var negative: UIEdgeInsets {
        .init(top: -top, left: -left, bottom: -bottom, right: -right)
    }
}

extension CGSize {
    @inlinable var negative: CGSize {
        .init(width: -width, height: -height)
    }
}

// MARK: Pair Constant

extension UIEdgeInsets {
    @inlinable public var horizontal: HorizontalConstant {
        .init(left: left, right: right)
    }
    
    @inlinable public var vertical: VerticalConstant {
        .init(top: top, bottom: bottom)
    }
}

public typealias EdgeInsets = UIEdgeInsets
public typealias EdgeOffsets = UIEdgeInsets

// MARK: Auto

extension CGFloat {
    @inlinable public var isNotVisible: Bool { self <= .zero }
    @inlinable public var isVisible: Bool { !isNotVisible }
}

extension CGSize {
    @inlinable public var isNotVisible: Bool { width.isNotVisible || height.isNotVisible }
    @inlinable public var isVisible: Bool { width.isVisible && height.isVisible }
}

// MARK: Next Responder

extension UIResponder {
    @inlinable var responderViewController: UIViewController? {
        if let selfController = self as? UIViewController {
            return selfController
        }
        return next?.responderViewController
    }
}
#endif
