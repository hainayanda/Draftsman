//
//  InsertPlanSpec.swift
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

class InsertPlanSpec: QuickSpec {
    override func spec() {
        describe("plan fit behaviour") {
            context("General View") {
                var viewController: UIViewController!
                var view: UIView!
                beforeEach {
                    viewController = .init()
                    view = viewController.view
                }
                it("should be fit view") {
                    let newView = UIView()
                    view.planContent {
                        newView
                    }
                    expect(view.subviews.contains(newView)).to(beTrue())
                    expect(newView.translatesAutoresizingMaskIntoConstraints).to(beFalse())
                }
                it("should be fit view controller") {
                    let newVC = UIViewController()
                    view.planContent {
                        newVC
                    }
                    expect(view.subviews.contains(newVC.view)).to(beTrue())
                    expect(newVC.view.translatesAutoresizingMaskIntoConstraints).to(beFalse())
                }
                it("should fit and plan molecule") {
                    var planed: Bool = false
                    let molecule = MockFragment()
                    molecule.didPlanContent = {
                        planed = true
                    }
                    view.planContent {
                        molecule
                    }
                    expect(view.subviews.contains(molecule)).to(beTrue())
                    expect(molecule.translatesAutoresizingMaskIntoConstraints).to(beFalse())
                    expect(planed).to(beTrue())
                }
            }
            context("Stack View") {
                var view: UIStackView!
                beforeEach {
                    view = .init()
                }
                it("should be fit stacked view") {
                    var views: [UIView] = []
                    for _ in 0 ..< Int.random(in: 5..<10) {
                        let stackedView = UIView()
                        views.append(stackedView)
                        view.planStackedContent {
                            stackedView
                        }
                    }
                    expect(view.arrangedSubviews).to(equal(views))
                }
                it("should be fit stacked view controller") {
                    var vcs: [UIViewController] = []
                    for _ in 0 ..< Int.random(in: 5..<10) {
                        let vc = UIViewController()
                        vcs.append(vc)
                        view.planStackedContent {
                            vc
                        }
                    }
                    expect(view.arrangedSubviews).to(equal(vcs.compactMap { $0.view }))
                }
                it("should be fit stacked molecule") {
                    var molecules: [MockFragment] = []
                    for _ in 0 ..< Int.random(in: 5..<10) {
                        var planed: Bool = false
                        let molecule = MockFragment()
                        molecule.didPlanContent = {
                            planed = true
                        }
                        molecules.append(molecule)
                        view.planStackedContent {
                            molecule
                        }
                        expect(planed).to(beTrue())
                    }
                    expect(view.arrangedSubviews).to(equal(molecules))
                }
            }
        }
    }
}

class MockFragment: UIView, Fragment {
    var didPlanContent: (() -> Void)?
    var viewPlan: ViewPlan {
        defer {
            didPlanContent?()
        }
        return VoidViewPlan()
    }
}
#endif
