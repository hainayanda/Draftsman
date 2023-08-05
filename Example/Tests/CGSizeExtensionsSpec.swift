//
//  CGSizeExtensionsSpec.swift
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

class CGSizeExtensionsSpec: QuickSpec {
    
    override func spec() {
        it("should calculate area") {
            expect(CGSize(sides: 2).area).to(equal(4))
        }
        it("should calculate max corner radius") {
            expect(CGSize(width: 2, height: 4).maxCornerRadius).to(equal(1))
        }
        it("should reduced size by insets") {
            expect(CGSize(width: 3, height: 5).reduced(by: .init(edges: 1))).to(equal(CGSize(width: 1, height: 3)))
        }
        it("should enlarged size by insets") {
            expect(CGSize(width: 3, height: 5).enlarged(by: .init(edges: 1))).to(equal(CGSize(width: 5, height: 7)))
        }
        it("should add two size") {
            expect(CGSize(sides: 2) + CGSize(sides: 3)).to(equal(CGSize(sides: 5)))
        }
        it("should add two size") {
            expect(CGSize(sides: 3) - CGSize(sides: 2)).to(equal(CGSize(sides: 1)))
        }
        it("should add two size") {
            expect(CGSize(sides: 2) + 3).to(equal(CGSize(sides: 5)))
        }
        it("should add two size") {
            expect(CGSize(sides: 3) - 2).to(equal(CGSize(sides: 1)))
        }
        it("should add two size") {
            expect(CGSize(sides: 2) * 3).to(equal(CGSize(sides: 6)))
        }
        it("should add two size") {
            expect(CGSize(sides: 6) / 2).to(equal(CGSize(sides: 3)))
        }
        it("should know if size is invalid") {
            let invalidHeight: CGFloat = .random(in: -10 ..< 0)
            let invalidWidth: CGFloat = .random(in: -10 ..< 0)
            let invalidSize1: CGSize = CGSize(width: .random(in: 1..<10), height: invalidHeight)
            let invalidSize2: CGSize = CGSize(width: invalidWidth, height: .random(in: 1..<10))
            let invalidSize3: CGSize = CGSize(width: invalidWidth, height: invalidHeight)
            expect(invalidSize1.isValidUISize).to(beFalse())
            expect(invalidSize2.isValidUISize).to(beFalse())
            expect(invalidSize3.isValidUISize).to(beFalse())
        }
        it("should know if size is valid") {
            expect(CGSize(width: .random(in: 1..<10), height: .random(in: 1..<10)).isValidUISize).to(beTrue())
        }
    }
}
#endif
