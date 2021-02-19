//
//  InsertablePlanSpec.swift
//  Draftsman_Tests
//
//  Created by Nayanda Haberty (ID) on 07/09/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Quick
import Nimble
@testable import Draftsman

class InsertablePlanSpec: QuickSpec {
    override func spec() {
        describe("plan fit behaviour") {
            context("General View") {
                var viewController: UIViewController!
                var view: UIView!
                var testableInsertableViewPlan: TestableInsertableViewPlan<UIView>!
                beforeEach {
                    viewController = .init()
                    view = viewController.view
                    testableInsertableViewPlan = .init(view: view)
                }
                it("should be fit view") {
                    let newView = UIView()
                    let plan = testableInsertableViewPlan.fit(newView)
                    expect(plan.view).to(equal(newView))
                    expect(view.subviews.contains(newView)).to(beTrue())
                    expect(newView.translatesAutoresizingMaskIntoConstraints).to(beFalse())
                }
                it("should be fit view controller") {
                    let newVC = UIViewController()
                    let plan = testableInsertableViewPlan.fit(newVC)
                    expect(plan.view).to(equal(newVC.view))
                    expect(view.subviews.contains(newVC.view)).to(beTrue())
                    expect(newVC.view.translatesAutoresizingMaskIntoConstraints).to(beFalse())
                }
                it("should fit and plan molecule") {
                    var planed: Bool = false
                    let molecule = MockFragment()
                    molecule.didPlanContent = { plan in
                        expect((plan as? LayoutPlan<MockFragment>)?.view)
                            .to(equal(molecule))
                        planed = true
                    }
                    let plan = testableInsertableViewPlan.fit(molecule)
                    expect(plan.view).to(equal(molecule))
                    expect(view.subviews.contains(molecule)).to(beTrue())
                    expect(molecule.translatesAutoresizingMaskIntoConstraints).to(beFalse())
                    expect(planed).to(beTrue())
                }
            }
            context("Stack View") {
                var view: UIStackView!
                var testableInsertableViewPlan: TestableInsertableViewPlan<UIStackView>!
                beforeEach {
                    view = .init()
                    testableInsertableViewPlan = .init(view: view)
                }
                it("should be fit stacked view") {
                    var views: [UIView] = []
                    for _ in 0 ..< Int.random(in: 5..<10) {
                        let view = UIView()
                        views.append(view)
                        testableInsertableViewPlan.fitStacked(view)
                        expect(view.translatesAutoresizingMaskIntoConstraints).to(beFalse())
                    }
                    expect(testableInsertableViewPlan.view.arrangedSubviews).to(equal(views))
                }
                it("should be fit stacked view controller") {
                    var vcs: [UIViewController] = []
                    for _ in 0 ..< Int.random(in: 5..<10) {
                        let vc = UIViewController()
                        vcs.append(vc)
                        testableInsertableViewPlan.fitStacked(vc)
                        expect(vc.view.translatesAutoresizingMaskIntoConstraints).to(beFalse())
                    }
                    expect(testableInsertableViewPlan.view.arrangedSubviews).to(equal(vcs.compactMap { $0.view }))
                }
                it("should be fit stacked molecule") {
                    var molecules: [MockFragment] = []
                    for _ in 0 ..< Int.random(in: 5..<10) {
                        var planed: Bool = false
                        let molecule = MockFragment()
                        molecule.didPlanContent = { plan in
                            expect((plan as? LayoutPlan<MockFragment>)?.view)
                                .to(equal(molecule))
                            planed = true
                        }
                        molecules.append(molecule)
                        testableInsertableViewPlan.fitStacked(molecule)
                        expect(molecule.translatesAutoresizingMaskIntoConstraints).to(beFalse())
                        expect(planed).to(beTrue())
                    }
                    expect(testableInsertableViewPlan.view.arrangedSubviews).to(equal(molecules))
                }
            }
        }
    }
}

class MockFragment: UIView, Fragment {
    var didPlanContent: ((InsertablePlan) -> Void)?
    func planContent(_ plan: InsertablePlan) {
        didPlanContent?(plan)
    }
}
#endif
