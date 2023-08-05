//
//  UIEdgeExtensionsSpec.swift
//  Gizmo_Tests
//
//  Created by Nayanda Haberty on 29/07/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Quick
import Nimble
import Draftsman

class UIEdgeExtensionsSpec: QuickSpec {
    
    // swiftlint:disable function_body_length
    override func spec() {
        it("should create UIEdgeInsets using one insets") {
            expect(UIEdgeInsets(top: 10)).to(equal(UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)))
            expect(UIEdgeInsets(left: 10)).to(equal(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)))
            expect(UIEdgeInsets(bottom: 10)).to(equal(UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)))
            expect(UIEdgeInsets(right: 10)).to(equal(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)))
            expect(UIEdgeInsets(edges: 10)).to(equal(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)))
            expect(UIEdgeInsets(verticals: 10)).to(equal(UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)))
            expect(UIEdgeInsets(horizontals: 20)).to(equal(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)))
        }
        it("should create UIEdgeInsets using two insets") {
            expect(UIEdgeInsets(top: 10, left: 20)).to(equal(UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 0)))
            expect(UIEdgeInsets(top: 10, bottom: 20)).to(equal(UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)))
            expect(UIEdgeInsets(top: 10, right: 20)).to(equal(UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 20)))
            expect(UIEdgeInsets(top: 10, horizontals: 20)).to(equal(UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)))
            expect(UIEdgeInsets(left: 10, bottom: 20)).to(equal(UIEdgeInsets(top: 0, left: 10, bottom: 20, right: 0)))
            expect(UIEdgeInsets(left: 10, right: 20)).to(equal(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 20)))
            expect(UIEdgeInsets(left: 10, verticals: 20)).to(equal(UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 0)))
            expect(UIEdgeInsets(bottom: 10, right: 20)).to(equal(UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 20)))
            expect(UIEdgeInsets(bottom: 10, horizontals: 20)).to(equal(UIEdgeInsets(top: 0, left: 20, bottom: 10, right: 20)))
            expect(UIEdgeInsets(right: 10, verticals: 20)).to(equal(UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 10)))
            expect(UIEdgeInsets(verticals: 10, horizontals: 20)).to(equal(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)))
        }
        it("should create UIEdgeInsets using three insets") {
            expect(UIEdgeInsets(top: 10, left: 20, bottom: 30)).to(equal(UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 0)))
            expect(UIEdgeInsets(top: 10, left: 20, right: 30)).to(equal(UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 30)))
            expect(UIEdgeInsets(top: 10, bottom: 20, right: 30)).to(equal(UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 30)))
            expect(UIEdgeInsets(top: 10, bottom: 20, horizontals: 30)).to(equal(UIEdgeInsets(top: 10, left: 30, bottom: 20, right: 30)))
            expect(UIEdgeInsets(left: 10, bottom: 20, right: 30)).to(equal(UIEdgeInsets(top: 0, left: 10, bottom: 20, right: 30)))
            expect(UIEdgeInsets(left: 10, right: 20, verticals: 30)).to(equal(UIEdgeInsets(top: 30, left: 10, bottom: 30, right: 20)))
        }
        it("should increase insets by insets") {
            let increased = UIEdgeInsets(edges: 10).increased(by: UIEdgeInsets(edges: 5))
            expect(increased).to(equal(UIEdgeInsets(edges: 15)))
        }
        it("should increase insets by insets") {
            let increased = UIEdgeInsets(edges: 10).increased(by: 5)
            expect(increased).to(equal(UIEdgeInsets(edges: 15)))
        }
        it("should increase insets by insets") {
            let decreased = UIEdgeInsets(edges: 10).decreased(by: UIEdgeInsets(edges: 5))
            expect(decreased).to(equal(UIEdgeInsets(edges: 5)))
        }
        it("should increase insets by insets") {
            let decreased = UIEdgeInsets(edges: 10).decreased(by: 5)
            expect(decreased).to(equal(UIEdgeInsets(edges: 5)))
        }
        it("should do arithmatics operation with two insets") {
            let added = UIEdgeInsets(edges: 10) + UIEdgeInsets(edges: 20)
            let substractedAsArray = UIEdgeInsets(edges: 20) - UIEdgeInsets(edges: 10)
            expect(added).to(equal(UIEdgeInsets(edges: 30)))
            expect(substractedAsArray).to(equal(UIEdgeInsets(edges: 10)))
        }
        it("should do arithmatics operation with cgfloat") {
            let added = UIEdgeInsets(edges: 10) + 20
            let substractedAsArray = UIEdgeInsets(edges: 20) - 10
            let multiplied = UIEdgeInsets(edges: 10) * 2
            let divided = UIEdgeInsets(edges: 20) / 10
            expect(added).to(equal(UIEdgeInsets(edges: 30)))
            expect(substractedAsArray).to(equal(UIEdgeInsets(edges: 10)))
            expect(multiplied).to(equal(UIEdgeInsets(edges: 20)))
            expect(divided).to(equal(UIEdgeInsets(edges: 2)))
        }
    }
    // swiftlint:enable function_body_length
}
#endif
