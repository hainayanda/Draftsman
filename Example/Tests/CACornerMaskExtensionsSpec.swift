//
//  CACornerMaskExtensionsSpec.swift
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

class CACornerMaskExtensionsSpec: QuickSpec {
    
    override func spec() {
        it("should generate right corners") {
            expect(CACornerMask.topLeft.rawValue).to(equal(0b0001))
            expect(CACornerMask.topRight.rawValue).to(equal(0b0010))
            expect(CACornerMask.bottomLeft.rawValue).to(equal(0b0100))
            expect(CACornerMask.bottomRight.rawValue).to(equal(0b1000))
            expect(CACornerMask.allTop.rawValue).to(equal(0b0011))
            expect(CACornerMask.allLeft.rawValue).to(equal(0b0101))
            expect(CACornerMask.allRight.rawValue).to(equal(0b1010))
            expect(CACornerMask.allBottom.rawValue).to(equal(0b1100))
            expect(CACornerMask.allButTopLeft.rawValue).to(equal(0b1110))
            expect(CACornerMask.allButTopRight.rawValue).to(equal(0b1101))
            expect(CACornerMask.allButBottomLeft.rawValue).to(equal(0b1011))
            expect(CACornerMask.allButBottomRight.rawValue).to(equal(0b0111))
            expect(CACornerMask.all.rawValue).to(equal(0b1111))
        }
    }
}
#endif
