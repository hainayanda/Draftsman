//
//  InsertableStackPlanSpec.swift
//  Draftsman_Tests
//
//  Created by Nayanda Haberty (ID) on 08/09/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import WebKit
import UIKit
import Quick
import Nimble
@testable import Draftsman

class InsertableStackPlanSpec: QuickSpec {
    override func spec() {
        describe("InsertablaPlan stack helper") {
            var view: UIStackView!
            var testableInsertableViewPlan: TestableInsertableViewPlan<UIStackView>!
            beforeEach {
                view = .init()
                testableInsertableViewPlan = .init(view: view)
            }
            it("should fit stacked UIView") {
                var plan = testableInsertableViewPlan.fitStackedView()
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                var assignedView: UIView?
                plan = testableInsertableViewPlan.fitStackedView(assignTo: &assignedView)
                expect(view.arrangedSubviews.last).to(equal(assignedView))
                expect(view.arrangedSubviews.last).to(equal(plan.view))
            }
            it("should fit stacked UIActivityIndicatorView") {
                var plan = testableInsertableViewPlan.fitStackedActivityIndicator()
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                var assignedView: UIActivityIndicatorView?
                plan = testableInsertableViewPlan.fitStackedActivityIndicator(assignTo: &assignedView)
                expect(view.arrangedSubviews.last).to(equal(assignedView))
                expect(view.arrangedSubviews.last).to(equal(plan.view))
            }
            it("should fit stacked UIButton") {
                var plan = testableInsertableViewPlan.fitStackedButton()
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                var assignedView: UIButton?
                plan = testableInsertableViewPlan.fitStackedButton(assignTo: &assignedView)
                expect(view.arrangedSubviews.last).to(equal(assignedView))
                expect(view.arrangedSubviews.last).to(equal(plan.view))
            }
            it("should fit stacked UIDatePicker") {
                var plan = testableInsertableViewPlan.fitStackedDatePicker()
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                var assignedView: UIDatePicker?
                plan = testableInsertableViewPlan.fitStackedDatePicker(assignTo: &assignedView)
                expect(view.arrangedSubviews.last).to(equal(assignedView))
                expect(view.arrangedSubviews.last).to(equal(plan.view))
            }
            it("should fit stacked UIPickerView") {
                var plan = testableInsertableViewPlan.fitStackedPicker()
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                var assignedView: UIPickerView?
                plan = testableInsertableViewPlan.fitStackedPicker(assignTo: &assignedView)
                expect(view.arrangedSubviews.last).to(equal(assignedView))
                expect(view.arrangedSubviews.last).to(equal(plan.view))
            }
            it("should fit stacked UIImageView") {
                var plan = testableInsertableViewPlan.fitStackedImageView()
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                var assignedView: UIImageView?
                plan = testableInsertableViewPlan.fitStackedImageView(assignTo: &assignedView)
                expect(view.arrangedSubviews.last).to(equal(assignedView))
                expect(view.arrangedSubviews.last).to(equal(plan.view))
            }
            it("should fit stacked UIPageControl") {
                var plan = testableInsertableViewPlan.fitStackedPageControl()
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                var assignedView: UIPageControl?
                plan = testableInsertableViewPlan.fitStackedPageControl(assignTo: &assignedView)
                expect(view.arrangedSubviews.last).to(equal(assignedView))
                expect(view.arrangedSubviews.last).to(equal(plan.view))
            }
            it("should fit stacked UIProgressView") {
                var plan = testableInsertableViewPlan.fitStackedProgress()
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                var assignedView: UIProgressView?
                plan = testableInsertableViewPlan.fitStackedProgress(assignTo: &assignedView)
                expect(view.arrangedSubviews.last).to(equal(assignedView))
                expect(view.arrangedSubviews.last).to(equal(plan.view))
            }
            it("should fit stacked UISearchBar") {
                var plan = testableInsertableViewPlan.fitStackedSearchBar()
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                var assignedView: UISearchBar?
                plan = testableInsertableViewPlan.fitStackedSearchBar(assignTo: &assignedView)
                expect(view.arrangedSubviews.last).to(equal(assignedView))
                expect(view.arrangedSubviews.last).to(equal(plan.view))
            }
            it("should fit stacked UISearchTextField") {
                guard #available(iOS 13.0, *) else { return }
                var plan = testableInsertableViewPlan.fitStackedSearchField()
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                var assignedView: UISearchTextField?
                plan = testableInsertableViewPlan.fitStackedSearchField(assignTo: &assignedView)
                expect(view.arrangedSubviews.last).to(equal(assignedView))
                expect(view.arrangedSubviews.last).to(equal(plan.view))
            }
            it("should fit stacked UISegmentedControl") {
                var plan = testableInsertableViewPlan.fitStackedSegmentedControl()
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                var assignedView: UISegmentedControl?
                plan = testableInsertableViewPlan.fitStackedSegmentedControl(assignTo: &assignedView)
                expect(view.arrangedSubviews.last).to(equal(assignedView))
                expect(view.arrangedSubviews.last).to(equal(plan.view))
            }
            it("should fit stacked UISlider") {
                var plan = testableInsertableViewPlan.fitStackedSlider()
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                var assignedView: UISlider?
                plan = testableInsertableViewPlan.fitStackedSlider(assignTo: &assignedView)
                expect(view.arrangedSubviews.last).to(equal(assignedView))
                expect(view.arrangedSubviews.last).to(equal(plan.view))
            }
            it("should fit stacked UIStackView") {
                var plan = testableInsertableViewPlan.fitStackedStack()
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                var assignedView: UIStackView?
                plan = testableInsertableViewPlan.fitStackedStack(assignTo: &assignedView)
                expect(view.arrangedSubviews.last).to(equal(assignedView))
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                
                plan = testableInsertableViewPlan.fitStackedVStack()
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                expect(plan.view.axis).to(equal(.vertical))
                plan = testableInsertableViewPlan.fitStackedVStack(assignTo: &assignedView)
                expect(view.arrangedSubviews.last).to(equal(assignedView))
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                expect(assignedView?.axis).to(equal(.vertical))
                
                plan = testableInsertableViewPlan.fitStackedHStack()
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                expect(plan.view.axis).to(equal(.horizontal))
                plan = testableInsertableViewPlan.fitStackedHStack(assignTo: &assignedView)
                expect(view.arrangedSubviews.last).to(equal(assignedView))
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                expect(assignedView?.axis).to(equal(.horizontal))
            }
            it("should fit stacked UIStepper") {
                var plan = testableInsertableViewPlan.fitStackedStepper()
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                var assignedView: UIStepper?
                plan = testableInsertableViewPlan.fitStackedStepper(assignTo: &assignedView)
                expect(view.arrangedSubviews.last).to(equal(assignedView))
                expect(view.arrangedSubviews.last).to(equal(plan.view))
            }
            it("should fit stacked UISwitch") {
                var plan = testableInsertableViewPlan.fitStackedSwitch()
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                var assignedView: UISwitch?
                plan = testableInsertableViewPlan.fitStackedSwitch(assignTo: &assignedView)
                expect(view.arrangedSubviews.last).to(equal(assignedView))
                expect(view.arrangedSubviews.last).to(equal(plan.view))
            }
            it("should fit stacked UITextField") {
                var plan = testableInsertableViewPlan.fitStackedTextField()
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                var assignedView: UITextField?
                plan = testableInsertableViewPlan.fitStackedTextField(assignTo: &assignedView)
                expect(view.arrangedSubviews.last).to(equal(assignedView))
                expect(view.arrangedSubviews.last).to(equal(plan.view))
            }
            it("should fit stacked UITextView") {
                var plan = testableInsertableViewPlan.fitStackedTextView()
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                var assignedView: UITextView?
                plan = testableInsertableViewPlan.fitStackedTextView(assignTo: &assignedView)
                expect(view.arrangedSubviews.last).to(equal(assignedView))
                expect(view.arrangedSubviews.last).to(equal(plan.view))
            }
            it("should fit stacked UIToolbar") {
                var plan = testableInsertableViewPlan.fitStackedToolbar()
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                var assignedView: UIToolbar?
                plan = testableInsertableViewPlan.fitStackedToolbar(assignTo: &assignedView)
                expect(view.arrangedSubviews.last).to(equal(assignedView))
                expect(view.arrangedSubviews.last).to(equal(plan.view))
            }
            it("should fit stacked WKWebView") {
                var plan = testableInsertableViewPlan.fitStackedWebView()
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                var assignedView: WKWebView?
                plan = testableInsertableViewPlan.fitStackedWebView(assignTo: &assignedView)
                expect(view.arrangedSubviews.last).to(equal(assignedView))
                expect(view.arrangedSubviews.last).to(equal(plan.view))
            }
            it("should fit stacked UIScrollView") {
                var plan = testableInsertableViewPlan.fitStackedScroll()
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                var assignedView: UIScrollView?
                plan = testableInsertableViewPlan.fitStackedScroll(assignTo: &assignedView)
                expect(view.arrangedSubviews.last).to(equal(assignedView))
                expect(view.arrangedSubviews.last).to(equal(plan.view))
            }
            it("should fit stacked UITableView") {
                var plan = testableInsertableViewPlan.fitStackedTable()
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                var assignedView: UITableView?
                plan = testableInsertableViewPlan.fitStackedTable(assignTo: &assignedView)
                expect(view.arrangedSubviews.last).to(equal(assignedView))
                expect(view.arrangedSubviews.last).to(equal(plan.view))
            }
            it("should fit stacked UICollectionView") {
                var plan = testableInsertableViewPlan.fitStackedCollection()
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                var assignedView: UICollectionView?
                plan = testableInsertableViewPlan.fitStackedCollection(assignTo: &assignedView)
                expect(view.arrangedSubviews.last).to(equal(assignedView))
                expect(view.arrangedSubviews.last).to(equal(plan.view))
            }
            it("should fit stacked UILabel") {
                var plan = testableInsertableViewPlan.fitStackedLabel()
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                var assignedView: UILabel?
                plan = testableInsertableViewPlan.fitStackedLabel(assignTo: &assignedView)
                expect(view.arrangedSubviews.last).to(equal(assignedView))
                expect(view.arrangedSubviews.last).to(equal(plan.view))
            }
            it("should fit stacked UIVisualEffectView") {
                var plan = testableInsertableViewPlan.fitStackedVisualEffect()
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                var assignedView: UIVisualEffectView?
                plan = testableInsertableViewPlan.fitStackedVisualEffect(assignTo: &assignedView)
                expect(view.arrangedSubviews.last).to(equal(assignedView))
                expect(view.arrangedSubviews.last).to(equal(plan.view))
            }
            it("should fit stacked UINavigationBar") {
                var plan = testableInsertableViewPlan.fitStackedNavigation()
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                var assignedView: UINavigationBar?
                plan = testableInsertableViewPlan.fitStackedNavigation(assignTo: &assignedView)
                expect(view.arrangedSubviews.last).to(equal(assignedView))
                expect(view.arrangedSubviews.last).to(equal(plan.view))
            }
            it("should fit stacked UITabBar") {
                var plan = testableInsertableViewPlan.fitStackedTabBar()
                expect(view.arrangedSubviews.last).to(equal(plan.view))
                var assignedView: UITabBar?
                plan = testableInsertableViewPlan.fitStackedTabBar(assignTo: &assignedView)
                expect(view.arrangedSubviews.last).to(equal(assignedView))
                expect(view.arrangedSubviews.last).to(equal(plan.view))
            }
        }
    }
}
#endif
