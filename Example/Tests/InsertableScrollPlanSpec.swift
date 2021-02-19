//
//  InsertableScrollPlan.swift
//  Draftsman_Tests
//
//  Created by Nayanda Haberty (ID) on 18/09/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Quick
import Nimble
@testable import Draftsman

class InsertableScrollPlanSpec: QuickSpec {
    override func spec() {
        describe("insertable helper") {
            var scroll: UIScrollView!
            var testableInsertableViewPlan: TestableInsertableViewPlan<UIScrollView>!
            beforeEach {
                scroll = .init()
                testableInsertableViewPlan = .init(view: scroll)
            }
            it("should fit Vertical UIView") {
                var content: UIView?
                let plan = testableInsertableViewPlan.fitScrollVContentView(assignTo: &content)
                expect(scroll.subviews.last).to(equal(plan.view))
                expect(plan.view).to(equal(content))
            }
            it("should fit Vertical UIView") {
                let plan = testableInsertableViewPlan.fitScrollVContentView()
                expect(scroll.subviews.last).to(equal(plan.view))
            }
            it("should fit Horizontal UIView") {
                var content: UIView?
                let plan = testableInsertableViewPlan.fitScrollHContentView(assignTo: &content)
                expect(scroll.subviews.last).to(equal(plan.view))
                expect(plan.view).to(equal(content))
            }
            it("should fit Horizontal UIView") {
                let plan = testableInsertableViewPlan.fitScrollHContentView()
                expect(scroll.subviews.last).to(equal(plan.view))
            }
        }
    }
}
#endif
