//
//  CGRectExtensionsSpec.swift
//  Gizmo_Tests
//
//  Created by Nayanda Haberty on 28/07/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Quick
import Nimble
import Draftsman

class CGRectExtensionsSpec: QuickSpec {
    
    override func spec() {
        it("should calculate area") {
            let rect = CGRect(origin: .zero, size: CGSize(width: 4, height: 6))
            expect(rect.area).to(equal(24))
        }
        it("should calculate max corner radius") {
            let rect = CGRect(origin: .zero, size: CGSize(width: 4, height: 6))
            expect(rect.maxCornerRadius).to(equal(2))
        }
        it("should calculate center") {
            let rect = CGRect(origin: .zero, size: CGSize(sides: 4))
            expect(rect.center).to(equal(CGPoint(x: 2, y: 2)))
        }
        it("should calculate centered frame") {
            let rect = CGRect(origin: .zero, size: CGSize(sides: 4))
            let targetSize = CGSize(sides: 2)
            expect(rect.centeredFrame(withSize: targetSize)).to(equal(CGRect(origin: CGPoint(x: 1, y: 1), size: targetSize)))
        }
        it("should calculate outer offsets") {
            let rect = CGRect(origin: .zero, size: CGSize(sides: 4))
            let targetSize = CGSize(sides: 2)
            let innerRect = CGRect(origin: CGPoint(x: 1, y: 1), size: targetSize)
            expect(innerRect.offsets(to: rect)).to(equal(UIEdgeOffsets(edges: 1)))
        }
        it("should calculate inner insets") {
            let rect = CGRect(origin: .zero, size: CGSize(sides: 4))
            let targetSize = CGSize(sides: 2)
            let innerRect = CGRect(origin: CGPoint(x: 1, y: 1), size: targetSize)
            expect(rect.insets(of: innerRect)).to(equal(UIEdgeOffsets(edges: 1)))
        }
        it("should calculate inner frame") {
            let rect = CGRect(origin: .zero, size: CGSize(sides: 4))
            let targetInsets = UIEdgeInsets(edges: 1)
            let targetSize = CGSize(sides: 2)
            expect(rect.innerFrame(insetedBy: targetInsets)).to(equal(CGRect(origin: CGPoint(x: 1, y: 1), size: targetSize)))
        }
        it("should calculate outer frame") {
            let rect = CGRect(origin: CGPoint(x: 1, y: 1), size: CGSize(sides: 2))
            let targetOffsets = UIEdgeInsets(edges: 1)
            expect(rect.enlarged(by: targetOffsets)).to(equal(CGRect(origin: .zero, size: CGSize(sides: 4))))
        }
    }
}
#endif
