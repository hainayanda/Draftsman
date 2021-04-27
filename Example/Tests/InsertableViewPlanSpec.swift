//
//  InsertableViewPlanSpec.swift
//  Draftsman_Tests
//
//  Created by Nayanda Haberty (ID) on 07/09/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import WebKit
import UIKit
import Quick
import Nimble
@testable import Draftsman

class InsertableViewPlanSpec: QuickSpec {
    override func spec() {
        describe("Insertable view plan helper") {
            var view: UIView!
            var testableInsertableViewPlan: TestableInsertableViewPlan<UIView>!
            beforeEach {
                view = .init()
                testableInsertableViewPlan = .init(view: view)
            }
            it("should fit UIView") {
                var plan = testableInsertableViewPlan.fitView()
                expect(view.subviews.last).to(equal(plan.view))
                var assignedView: UIView?
                plan = testableInsertableViewPlan.fitView(assignTo: &assignedView)
                expect(view.subviews.last).to(equal(assignedView))
                expect(view.subviews.last).to(equal(plan.view))
            }
            it("should fit UIStackView") {
                var plan = testableInsertableViewPlan.fitStack()
                expect(view.subviews.last).to(equal(plan.view))
                var assignedView: UIStackView?
                plan = testableInsertableViewPlan.fitStack(assignTo: &assignedView)
                expect(view.subviews.last).to(equal(assignedView))
                expect(view.subviews.last).to(equal(plan.view))
                
                plan = testableInsertableViewPlan.fitVStack()
                expect(view.subviews.last).to(equal(plan.view))
                expect(plan.view.axis).to(equal(.vertical))
                plan = testableInsertableViewPlan.fitVStack(assignTo: &assignedView)
                expect(view.subviews.last).to(equal(assignedView))
                expect(view.subviews.last).to(equal(plan.view))
                expect(assignedView?.axis).to(equal(.vertical))
                
                plan = testableInsertableViewPlan.fitHStack()
                expect(view.subviews.last).to(equal(plan.view))
                expect(plan.view.axis).to(equal(.horizontal))
                plan = testableInsertableViewPlan.fitHStack(assignTo: &assignedView)
                expect(view.subviews.last).to(equal(assignedView))
                expect(view.subviews.last).to(equal(plan.view))
                expect(assignedView?.axis).to(equal(.horizontal))
            }
        }
    }
}

class TestableInsertableViewPlan<View: UIView>: InsertableViewPlan {
    var fittedPlans: [Plan] = []
    lazy var context: PlanContext = .init(currentView: view)
    var view: View
    
    init(view: View) {
        self.view = view
    }
}
#endif
