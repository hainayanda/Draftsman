//
//  Dimensions.swift
//  Draftsman
//
//  Created by Nayanda Haberty (ID) on 28/08/20.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: Convenience Init

public extension CGSize {
    init(sides: CGFloat) {
        self.init(width: sides, height: sides)
    }
}

public extension UIEdgeInsets {
    init(horizontalInset: UIHorizontalInsets, verticalInset: UIVerticalInsets) {
        self.init(
            top: verticalInset.top,
            left: horizontalInset.left,
            bottom: verticalInset.bottom,
            right: horizontalInset.right
        )
    }
    
    init(vertical: CGFloat, horizontal: CGFloat) {
        self.init(
            top: vertical,
            left: horizontal,
            bottom: vertical,
            right: horizontal
        )
    }
    
    init(insets: CGFloat) {
        self.init(
            top: insets,
            left: insets,
            bottom: insets,
            right: insets
        )
    }
    
    init(vertical: CGFloat, left: CGFloat = .zero, right: CGFloat = .zero) {
        self.init(
            top: vertical,
            left: left,
            bottom: vertical,
            right: right
        )
    }
    
    init(horizontal: CGFloat, top: CGFloat = .zero, bottom: CGFloat = .zero) {
        self.init(
            top: top,
            left: horizontal,
            bottom: bottom,
            right: horizontal
        )
    }
}

//MARK: Insets

public protocol InsetsConvertible {
    var vertical: UIVerticalInsets { get }
    var horizontal: UIHorizontalInsets { get }
    var edges: UIEdgeInsets { get }
}

public protocol ConvertibleToInsets: InsetsConvertible {
    var asCGFloat: CGFloat { get }
    var forTop: UIEdgeInsets { get }
    var forBottom: UIEdgeInsets { get }
    var forLeft: UIEdgeInsets { get }
    var forRight: UIEdgeInsets { get }
    var topLeft: UIEdgeInsets { get }
    var topRight: UIEdgeInsets { get }
    var bottomLeft: UIEdgeInsets { get }
    var bottomRight: UIEdgeInsets { get }
    var fullTop: UIEdgeInsets { get }
    var fullBottom: UIEdgeInsets { get }
    var fullLeft: UIEdgeInsets { get }
    var fullRight: UIEdgeInsets { get }
}

public extension ConvertibleToInsets {
    var forTop: UIEdgeInsets {
        .init(top: asCGFloat, left: 0, bottom: 0, right: 0)
    }
    var forBottom: UIEdgeInsets {
        .init(top: 0, left: 0, bottom: asCGFloat, right: 0)
    }
    var forLeft: UIEdgeInsets {
        .init(top: 0, left: asCGFloat, bottom: 0, right: 0)
    }
    var forRight: UIEdgeInsets {
        .init(top: 0, left: 0, bottom: 0, right: asCGFloat)
    }
    var topLeft: UIEdgeInsets {
        .init(top: 0, left: asCGFloat, bottom: 0, right: 0)
    }
    var topRight: UIEdgeInsets {
        .init(top: asCGFloat, left: 0, bottom: 0, right: asCGFloat)
    }
    var bottomLeft: UIEdgeInsets {
        .init(top: 0, left: asCGFloat, bottom: asCGFloat, right: 0)
    }
    var bottomRight: UIEdgeInsets {
        .init(top: 0, left: 0, bottom: asCGFloat, right: asCGFloat)
    }
    var fullTop: UIEdgeInsets {
        .init(top: asCGFloat, left: asCGFloat, bottom: 0, right: asCGFloat)
    }
    var fullBottom: UIEdgeInsets {
        .init(top: 0, left: asCGFloat, bottom: asCGFloat, right: asCGFloat)
    }
    var fullLeft: UIEdgeInsets {
        .init(top: asCGFloat, left: asCGFloat, bottom: asCGFloat, right: 0)
    }
    var fullRight: UIEdgeInsets {
        .init(top: asCGFloat, left: 0, bottom: asCGFloat, right: asCGFloat)
    }
    var edges: UIEdgeInsets {
        .init(insets: asCGFloat)
    }
    var vertical: UIVerticalInsets {
        .init(insets: asCGFloat)
    }
    var horizontal: UIHorizontalInsets {
        .init(insets: asCGFloat)
    }
}

extension CGFloat: ConvertibleToInsets {
    public var asCGFloat: CGFloat {
        .init(self)
    }
}

extension Int: ConvertibleToInsets {
    public var asCGFloat: CGFloat {
        .init(self)
    }
}

extension Double: ConvertibleToInsets {
    public var asCGFloat: CGFloat {
        .init(self)
    }
}

public struct UIVerticalInsets: InsetsConvertible {
    public static let zero: UIVerticalInsets = .init(insets: 0)
    public let top: CGFloat
    public let bottom: CGFloat
    public var both: CGFloat { top + bottom }
    public var edges: UIEdgeInsets {
        .init(top: top, left: 0, bottom: bottom, right: 0)
    }
    public var vertical: UIVerticalInsets {
        self
    }
    public var horizontal: UIHorizontalInsets {
        .zero
    }
    
    public init(top: CGFloat, bottom: CGFloat) {
        self.top = top
        self.bottom = bottom
    }
    
    public init(insets: CGFloat) {
        self.top = insets
        self.bottom = insets
    }
}

public struct UIHorizontalInsets: InsetsConvertible {
    public static let zero: UIHorizontalInsets = .init(insets: 0)
    public let left: CGFloat
    public let right: CGFloat
    public var both: CGFloat { left + right }
    public var edges: UIEdgeInsets {
        .init(top: 0, left: left, bottom: 0, right: right)
    }
    public var vertical: UIVerticalInsets {
        .zero
    }
    public var horizontal: UIHorizontalInsets {
        self
    }
    
    public init(left: CGFloat, right: CGFloat) {
        self.left = left
        self.right = right
    }
    
    public init(insets: CGFloat) {
        self.left = insets
        self.right = insets
    }
}

public struct UIAxisInsets {
    public let xInset: CGFloat
    public let yInset: CGFloat
    public static let zero: UIAxisInsets = .init(insets: 0)
    
    public init(xInset: CGFloat, yInset: CGFloat) {
        self.xInset = xInset
        self.yInset = yInset
    }
    
    public init(insets: CGFloat) {
        self.xInset = insets
        self.yInset = insets
    }
}

public extension UIEdgeInsets {
    var horizontal: UIHorizontalInsets { .init(left: left, right: right) }
    var vertical: UIVerticalInsets { .init(top: top, bottom: bottom) }
}

extension UIEdgeInsets: InsetsConvertible {
    public var edges: UIEdgeInsets {
        self
    }
}

public struct CoordinateOffsets {
    public var xOffset: CGFloat
    public var yOffset: CGFloat
    
    public init(xOffset: CGFloat = 0, yOffset: CGFloat = 0) {
        self.xOffset = xOffset
        self.yOffset = yOffset
    }
    
}

// MARK: Auto

extension CGFloat {
    public static var automatic: CGFloat { UITableView.automaticDimension }
    
    public var isAutomatic: Bool { self == .automatic }
    public var isCalculated: Bool { !isAutomatic }
    public var isNotVisible: Bool { self <= .zero }
    public var isVisible: Bool { !isNotVisible }
}

extension CGSize {
    public static var automatic: CGSize { UICollectionViewFlowLayout.automaticSize }
    
    public var isAutomatic: Bool { self == .automatic || (self.height.isAutomatic && self.width.isAutomatic) }
    public var isCalculated: Bool { !isAutomatic }
    public var isNotVisible: Bool { width.isNotVisible || height.isNotVisible }
    public var isVisible: Bool { width.isVisible && height.isVisible }
}

public func hInsets(_ insets: CGFloat) -> InsetsConvertible {
    return UIHorizontalInsets(insets: insets)
}

public func vInsets(_ insets: CGFloat) -> InsetsConvertible {
    return UIVerticalInsets(insets: insets)
}

public func hInsets(left: CGFloat, right: CGFloat) -> InsetsConvertible {
    return UIHorizontalInsets(left: left, right: right)
}

public func vInsets(top: CGFloat, bottom: CGFloat) -> InsetsConvertible {
    return UIVerticalInsets(top: top, bottom: bottom)
}

public extension CGRect {
    func insets(of innerFrame: CGRect) -> UIEdgeInsets {
        let topInset = innerFrame.origin.y
        let leftInset = innerFrame.origin.x
        let maxX = topInset + innerFrame.size.height
        let bottomInset = size.height - maxX
        let maxY = leftInset + innerFrame.size.width
        let rightInset = size.width - maxY
        return UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    }
}
#endif
