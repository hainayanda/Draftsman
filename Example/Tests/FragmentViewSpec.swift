//
//  FragmentViewSpec.swift
//  Draftsman_Tests
//
//  Created by Nayanda Haberty on 07/06/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Quick
import Nimble
@testable import Draftsman

class FragmentViewSpec: QuickSpec {
    override func spec() {
        describe("fragment view behaviour") {
            var fragment: SpiedFragmentView!
            beforeEach {
                fragment = .init()
            }
            it("should run all lifecycle") {
                var didPlan: Bool = false
                var willPlan: Bool = false
                var planed: Bool = false
                fragment.didPlan = {
                    expect(planed).to(beTrue())
                    expect(willPlan).to(beTrue())
                    didPlan = true
                }
                fragment.willPlan = {
                    expect(planed).to(beFalse())
                    expect(didPlan).to(beFalse())
                    willPlan = true
                }
                fragment.didPlanContent = { _ in
                    expect(willPlan).to(beTrue())
                    expect(didPlan).to(beFalse())
                    planed = true
                }
                fragment.replanContent()
                expect(willPlan).to(beTrue())
                expect(didPlan).to(beTrue())
                expect(planed).to(beTrue())
                didPlan = false
                willPlan = false
                planed = false
                fragment.planFragment()
                expect(willPlan).to(beTrue())
                expect(didPlan).to(beTrue())
                expect(planed).to(beTrue())
            }
            it("should run layout for the first time once") {
                fragment.layoutSubviews()
                expect(fragment.numberOfWillLayoutForTheFirstTimeCalled).to(equal(1))
                expect(fragment.numberOfDidLayoutForTheFirstTimeCalled).to(equal(1))
                fragment.layoutSubviews()
                expect(fragment.numberOfWillLayoutForTheFirstTimeCalled).to(equal(1))
                expect(fragment.numberOfDidLayoutForTheFirstTimeCalled).to(equal(1))
            }
            it("should run all lifecycle when added to view") {
                var didPlan: Bool = false
                var willPlan: Bool = false
                var planed: Bool = false
                fragment.didPlan = {
                    expect(planed).to(beTrue())
                    expect(willPlan).to(beTrue())
                    didPlan = true
                }
                fragment.willPlan = {
                    expect(planed).to(beFalse())
                    expect(didPlan).to(beFalse())
                    willPlan = true
                }
                fragment.didPlanContent = { _ in
                    expect(willPlan).to(beTrue())
                    expect(didPlan).to(beFalse())
                    planed = true
                }
                let view = UIView()
                view.addSubview(fragment)
                expect(willPlan).to(beTrue())
                expect(didPlan).to(beTrue())
                expect(planed).to(beTrue())
                didPlan = false
                willPlan = false
                planed = false
                fragment.planFragment()
                expect(willPlan).to(beTrue())
                expect(didPlan).to(beTrue())
                expect(planed).to(beTrue())
            }
        }
    }
}

class SpiedFragmentView: FragmentView {
    var willPlan: (() -> Void)?
    override func fragmentWillPlanContent() {
        willPlan?()
    }
    var didPlanContent: ((InsertablePlan) -> Void)?
    override func planContent(_ plan: InsertablePlan) {
        didPlanContent?(plan)
    }
    var didPlan: (() -> Void)?
    override func fragmentDidPlanContent() {
        didPlan?()
    }
    var numberOfWillLayoutForTheFirstTimeCalled: Int = 0
    override func fragmentWillLayoutForTheFirstTime() {
        numberOfWillLayoutForTheFirstTimeCalled += 1
        expect(self.numberOfDidLayoutForTheFirstTimeCalled).to(equal(0))
    }
    var numberOfDidLayoutForTheFirstTimeCalled: Int = 0
    override func fragmentDidLayoutForTheFirstTime() {
        numberOfDidLayoutForTheFirstTimeCalled += 1
    }
}
#endif
