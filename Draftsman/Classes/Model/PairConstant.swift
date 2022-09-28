//
//  PairConstant.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 19/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: Protocol

protocol PairConstant {
    var firstConstant: CGFloat { get }
    var secondConstant: CGFloat { get }
}

extension PairConstant {
    @inlinable var negative: PairConstant {
        AgnosticPairConstant(firstConstant: -firstConstant, secondConstant: -secondConstant)
    }
}

// MARK: AgnosticPairConstant

struct AgnosticPairConstant: PairConstant {
    let firstConstant: CGFloat
    let secondConstant: CGFloat
}

// MARK: HorizontalConstant

public typealias HorizontalInsets = HorizontalConstant
public typealias HorizontalOffsets = HorizontalConstant

public struct HorizontalConstant {
    public let leading: CGFloat
    public let trailing: CGFloat
    @inlinable public var left: CGFloat { leading }
    @inlinable public var right: CGFloat { trailing }
    @inlinable public var total: CGFloat { leading + trailing }
    
    @inlinable public init(leading: CGFloat, trailing: CGFloat) {
        self.leading = leading
        self.trailing = trailing
    }
    
    @inlinable public init(left: CGFloat, right: CGFloat) {
        self.leading = left
        self.trailing = right
    }
}

extension HorizontalConstant: PairConstant {
    @inlinable var firstConstant: CGFloat { leading }
    @inlinable var secondConstant: CGFloat { trailing }
}

extension HorizontalConstant: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Int
    
    @inlinable public init(integerLiteral value: Int) {
        self = .init(left: CGFloat(value), right: CGFloat(value))
    }
}

extension HorizontalConstant: ExpressibleByFloatLiteral {
    public typealias FloatLiteralType = Float
    
    @inlinable public init(floatLiteral value: Float) {
        self = .init(left: CGFloat(value), right: CGFloat(value))
    }
}

// MARK: VerticalConstant

public typealias VerticalInsets = HorizontalConstant
public typealias VerticalOffsets = HorizontalConstant

public struct VerticalConstant {
    public let top: CGFloat
    public let bottom: CGFloat
    @inlinable public var total: CGFloat { top + bottom }
    
    @inlinable public init(top: CGFloat, bottom: CGFloat) {
        self.top = top
        self.bottom = bottom
    }
}

extension VerticalConstant: PairConstant {
    @inlinable var firstConstant: CGFloat { top }
    @inlinable var secondConstant: CGFloat { bottom }
}

extension VerticalConstant: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Int
    
    @inlinable public init(integerLiteral value: Int) {
        self = .init(top: CGFloat(value), bottom: CGFloat(value))
    }
}

extension VerticalConstant: ExpressibleByFloatLiteral {
    public typealias FloatLiteralType = Float
    
    @inlinable public init(floatLiteral value: Float) {
        self = .init(top: CGFloat(value), bottom: CGFloat(value))
    }
}

// MARK: AxisConstant

public typealias AxisInsets = CGPoint
public typealias AxisOffsets = CGPoint

extension CGPoint: PairConstant {
    @inlinable var firstConstant: CGFloat { x }
    @inlinable var secondConstant: CGFloat { y }
}

extension CGPoint: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Int
    
    @inlinable public init(integerLiteral value: Int) {
        self = .init(x: CGFloat(value), y: CGFloat(value))
    }
}

extension CGPoint: ExpressibleByFloatLiteral {
    public typealias FloatLiteralType = Float
    
    @inlinable public init(floatLiteral value: Float) {
        self = .init(x: CGFloat(value), y: CGFloat(value))
    }
}
#endif
