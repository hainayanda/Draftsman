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
    var negative: PairConstant {
        AgnosticPairConstant(firstConstant: -firstConstant, secondConstant: -secondConstant)
    }
}

// MARK: AgnosticPairConstant

struct AgnosticPairConstant: PairConstant {
    let firstConstant: CGFloat
    let secondConstant: CGFloat
}

// MARK: HorizontalConstant

public struct HorizontalConstant {
    public let leading: CGFloat
    public let trailing: CGFloat
    public var total: CGFloat { leading + trailing }
    
    public init(leading: CGFloat, trailing: CGFloat) {
        self.leading = leading
        self.trailing = trailing
    }
    
    public init(left: CGFloat, right: CGFloat) {
        self.leading = left
        self.trailing = right
    }
}

extension HorizontalConstant: PairConstant {
    var firstConstant: CGFloat { leading }
    var secondConstant: CGFloat { trailing }
}

// MARK: VerticalConstant

public struct VerticalConstant {
    public let top: CGFloat
    public let bottom: CGFloat
    public var total: CGFloat { top + bottom }
    
    public init(top: CGFloat, bottom: CGFloat) {
        self.top = top
        self.bottom = bottom
    }
}

extension VerticalConstant: PairConstant {
    var firstConstant: CGFloat { top }
    var secondConstant: CGFloat { bottom }
}

// MARK: AxisConstant

public struct AxisConstant {
    public let xOffset: CGFloat
    public let yOffset: CGFloat
    
    public init(xOffset: CGFloat, yOffset: CGFloat) {
        self.xOffset = xOffset
        self.yOffset = yOffset
    }
}

extension AxisConstant: PairConstant {
    var firstConstant: CGFloat { xOffset }
    var secondConstant: CGFloat { yOffset }
}

extension CGPoint {
    public var axisConstant: AxisConstant {
        .init(xOffset: x, yOffset: y)
    }
}
#endif
