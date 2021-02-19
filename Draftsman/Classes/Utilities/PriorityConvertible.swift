//
//  PriorityConvertible.swift
//  Draftsman
//
//  Created by Nayanda Haberty (ID) on 30/08/20.
//

import Foundation
#if canImport(UIKit)
import UIKit

extension UILayoutPriority: ExpressibleByFloatLiteral {
    
    public typealias FloatLiteralType = Double
    
    public init(floatLiteral value: Double) {
        self.init(Float(value))
    }
}

extension UILayoutPriority: ExpressibleByIntegerLiteral {
    
    public typealias IntegerLiteralType = Int
    
    public init(integerLiteral value: Int) {
        self.init(Float(value))
    }
    
}
#endif
