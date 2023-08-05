//
//  UIColorExtensionsSpec.swift
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

class UIColorExtensionsSpec: QuickSpec {
    
    // swiftlint:disable function_body_length
    override func spec() {
        it("should produce hex from color") {
            expect(UIColor.white.hex).to(equal("#FFFFFF"))
            expect(UIColor.red.hex).to(equal("#FF0000"))
            expect(UIColor.green.hex).to(equal("#00FF00"))
            expect(UIColor.blue.hex).to(equal("#0000FF"))
            expect(UIColor.black.hex).to(equal("#000000"))
        }
        it("should produce right rgb value") {
            expect(UIColor.white.red).to(equal(1))
            expect(UIColor.white.green).to(equal(1))
            expect(UIColor.white.blue).to(equal(1))
            
            expect(UIColor.red.red).to(equal(1))
            expect(UIColor.red.green).to(equal(0))
            expect(UIColor.red.blue).to(equal(0))
            
            expect(UIColor.green.red).to(equal(0))
            expect(UIColor.green.green).to(equal(1))
            expect(UIColor.green.blue).to(equal(0))
            
            expect(UIColor.blue.red).to(equal(0))
            expect(UIColor.blue.green).to(equal(0))
            expect(UIColor.blue.blue).to(equal(1))
            
            expect(UIColor.black.red).to(equal(0))
            expect(UIColor.black.green).to(equal(0))
            expect(UIColor.black.blue).to(equal(0))
        }
        it("should produce right rgb value") {
            expect(UIColor.white.redInt).to(equal(255))
            expect(UIColor.white.greenInt).to(equal(255))
            expect(UIColor.white.blueInt).to(equal(255))
            
            expect(UIColor.red.redInt).to(equal(255))
            expect(UIColor.red.greenInt).to(equal(0))
            expect(UIColor.red.blueInt).to(equal(0))
            
            expect(UIColor.green.redInt).to(equal(0))
            expect(UIColor.green.greenInt).to(equal(255))
            expect(UIColor.green.blueInt).to(equal(0))
            
            expect(UIColor.blue.redInt).to(equal(0))
            expect(UIColor.blue.greenInt).to(equal(0))
            expect(UIColor.blue.blueInt).to(equal(255))
            
            expect(UIColor.black.redInt).to(equal(0))
            expect(UIColor.black.greenInt).to(equal(0))
            expect(UIColor.black.blueInt).to(equal(0))
        }
        it("should produce right alpha value") {
            expect(UIColor.white.withAlphaComponent(0).alpha).to(equal(0))
            expect(UIColor.white.withAlphaComponent(0.5).alpha).to(equal(0.5))
            expect(UIColor.white.withAlphaComponent(1).alpha).to(equal(1))
        }
        it("should produce right color from hex") {
            expect(UIColor(hex: "#FFFFFF")?.hex).to(equal(UIColor.white.hex))
            expect(UIColor(hex: "FF0000")?.hex).to(equal(UIColor.red.hex))
            expect(UIColor(hex: "#00FF00")?.hex).to(equal(UIColor.green.hex))
            expect(UIColor(hex: "0000FF")?.hex).to(equal(UIColor.blue.hex))
            expect(UIColor(hex: "#000000")?.hex).to(equal(UIColor.black.hex))
            expect(UIColor(hex: "#00")).to(beNil())
        }
        it("should produce right color from int") {
            expect(UIColor(red: 0xFF, green: 0xFF, blue: 0xFF).hex).to(equal(UIColor.white.hex))
            expect(UIColor(red: 0xFF, green: 0, blue: 0).hex).to(equal(UIColor.red.hex))
            expect(UIColor(red: 0, green: 0xFF, blue: 0).hex).to(equal(UIColor.green.hex))
            expect(UIColor(red: 0, green: 0, blue: 0xFF).hex).to(equal(UIColor.blue.hex))
            expect(UIColor(red: 0, green: 0, blue: 0).hex).to(equal(UIColor.black.hex))
        }
        it("should produce right color from int") {
            expect(UIColor(hex: 0xFFFFFF).hex).to(equal(UIColor.white.hex))
            expect(UIColor(hex: 0xFF0000).hex).to(equal(UIColor.red.hex))
            expect(UIColor(hex: 0x00FF00).hex).to(equal(UIColor.green.hex))
            expect(UIColor(hex: 0x0000FF).hex).to(equal(UIColor.blue.hex))
            expect(UIColor(hex: 0x000000).hex).to(equal(UIColor.black.hex))
        }
    }
    // swiftlint:enable function_body_length
}
#endif
