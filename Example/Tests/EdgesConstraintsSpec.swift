//
//  EdgesConstraintsSpec.swift
//  Draftsman_Tests
//
//  Created by Nayanda Haberty (ID) on 08/09/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Quick
import Nimble
@testable import Draftsman

class EdgesConstraintsSpec: QuickSpec {
    
    override func spec() {
        describe("view layout behaviour") {
            var view: UIView!
            var otherView: UIView!
            beforeEach {
                view = .init()
                otherView = .init()
            }
            context("explicit") {
                it("should create top constraint") {
                    let constraints = view.plan
                        .top(.equal, to: otherView.topAnchor)
                        .top(.equalTo(12), to: otherView.topAnchor)
                        .top(.moreThan, to: otherView.topAnchor)
                        .top(.moreThanTo(34), to: otherView.topAnchor)
                        .top(.lessThan, to: otherView.topAnchor)
                        .top(.lessThanTo(56), to: otherView.topAnchor)
                        .build()
                    expecting(
                        constraints,
                        haveExpected: view.topAnchor,
                        fromExpected: view,
                        relatedWith: otherView.topAnchor,
                        fromOther: otherView,
                        sign: .positive
                    )
                }
                it("should create left constraint") {
                    let constraints = view.plan
                        .left(.equal, to: otherView.leftAnchor)
                        .left(.equalTo(12), to: otherView.leftAnchor)
                        .left(.moreThan, to: otherView.leftAnchor)
                        .left(.moreThanTo(34), to: otherView.leftAnchor)
                        .left(.lessThan, to: otherView.leftAnchor)
                        .left(.lessThanTo(56), to: otherView.leftAnchor)
                        .build()
                    expecting(
                        constraints,
                        haveExpected: view.leftAnchor,
                        fromExpected: view,
                        relatedWith: otherView.leftAnchor,
                        fromOther: otherView,
                        sign: .positive
                    )
                }
                it("should create bottom constraint") {
                    let constraints = view.plan
                        .bottom(.equal, to: otherView.bottomAnchor)
                        .bottom(.equalTo(12), to: otherView.bottomAnchor)
                        .bottom(.moreThan, to: otherView.bottomAnchor)
                        .bottom(.moreThanTo(34), to: otherView.bottomAnchor)
                        .bottom(.lessThan, to: otherView.bottomAnchor)
                        .bottom(.lessThanTo(56), to: otherView.bottomAnchor)
                        .build()
                    expecting(
                        constraints,
                        haveExpected: view.bottomAnchor,
                        fromExpected: view,
                        relatedWith: otherView.bottomAnchor,
                        fromOther: otherView,
                        sign: .negative
                    )
                }
                it("should create right constraint") {
                    let constraints = view.plan
                        .right(.equal, to: otherView.rightAnchor)
                        .right(.equalTo(12), to: otherView.rightAnchor)
                        .right(.moreThan, to: otherView.rightAnchor)
                        .right(.moreThanTo(34), to: otherView.rightAnchor)
                        .right(.lessThan, to: otherView.rightAnchor)
                        .right(.lessThanTo(56), to: otherView.rightAnchor)
                        .build()
                    expecting(
                        constraints,
                        haveExpected: view.rightAnchor,
                        fromExpected: view,
                        relatedWith: otherView.rightAnchor,
                        fromOther: otherView,
                        sign: .negative
                    )
                }
            }
            context("anonymous") {
                var context: PlanContext!
                var plan: LayoutScheme<UIView>!
                beforeEach {
                    context = PlanContext(delegate: nil, rootContextView: otherView, usingViewPlan: false)
                    context.currentView = view
                    plan = view.plan
                    plan.context = context
                }
                it("should create top constraint") {
                    let constraints = plan
                        .top(.equal, to: .previous)
                        .top(.equalTo(12), to: .previous)
                        .top(.moreThan, to: .previous)
                        .top(.moreThanTo(34), to: .previous)
                        .top(.lessThan, to: .previous)
                        .top(.lessThanTo(56), to: .previous)
                        .build()
                    expecting(
                        constraints,
                        haveExpected: view.topAnchor,
                        fromExpected: view,
                        relatedWith: otherView.topAnchor,
                        fromOther: otherView,
                        sign: .positive
                    )
                }
                it("should create left constraint") {
                    let constraints = plan
                        .left(.equal, to: .previous)
                        .left(.equalTo(12), to: .previous)
                        .left(.moreThan, to: .previous)
                        .left(.moreThanTo(34), to: .previous)
                        .left(.lessThan, to: .previous)
                        .left(.lessThanTo(56), to: .previous)
                        .build()
                    expecting(
                        constraints,
                        haveExpected: view.leftAnchor,
                        fromExpected: view,
                        relatedWith: otherView.leftAnchor,
                        fromOther: otherView,
                        sign: .positive
                    )
                }
                it("should create bottom constraint") {
                    let constraints = plan
                        .bottom(.equal, to: .previous)
                        .bottom(.equalTo(12), to: .previous)
                        .bottom(.moreThan, to: .previous)
                        .bottom(.moreThanTo(34), to: .previous)
                        .bottom(.lessThan, to: .previous)
                        .bottom(.lessThanTo(56), to: .previous)
                        .build()
                    expecting(
                        constraints,
                        haveExpected: view.bottomAnchor,
                        fromExpected: view,
                        relatedWith: otherView.bottomAnchor,
                        fromOther: otherView,
                        sign: .negative
                    )
                }
                it("should create right constraint") {
                    let constraints = plan
                        .right(.equal, to: .previous)
                        .right(.equalTo(12), to: .previous)
                        .right(.moreThan, to: .previous)
                        .right(.moreThanTo(34), to: .previous)
                        .right(.lessThan, to: .previous)
                        .right(.lessThanTo(56), to: .previous)
                        .build()
                    expecting(
                        constraints,
                        haveExpected: view.rightAnchor,
                        fromExpected: view,
                        relatedWith: otherView.rightAnchor,
                        fromOther: otherView,
                        sign: .negative
                    )
                }
            }
        }
    }
}

func expecting<AnchorType: AnyObject, Anchor: NSLayoutAnchor<AnchorType>>(
    _ constraints: [NSLayoutConstraint],
    haveExpected expectedAnchor: Anchor,
    fromExpected expectedView: UIView,
    relatedWith otherAnchor: Anchor,
    fromOther otherView: UIView,
    sign: NumberSign) {
    expect(constraints.count).to(equal(6))
    expect(constraints[0].firstItem as? UIView).to(equal(expectedView))
    expect(constraints[0].firstAnchor).to(equal(expectedAnchor))
    expect(constraints[0].relation).to(equal(.equal))
    expect(constraints[0].secondItem as? UIView).to(equal(otherView))
    expect(constraints[0].secondAnchor).to(equal(otherAnchor))
    expect(constraints[0].constant).to(equal(0))
    expect(constraints[1].firstItem as? UIView).to(equal(expectedView))
    expect(constraints[1].firstAnchor).to(equal(expectedAnchor))
    expect(constraints[1].relation).to(equal(.equal))
    expect(constraints[1].secondItem as? UIView).to(equal(otherView))
    expect(constraints[1].secondAnchor).to(equal(otherAnchor))
    expect(constraints[1].constant).to(equal(sign.convert(12)))
    expect(constraints[2].firstItem as? UIView).to(equal(expectedView))
    expect(constraints[2].firstAnchor).to(equal(expectedAnchor))
    if sign == .positive {
        expect(constraints[2].relation).to(equal(.greaterThanOrEqual))
    } else {
        expect(constraints[2].relation).to(equal(.lessThanOrEqual))
    }
    expect(constraints[2].secondItem as? UIView).to(equal(otherView))
    expect(constraints[2].secondAnchor).to(equal(otherAnchor))
    expect(constraints[2].constant).to(equal(0))
    expect(constraints[3].firstItem as? UIView).to(equal(expectedView))
    expect(constraints[3].firstAnchor).to(equal(expectedAnchor))
    if sign == .positive {
        expect(constraints[3].relation).to(equal(.greaterThanOrEqual))
    } else {
        expect(constraints[3].relation).to(equal(.lessThanOrEqual))
    }
    expect(constraints[3].secondItem as? UIView).to(equal(otherView))
    expect(constraints[3].secondAnchor).to(equal(otherAnchor))
    expect(constraints[3].constant).to(equal(sign.convert(34)))
    expect(constraints[4].firstItem as? UIView).to(equal(expectedView))
    expect(constraints[4].firstAnchor).to(equal(expectedAnchor))
    if sign == .negative {
        expect(constraints[4].relation).to(equal(.greaterThanOrEqual))
    } else {
        expect(constraints[4].relation).to(equal(.lessThanOrEqual))
    }
    expect(constraints[4].secondItem as? UIView).to(equal(otherView))
    expect(constraints[4].secondAnchor).to(equal(otherAnchor))
    expect(constraints[4].constant).to(equal(0))
    expect(constraints[5].firstItem as? UIView).to(equal(expectedView))
    expect(constraints[5].firstAnchor).to(equal(expectedAnchor))
    if sign == .negative {
        expect(constraints[5].relation).to(equal(.greaterThanOrEqual))
    } else {
        expect(constraints[5].relation).to(equal(.lessThanOrEqual))
    }
    expect(constraints[5].secondItem as? UIView).to(equal(otherView))
    expect(constraints[5].secondAnchor).to(equal(otherAnchor))
    expect(constraints[5].constant).to(equal(sign.convert(56)))
}
#endif
