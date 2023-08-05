//
//  UIEdgeInsets+Extenison.swift
//  Gizmo
//
//  Created by Nayanda Haberty on 27/.zero7/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

public typealias UIEdgeOffsets = UIEdgeInsets
public typealias EdgeInsets = UIEdgeInsets
public typealias EdgeOffsets = UIEdgeInsets

// MARK: Init

public extension UIEdgeInsets {
    
    // MARK: All insets
    
    /// Create UIEdgeInsets with given insets
    /// - Parameter edges: All edge insets
    @inlinable init(edges: CGFloat) {
        self.init(top: edges, left: edges, bottom: edges, right: edges)
    }
    
    // MARK: Vertical Horizontal
    
    /// Create UIEdgeInsets with given verticals and horizontals insets
    /// Default value of verticals and horizontals is zero
    /// - Parameters:
    ///   - vertical: Top and bottom insets
    ///   - horizontal: Left and right insets, default is zero
    @inlinable init(verticals: CGFloat, horizontals: CGFloat = .zero) {
        self.init(top: verticals, left: horizontals, bottom: verticals, right: horizontals)
    }
    
    /// Create UIEdgeInsets with given horizontals insets. All other insets will be zero
    /// - Parameter horizontals: Left and right insets, default is zero
    @inlinable init(horizontals: CGFloat) {
        self.init(verticals: .zero, horizontals: horizontals)
    }
    
    /// Create UIEdgeInsets with given left, right and verticals insets.
    /// - Parameters:
    ///   - left: Left inset
    ///   - right: Right inset, default is zero
    ///   - verticals: Top and bottom insets, default is zero
    @inlinable init(left: CGFloat, right: CGFloat = .zero, verticals: CGFloat = .zero) {
        self.init(top: verticals, left: left, bottom: verticals, right: right)
    }
    
    /// Create UIEdgeInsets with given right and verticals insets. Left inset will be zero
    /// - Parameters:
    ///   - right: Right inset
    ///   - verticals: Top and bottom insets, default is zero
    @inlinable init(right: CGFloat, verticals: CGFloat = .zero) {
        self.init(left: .zero, right: right, verticals: verticals)
    }
    
    /// Create UIEdgeInsets with given top, bottom and horizontals insets
    /// - Parameters:
    ///   - top: Top inset
    ///   - bottom: Bottom inset, default is zero
    ///   - horizontals: Left and right insets, default is zero
    @inlinable init(top: CGFloat, bottom: CGFloat = .zero, horizontals: CGFloat = .zero) {
        self.init(top: top, left: horizontals, bottom: bottom, right: horizontals)
    }
    
    /// Create UIEdgeInsets with given bottom and horizontals insets. Top inset will be zero
    /// - Parameters:
    ///   - bottom: Bottom inset
    ///   - horizontals: Left and right insets, default is zero
    @inlinable init(bottom: CGFloat, horizontals: CGFloat = .zero) {
        self.init(top: .zero, bottom: bottom, horizontals: horizontals)
    }
    
    // MARK: Three insets
    
    /// Create UIEdgeInsets with given left, bottom and right insets. Top inset will be zero
    /// - Parameters:
    ///   - left: Left inset
    ///   - bottom: Bottom inset
    ///   - right: Right inset, default is zero
    @inlinable init(left: CGFloat, bottom: CGFloat, right: CGFloat = .zero) {
        self.init(top: .zero, left: left, bottom: bottom, right: right)
    }
    
    /// Create UIEdgeInsets with given top, bottom and right insets. Left inset will be zero
    /// - Parameters:
    ///   - top: Top Inset
    ///   - bottom: Bottom Inset
    ///   - right: Right Inset
    @inlinable init(top: CGFloat, bottom: CGFloat, right: CGFloat) {
        self.init(top: top, left: .zero, bottom: bottom, right: right)
    }
    
    /// Create UIEdgeInsets with given top, left and right insets. Bottom inset will be zero
    /// - Parameters:
    ///   - top: Top Inset
    ///   - left: Left inset
    ///   - right: Right Inset, default is zero
    @inlinable init(top: CGFloat, left: CGFloat, right: CGFloat = .zero) {
        self.init(top: top, left: left, bottom: .zero, right: right)
    }
    
    /// Create UIEdgeInsets with given top, left and bottom insets. Right inset will be zero
    /// - Parameters:
    ///   - top: Top Inset
    ///   - left: Left inset
    ///   - bottom: Bottom Inset
    @inlinable init(top: CGFloat, left: CGFloat, bottom: CGFloat) {
        self.init(top: top, left: left, bottom: bottom, right: .zero)
    }
    
    // MARK: Two insets
    
    /// Create UIEdgeInsets with given bottom and right insets. All other insets will be zero
    /// - Parameters:
    ///   - bottom: Bottom Inset
    ///   - right: Right Inset
    @inlinable init(bottom: CGFloat, right: CGFloat) {
        self.init(top: .zero, left: .zero, bottom: bottom, right: right)
    }
    
    /// Create UIEdgeInsets with given top and right insets. All other insets will be zero
    /// - Parameters:
    ///   - top: Top Inset
    ///   - right: Right Inset
    @inlinable init(top: CGFloat, right: CGFloat) {
        self.init(top: top, left: .zero, bottom: .zero, right: right)
    }
    
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

// MARK: Common

public extension UIEdgeInsets {
    
    @inlinable var horizontal: HorizontalConstant {
        .init(left: left, right: right)
    }
    
    @inlinable var vertical: VerticalConstant {
        .init(top: top, bottom: bottom)
    }
    
    @inlinable var negative: UIEdgeInsets {
        .init(top: -top, left: -left, bottom: -bottom, right: -right)
    }
    
    /// Create new UIEdgeInsets increased by another insets
    /// - Parameter insets: Another insets
    /// - Returns: New UIEdgeInsets
    @inlinable func increased(by insets: UIEdgeInsets) -> UIEdgeInsets {
        self + insets
    }
    
    /// Create new UIEdgeInsets increased by another insets
    /// - Parameter insets: Another insets
    /// - Returns: New UIEdgeInsets
    @inlinable func increased(by insets: CGFloat) -> UIEdgeInsets {
        self + insets
    }
    
    /// Create new UIEdgeInsets decreased by another insets
    /// - Parameter insets: Another insets
    /// - Returns: New UIEdgeInsets
    @inlinable func decreased(by insets: UIEdgeInsets) -> UIEdgeInsets {
        self - insets
    }
    
    /// Create new UIEdgeInsets decreased by another insets
    /// - Parameter insets: Another insets
    /// - Returns: New UIEdgeInsets
    @inlinable func decreased(by insets: CGFloat) -> UIEdgeInsets {
        self - insets
    }
}

// MARK: Operator

@inlinable public func + (_ lhs: UIEdgeInsets, _ rhs: UIEdgeInsets) -> UIEdgeInsets {
    UIEdgeInsets(
        top: lhs.top + rhs.top,
        left: lhs.left + rhs.left,
        bottom: lhs.bottom + rhs.bottom,
        right: lhs.right + rhs.right
    )
}

@inlinable public func - (_ lhs: UIEdgeInsets, _ rhs: UIEdgeInsets) -> UIEdgeInsets {
    UIEdgeInsets(
        top: lhs.top - rhs.top,
        left: lhs.left - rhs.left,
        bottom: lhs.bottom - rhs.bottom,
        right: lhs.right - rhs.right
    )
}

@inlinable public func + (_ lhs: UIEdgeInsets, _ rhs: CGFloat) -> UIEdgeInsets {
    UIEdgeInsets(
        top: lhs.top + rhs,
        left: lhs.left + rhs,
        bottom: lhs.bottom + rhs,
        right: lhs.right + rhs
    )
}

@inlinable public func - (_ lhs: UIEdgeInsets, _ rhs: CGFloat) -> UIEdgeInsets {
    UIEdgeInsets(
        top: lhs.top - rhs,
        left: lhs.left - rhs,
        bottom: lhs.bottom - rhs,
        right: lhs.right - rhs
    )
}

@inlinable public func * (_ lhs: UIEdgeInsets, _ rhs: CGFloat) -> UIEdgeInsets {
    UIEdgeInsets(
        top: lhs.top * rhs,
        left: lhs.left * rhs,
        bottom: lhs.bottom * rhs,
        right: lhs.right * rhs
    )
}

@inlinable public func / (_ lhs: UIEdgeInsets, _ rhs: CGFloat) -> UIEdgeInsets {
    UIEdgeInsets(
        top: lhs.top / rhs,
        left: lhs.left / rhs,
        bottom: lhs.bottom / rhs,
        right: lhs.right / rhs
    )
}
#endif
