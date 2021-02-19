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
            it("should fit UIActivityIndicatorView") {
                var plan = testableInsertableViewPlan.fitActivityIndicator()
                expect(view.subviews.last).to(equal(plan.view))
                var assignedView: UIActivityIndicatorView?
                plan = testableInsertableViewPlan.fitActivityIndicator(assignTo: &assignedView)
                expect(view.subviews.last).to(equal(assignedView))
                expect(view.subviews.last).to(equal(plan.view))
            }
            it("should fit UIButton") {
                var plan = testableInsertableViewPlan.fitButton()
                expect(view.subviews.last).to(equal(plan.view))
                var assignedView: UIButton?
                plan = testableInsertableViewPlan.fitButton(assignTo: &assignedView)
                expect(view.subviews.last).to(equal(assignedView))
                expect(view.subviews.last).to(equal(plan.view))
            }
            it("should fit UIDatePicker") {
                var plan = testableInsertableViewPlan.fitDatePicker()
                expect(view.subviews.last).to(equal(plan.view))
                var assignedView: UIDatePicker?
                plan = testableInsertableViewPlan.fitDatePicker(assignTo: &assignedView)
                expect(view.subviews.last).to(equal(assignedView))
                expect(view.subviews.last).to(equal(plan.view))
            }
            it("should fit UIPickerView") {
                var plan = testableInsertableViewPlan.fitPicker()
                expect(view.subviews.last).to(equal(plan.view))
                var assignedView: UIPickerView?
                plan = testableInsertableViewPlan.fitPicker(assignTo: &assignedView)
                expect(view.subviews.last).to(equal(assignedView))
                expect(view.subviews.last).to(equal(plan.view))
            }
            it("should fit UIImageView") {
                var plan = testableInsertableViewPlan.fitImageView()
                expect(view.subviews.last).to(equal(plan.view))
                var assignedView: UIImageView?
                plan = testableInsertableViewPlan.fitImageView(assignTo: &assignedView)
                expect(view.subviews.last).to(equal(assignedView))
                expect(view.subviews.last).to(equal(plan.view))
            }
            it("should fit UIPageControl") {
                var plan = testableInsertableViewPlan.fitPageControl()
                expect(view.subviews.last).to(equal(plan.view))
                var assignedView: UIPageControl?
                plan = testableInsertableViewPlan.fitPageControl(assignTo: &assignedView)
                expect(view.subviews.last).to(equal(assignedView))
                expect(view.subviews.last).to(equal(plan.view))
            }
            it("should fit UIProgressView") {
                var plan = testableInsertableViewPlan.fitProgress()
                expect(view.subviews.last).to(equal(plan.view))
                var assignedView: UIProgressView?
                plan = testableInsertableViewPlan.fitProgress(assignTo: &assignedView)
                expect(view.subviews.last).to(equal(assignedView))
                expect(view.subviews.last).to(equal(plan.view))
            }
            it("should fit UISearchBar") {
                var plan = testableInsertableViewPlan.fitSearchBar()
                expect(view.subviews.last).to(equal(plan.view))
                var assignedView: UISearchBar?
                plan = testableInsertableViewPlan.fitSearchBar(assignTo: &assignedView)
                expect(view.subviews.last).to(equal(assignedView))
                expect(view.subviews.last).to(equal(plan.view))
            }
            it("should fit UISearchTextField") {
                guard #available(iOS 13.0, *) else { return }
                var plan = testableInsertableViewPlan.fitSearchField()
                expect(view.subviews.last).to(equal(plan.view))
                var assignedView: UISearchTextField?
                plan = testableInsertableViewPlan.fitSearchField(assignTo: &assignedView)
                expect(view.subviews.last).to(equal(assignedView))
                expect(view.subviews.last).to(equal(plan.view))
            }
            it("should fit UISegmentedControl") {
                var plan = testableInsertableViewPlan.fitSegmentedControl()
                expect(view.subviews.last).to(equal(plan.view))
                var assignedView: UISegmentedControl?
                plan = testableInsertableViewPlan.fitSegmentedControl(assignTo: &assignedView)
                expect(view.subviews.last).to(equal(assignedView))
                expect(view.subviews.last).to(equal(plan.view))
            }
            it("should fit UISlider") {
                var plan = testableInsertableViewPlan.fitSlider()
                expect(view.subviews.last).to(equal(plan.view))
                var assignedView: UISlider?
                plan = testableInsertableViewPlan.fitSlider(assignTo: &assignedView)
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
            it("should fit UIStepper") {
                var plan = testableInsertableViewPlan.fitStepper()
                expect(view.subviews.last).to(equal(plan.view))
                var assignedView: UIStepper?
                plan = testableInsertableViewPlan.fitStepper(assignTo: &assignedView)
                expect(view.subviews.last).to(equal(assignedView))
                expect(view.subviews.last).to(equal(plan.view))
            }
            it("should fit UISwitch") {
                var plan = testableInsertableViewPlan.fitSwitch()
                expect(view.subviews.last).to(equal(plan.view))
                var assignedView: UISwitch?
                plan = testableInsertableViewPlan.fitSwitch(assignTo: &assignedView)
                expect(view.subviews.last).to(equal(assignedView))
                expect(view.subviews.last).to(equal(plan.view))
            }
            it("should fit UITextField") {
                var plan = testableInsertableViewPlan.fitTextField()
                expect(view.subviews.last).to(equal(plan.view))
                var assignedView: UITextField?
                plan = testableInsertableViewPlan.fitTextField(assignTo: &assignedView)
                expect(view.subviews.last).to(equal(assignedView))
                expect(view.subviews.last).to(equal(plan.view))
            }
            it("should fit UITextView") {
                var plan = testableInsertableViewPlan.fitTextView()
                expect(view.subviews.last).to(equal(plan.view))
                var assignedView: UITextView?
                plan = testableInsertableViewPlan.fitTextView(assignTo: &assignedView)
                expect(view.subviews.last).to(equal(assignedView))
                expect(view.subviews.last).to(equal(plan.view))
            }
            it("should fit UIToolbar") {
                var plan = testableInsertableViewPlan.fitToolbar()
                expect(view.subviews.last).to(equal(plan.view))
                var assignedView: UIToolbar?
                plan = testableInsertableViewPlan.fitToolbar(assignTo: &assignedView)
                expect(view.subviews.last).to(equal(assignedView))
                expect(view.subviews.last).to(equal(plan.view))
            }
            it("should fit WKWebView") {
                var plan = testableInsertableViewPlan.fitWebView()
                expect(view.subviews.last).to(equal(plan.view))
                var assignedView: WKWebView?
                plan = testableInsertableViewPlan.fitWebView(assignTo: &assignedView)
                expect(view.subviews.last).to(equal(assignedView))
                expect(view.subviews.last).to(equal(plan.view))
            }
            it("should fit UIScrollView") {
                var plan = testableInsertableViewPlan.fitScroll()
                expect(view.subviews.last).to(equal(plan.view))
                var assignedView: UIScrollView?
                plan = testableInsertableViewPlan.fitScroll(assignTo: &assignedView)
                expect(view.subviews.last).to(equal(assignedView))
                expect(view.subviews.last).to(equal(plan.view))
            }
            it("should fit UITableView") {
                var plan = testableInsertableViewPlan.fitTable()
                expect(view.subviews.last).to(equal(plan.view))
                var assignedView: UITableView?
                plan = testableInsertableViewPlan.fitTable(assignTo: &assignedView)
                expect(view.subviews.last).to(equal(assignedView))
                expect(view.subviews.last).to(equal(plan.view))
            }
            it("should fit UICollectionView") {
                var plan = testableInsertableViewPlan.fitCollection()
                expect(view.subviews.last).to(equal(plan.view))
                var assignedView: UICollectionView?
                plan = testableInsertableViewPlan.fitCollection(assignTo: &assignedView)
                expect(view.subviews.last).to(equal(assignedView))
                expect(view.subviews.last).to(equal(plan.view))
            }
            it("should fit UILabel") {
                var plan = testableInsertableViewPlan.fitLabel()
                expect(view.subviews.last).to(equal(plan.view))
                var assignedView: UILabel?
                plan = testableInsertableViewPlan.fitLabel(assignTo: &assignedView)
                expect(view.subviews.last).to(equal(assignedView))
                expect(view.subviews.last).to(equal(plan.view))
            }
            it("should fit UIVisualEffectView") {
                var plan = testableInsertableViewPlan.fitVisualEffect()
                expect(view.subviews.last).to(equal(plan.view))
                var assignedView: UIVisualEffectView?
                plan = testableInsertableViewPlan.fitVisualEffect(assignTo: &assignedView)
                expect(view.subviews.last).to(equal(assignedView))
                expect(view.subviews.last).to(equal(plan.view))
            }
            it("should fit UINavigationBar") {
                var plan = testableInsertableViewPlan.fitNavigation()
                expect(view.subviews.last).to(equal(plan.view))
                var assignedView: UINavigationBar?
                plan = testableInsertableViewPlan.fitNavigation(assignTo: &assignedView)
                expect(view.subviews.last).to(equal(assignedView))
                expect(view.subviews.last).to(equal(plan.view))
            }
            it("should fit UITabBar") {
                var plan = testableInsertableViewPlan.fitTabBar()
                expect(view.subviews.last).to(equal(plan.view))
                var assignedView: UITabBar?
                plan = testableInsertableViewPlan.fitTabBar(assignTo: &assignedView)
                expect(view.subviews.last).to(equal(assignedView))
                expect(view.subviews.last).to(equal(plan.view))
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
