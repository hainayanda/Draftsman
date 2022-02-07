//
//  PlanContext.swift
//  Draftsman_Tests
//
//  Created by Nayanda Haberty (ID) on 05/09/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Quick
import Nimble
@testable import Draftsman

class PlanContextSpec: QuickSpec {
    override func spec() {
        describe("plan context") {
            var context: PlanContext!
            beforeEach {
                context = PlanContext(delegate: nil, rootContextView: UIView(), usingViewPlan: false)
            }
            it("should mutating priority") {
                let currentPriority = context.currentPriority.rawValue
                let mutatedPriority = context.mutatingPriority.rawValue
                expect(mutatedPriority).to(equal(currentPriority - 1))
                expect(context.currentPriority.rawValue).to(equal(mutatedPriority))
            }
        }
    }
}
#endif
