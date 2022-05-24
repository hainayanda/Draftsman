//
//  SingleConstraintsCreationSpec.swift
//  Draftsman_Tests
//
//  Created by Nayanda Haberty on 24/05/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Draftsman
import Quick
import Nimble

class SingleConstraintsCreationSpec: QuickSpec {
    
    override func spec() {
        var view: UIView!
        var relatedView: UIView!
        beforeEach {
            view = UIView()
            relatedView = UIView()
        }
        context("single y constraints") {
            var viewYAnchors: [NSLayoutYAxisAnchor: SingleAnchor<LayoutDraft<UIView>, NSLayoutYAxisAnchor>]!
            var relatedYAnchors: [NSLayoutYAxisAnchor: SingleAnchor<LayoutDraft<UIView>, NSLayoutYAxisAnchor>]!
            var offsetValue: [NSLayoutYAxisAnchor: CGFloat]!
            beforeEach {
                viewYAnchors = [
                    view.topAnchor: view.drf.top,
                    view.bottomAnchor: view.drf.bottom,
                    view.centerYAnchor: view.drf.centerY
                ]
                relatedYAnchors = [
                    relatedView.topAnchor: relatedView.drf.top,
                    relatedView.bottomAnchor: relatedView.drf.bottom,
                    relatedView.centerYAnchor: relatedView.drf.centerY
                ]
                offsetValue = [
                    view.topAnchor: 1,
                    view.bottomAnchor: -1,
                    view.centerYAnchor: 1
                ]
            }
            it("should create equal y constraints") {
                for viewAnchorPair in viewYAnchors {
                    for (index, relatedAnchorPair) in relatedYAnchors.enumerated() {
                        let constraints = viewAnchorPair.value.equal(to: relatedAnchorPair.value).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertEqual(constraint, viewAnchorPair, relatedAnchorPair)
                        expect(constraint.constant).to(equal(0))
                    }
                }
            }
            it("should create equal y constraints with offset") {
                for viewAnchorPair in viewYAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedYAnchors.enumerated() {
                        let offset = CGFloat.random(in: 0..<100)
                        let constraints = viewAnchorPair.value.equal(to: relatedAnchorPair.value).offset(by: offset).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertEqual(constraint, viewAnchorPair, relatedAnchorPair)
                        let deviation = constraint.constant - (offset * sign)
                        guard deviation == 0 else {
                            fail()
                            return
                        }
                    }
                }
            }
            it("should create equal y constraints with inset") {
                for viewAnchorPair in viewYAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedYAnchors.enumerated() {
                        let inset = CGFloat.random(in: 0..<100)
                        let constraints = viewAnchorPair.value.equal(to: relatedAnchorPair.value).inset(by: inset).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertEqual(constraint, viewAnchorPair, relatedAnchorPair)
                        let deviation = constraint.constant + (inset * sign)
                        guard deviation == 0 else {
                            fail()
                            return
                        }
                    }
                }
            }
            it("should create more than y constraints") {
                for viewAnchorPair in viewYAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedYAnchors.enumerated() {
                        let constraints = viewAnchorPair.value.moreThan(to: relatedAnchorPair.value).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertMoreThan(constraint, viewAnchorPair, relatedAnchorPair, sign)
                        expect(constraint.constant).to(equal(0))
                    }
                }
            }
            it("should create more than y constraints with offset") {
                for viewAnchorPair in viewYAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedYAnchors.enumerated() {
                        let offset = CGFloat.random(in: 0..<100)
                        let constraints = viewAnchorPair.value.moreThan(to: relatedAnchorPair.value).offset(by: offset).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertMoreThan(constraint, viewAnchorPair, relatedAnchorPair, sign)
                        let deviation = constraint.constant - (offset * sign)
                        guard deviation == 0 else {
                            fail()
                            return
                        }
                    }
                }
            }
            it("should create more than y constraints with inset") {
                for viewAnchorPair in viewYAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedYAnchors.enumerated() {
                        let inset = CGFloat.random(in: 0..<100)
                        let constraints = viewAnchorPair.value.moreThan(to: relatedAnchorPair.value).inset(by: inset).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertMoreThan(constraint, viewAnchorPair, relatedAnchorPair, sign)
                        let deviation = constraint.constant + (inset * sign)
                        guard deviation == 0 else {
                            fail()
                            return
                        }
                    }
                }
            }
            it("should create less than y constraints") {
                for viewAnchorPair in viewYAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedYAnchors.enumerated() {
                        let constraints = viewAnchorPair.value.lessThan(to: relatedAnchorPair.value).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertLessThan(constraint, viewAnchorPair, relatedAnchorPair, sign)
                        expect(constraint.constant).to(equal(0))
                    }
                }
            }
            it("should create less than y constraints with offset") {
                for viewAnchorPair in viewYAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedYAnchors.enumerated() {
                        let offset = CGFloat.random(in: 0..<100)
                        let constraints = viewAnchorPair.value.lessThan(to: relatedAnchorPair.value).offset(by: offset).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertLessThan(constraint, viewAnchorPair, relatedAnchorPair, sign)
                        let deviation = constraint.constant - (offset * sign)
                        guard deviation == 0 else {
                            fail()
                            return
                        }
                    }
                }
            }
            it("should create less than y constraints with inset") {
                for viewAnchorPair in viewYAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedYAnchors.enumerated() {
                        let inset = CGFloat.random(in: 0..<100)
                        let constraints = viewAnchorPair.value.lessThan(to: relatedAnchorPair.value).inset(by: inset).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertLessThan(constraint, viewAnchorPair, relatedAnchorPair, sign)
                        let deviation = constraint.constant + (inset * sign)
                        guard deviation == 0 else {
                            fail()
                            return
                        }
                    }
                }
            }
        }
        context("single x constraints") {
            var viewXAnchors: [NSLayoutXAxisAnchor: SingleAnchor<LayoutDraft<UIView>, NSLayoutXAxisAnchor>]!
            var relatedXAnchors: [NSLayoutXAxisAnchor: SingleAnchor<LayoutDraft<UIView>, NSLayoutXAxisAnchor>]!
            var offsetValue: [NSLayoutXAxisAnchor: CGFloat]!
            beforeEach {
                viewXAnchors = [
                    view.leftAnchor: view.drf.left,
                    view.rightAnchor: view.drf.right,
                    view.centerXAnchor: view.drf.centerX
                ]
                relatedXAnchors = [
                    relatedView.leftAnchor: relatedView.drf.left,
                    relatedView.rightAnchor: relatedView.drf.right,
                    relatedView.centerXAnchor: relatedView.drf.centerX
                ]
                offsetValue = [
                    view.leftAnchor: 1,
                    view.rightAnchor: -1,
                    view.centerXAnchor: 1
                ]
            }
            it("should create equal x constraints") {
                for viewAnchorPair in viewXAnchors {
                    for (index, relatedAnchorPair) in relatedXAnchors.enumerated() {
                        let constraints = viewAnchorPair.value.equal(to: relatedAnchorPair.value).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertEqual(constraint, viewAnchorPair, relatedAnchorPair)
                        expect(constraint.constant).to(equal(0))
                    }
                }
            }
            it("should create equal x constraints with offset") {
                for viewAnchorPair in viewXAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedXAnchors.enumerated() {
                        let offset = CGFloat.random(in: 0..<100)
                        let constraints = viewAnchorPair.value.equal(to: relatedAnchorPair.value).offset(by: offset).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertEqual(constraint, viewAnchorPair, relatedAnchorPair)
                        let deviation = constraint.constant - (offset * sign)
                        guard deviation == 0 else {
                            fail()
                            return
                        }
                    }
                }
            }
            it("should create equal x constraints with inset") {
                for viewAnchorPair in viewXAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedXAnchors.enumerated() {
                        let inset = CGFloat.random(in: 0..<100)
                        let constraints = viewAnchorPair.value.equal(to: relatedAnchorPair.value).inset(by: inset).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertEqual(constraint, viewAnchorPair, relatedAnchorPair)
                        let deviation = constraint.constant + (inset * sign)
                        guard deviation == 0 else {
                            fail()
                            return
                        }
                    }
                }
            }
            it("should create more than x constraints") {
                for viewAnchorPair in viewXAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedXAnchors.enumerated() {
                        let constraints = viewAnchorPair.value.moreThan(to: relatedAnchorPair.value).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertMoreThan(constraint, viewAnchorPair, relatedAnchorPair, sign)
                        expect(constraint.constant).to(equal(0))
                    }
                }
            }
            it("should create more than x constraints with offset") {
                for viewAnchorPair in viewXAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedXAnchors.enumerated() {
                        let offset = CGFloat.random(in: 0..<100)
                        let constraints = viewAnchorPair.value.moreThan(to: relatedAnchorPair.value).offset(by: offset).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertMoreThan(constraint, viewAnchorPair, relatedAnchorPair, sign)
                        let deviation = constraint.constant - (offset * sign)
                        guard deviation == 0 else {
                            fail()
                            return
                        }
                    }
                }
            }
            it("should create more than x constraints with inset") {
                for viewAnchorPair in viewXAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedXAnchors.enumerated() {
                        let inset = CGFloat.random(in: 0..<100)
                        let constraints = viewAnchorPair.value.moreThan(to: relatedAnchorPair.value).inset(by: inset).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertMoreThan(constraint, viewAnchorPair, relatedAnchorPair, sign)
                        let deviation = constraint.constant + (inset * sign)
                        guard deviation == 0 else {
                            fail()
                            return
                        }
                    }
                }
            }
            it("should create less than x constraints") {
                for viewAnchorPair in viewXAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedXAnchors.enumerated() {
                        let constraints = viewAnchorPair.value.lessThan(to: relatedAnchorPair.value).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertLessThan(constraint, viewAnchorPair, relatedAnchorPair, sign)
                        expect(constraint.constant).to(equal(0))
                    }
                }
            }
            it("should create less than x constraints with offset") {
                for viewAnchorPair in viewXAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedXAnchors.enumerated() {
                        let offset = CGFloat.random(in: 0..<100)
                        let constraints = viewAnchorPair.value.lessThan(to: relatedAnchorPair.value).offset(by: offset).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertLessThan(constraint, viewAnchorPair, relatedAnchorPair, sign)
                        let deviation = constraint.constant - (offset * sign)
                        guard deviation == 0 else {
                            fail()
                            return
                        }
                    }
                }
            }
            it("should create less than x constraints with inset") {
                for viewAnchorPair in viewXAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedXAnchors.enumerated() {
                        let inset = CGFloat.random(in: 0..<100)
                        let constraints = viewAnchorPair.value.lessThan(to: relatedAnchorPair.value).inset(by: inset).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertLessThan(constraint, viewAnchorPair, relatedAnchorPair, sign)
                        let deviation = constraint.constant + (inset * sign)
                        guard deviation == 0 else {
                            fail()
                            return
                        }
                    }
                }
            }
        }
        context("single local x constraints") {
            var viewXAnchors: [NSLayoutXAxisAnchor: SingleAnchor<LayoutDraft<UIView>, NSLayoutXAxisAnchor>]!
            var relatedXAnchors: [NSLayoutXAxisAnchor: SingleAnchor<LayoutDraft<UIView>, NSLayoutXAxisAnchor>]!
            var offsetValue: [NSLayoutXAxisAnchor: CGFloat]!
            beforeEach {
                viewXAnchors = [
                    view.leadingAnchor: view.drf.leading,
                    view.trailingAnchor: view.drf.trailing,
                    view.centerXAnchor: view.drf.centerX
                ]
                relatedXAnchors = [
                    relatedView.leadingAnchor: relatedView.drf.leading,
                    relatedView.trailingAnchor: relatedView.drf.trailing,
                    relatedView.centerXAnchor: relatedView.drf.centerX
                ]
                offsetValue = [
                    view.leadingAnchor: 1,
                    view.trailingAnchor: -1,
                    view.centerXAnchor: 1
                ]
            }
            it("should create equal x constraints") {
                for viewAnchorPair in viewXAnchors {
                    for (index, relatedAnchorPair) in relatedXAnchors.enumerated() {
                        let constraints = viewAnchorPair.value.equal(to: relatedAnchorPair.value).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertEqual(constraint, viewAnchorPair, relatedAnchorPair)
                        expect(constraint.constant).to(equal(0))
                    }
                }
            }
            it("should create equal x constraints with offset") {
                for viewAnchorPair in viewXAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedXAnchors.enumerated() {
                        let offset = CGFloat.random(in: 0..<100)
                        let constraints = viewAnchorPair.value.equal(to: relatedAnchorPair.value).offset(by: offset).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertEqual(constraint, viewAnchorPair, relatedAnchorPair)
                        let deviation = constraint.constant - (offset * sign)
                        guard deviation == 0 else {
                            fail()
                            return
                        }
                    }
                }
            }
            it("should create equal x constraints with inset") {
                for viewAnchorPair in viewXAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedXAnchors.enumerated() {
                        let inset = CGFloat.random(in: 0..<100)
                        let constraints = viewAnchorPair.value.equal(to: relatedAnchorPair.value).inset(by: inset).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertEqual(constraint, viewAnchorPair, relatedAnchorPair)
                        let deviation = constraint.constant + (inset * sign)
                        guard deviation == 0 else {
                            fail()
                            return
                        }
                    }
                }
            }
            it("should create more than x constraints") {
                for viewAnchorPair in viewXAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedXAnchors.enumerated() {
                        let constraints = viewAnchorPair.value.moreThan(to: relatedAnchorPair.value).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertMoreThan(constraint, viewAnchorPair, relatedAnchorPair, sign)
                        expect(constraint.constant).to(equal(0))
                    }
                }
            }
            it("should create more than x constraints with offset") {
                for viewAnchorPair in viewXAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedXAnchors.enumerated() {
                        let offset = CGFloat.random(in: 0..<100)
                        let constraints = viewAnchorPair.value.moreThan(to: relatedAnchorPair.value).offset(by: offset).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertMoreThan(constraint, viewAnchorPair, relatedAnchorPair, sign)
                        let deviation = constraint.constant - (offset * sign)
                        guard deviation == 0 else {
                            fail()
                            return
                        }
                    }
                }
            }
            it("should create more than x constraints with inset") {
                for viewAnchorPair in viewXAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedXAnchors.enumerated() {
                        let inset = CGFloat.random(in: 0..<100)
                        let constraints = viewAnchorPair.value.moreThan(to: relatedAnchorPair.value).inset(by: inset).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertMoreThan(constraint, viewAnchorPair, relatedAnchorPair, sign)
                        let deviation = constraint.constant + (inset * sign)
                        guard deviation == 0 else {
                            fail()
                            return
                        }
                    }
                }
            }
            it("should create less than x constraints") {
                for viewAnchorPair in viewXAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedXAnchors.enumerated() {
                        let constraints = viewAnchorPair.value.lessThan(to: relatedAnchorPair.value).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertLessThan(constraint, viewAnchorPair, relatedAnchorPair, sign)
                        expect(constraint.constant).to(equal(0))
                    }
                }
            }
            it("should create less than x constraints with offset") {
                for viewAnchorPair in viewXAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedXAnchors.enumerated() {
                        let offset = CGFloat.random(in: 0..<100)
                        let constraints = viewAnchorPair.value.lessThan(to: relatedAnchorPair.value).offset(by: offset).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertLessThan(constraint, viewAnchorPair, relatedAnchorPair, sign)
                        let deviation = constraint.constant - (offset * sign)
                        guard deviation == 0 else {
                            fail()
                            return
                        }
                    }
                }
            }
            it("should create less than x constraints with inset") {
                for viewAnchorPair in viewXAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedXAnchors.enumerated() {
                        let inset = CGFloat.random(in: 0..<100)
                        let constraints = viewAnchorPair.value.lessThan(to: relatedAnchorPair.value).inset(by: inset).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertLessThan(constraint, viewAnchorPair, relatedAnchorPair, sign)
                        let deviation = constraint.constant + (inset * sign)
                        guard deviation == 0 else {
                            fail()
                            return
                        }
                    }
                }
            }
        }
        context("single dimension constraints") {
            var viewXAnchors: [NSLayoutDimension: DimensionAnchor<LayoutDraft<UIView>>]!
            var relatedXAnchors: [NSLayoutDimension: DimensionAnchor<LayoutDraft<UIView>>]!
            var offsetValue: [NSLayoutDimension: CGFloat]!
            beforeEach {
                viewXAnchors = [
                    view.widthAnchor: view.drf.width,
                    view.heightAnchor: view.drf.height
                ]
                relatedXAnchors = [
                    relatedView.widthAnchor: relatedView.drf.width,
                    relatedView.heightAnchor: relatedView.drf.height
                ]
                offsetValue = [
                    view.widthAnchor: 1,
                    view.heightAnchor: 1
                ]
            }
            it("should create equal dimension constraints") {
                for viewAnchorPair in viewXAnchors {
                    for (index, relatedAnchorPair) in relatedXAnchors.enumerated() {
                        let constraints = viewAnchorPair.value.equal(to: relatedAnchorPair.value).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertEqual(constraint, viewAnchorPair, relatedAnchorPair)
                        expect(constraint.constant).to(equal(0))
                    }
                }
            }
            it("should create equal dimension constraints with adder") {
                for viewAnchorPair in viewXAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedXAnchors.enumerated() {
                        let offset = CGFloat.random(in: 0..<100)
                        let constraints = viewAnchorPair.value.equal(to: relatedAnchorPair.value).added(by: offset).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertEqual(constraint, viewAnchorPair, relatedAnchorPair)
                        let deviation = constraint.constant - (offset * sign)
                        guard deviation == 0 else {
                            fail()
                            return
                        }
                    }
                }
            }
            it("should create equal dimension constraints with substractor") {
                for viewAnchorPair in viewXAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedXAnchors.enumerated() {
                        let inset = CGFloat.random(in: 0..<100)
                        let constraints = viewAnchorPair.value.equal(to: relatedAnchorPair.value).substracted(by: inset).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertEqual(constraint, viewAnchorPair, relatedAnchorPair)
                        let deviation = constraint.constant + (inset * sign)
                        guard deviation == 0 else {
                            fail()
                            return
                        }
                    }
                }
            }
            it("should create more than dimension constraints") {
                for viewAnchorPair in viewXAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedXAnchors.enumerated() {
                        let constraints = viewAnchorPair.value.moreThan(to: relatedAnchorPair.value).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertMoreThan(constraint, viewAnchorPair, relatedAnchorPair, sign)
                        expect(constraint.constant).to(equal(0))
                    }
                }
            }
            it("should create more than dimension constraints with adder") {
                for viewAnchorPair in viewXAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedXAnchors.enumerated() {
                        let offset = CGFloat.random(in: 0..<100)
                        let constraints = viewAnchorPair.value.moreThan(to: relatedAnchorPair.value).added(by: offset).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertMoreThan(constraint, viewAnchorPair, relatedAnchorPair, sign)
                        let deviation = constraint.constant - (offset * sign)
                        guard deviation == 0 else {
                            fail()
                            return
                        }
                    }
                }
            }
            it("should create more than dimension constraints with substractor") {
                for viewAnchorPair in viewXAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedXAnchors.enumerated() {
                        let inset = CGFloat.random(in: 0..<100)
                        let constraints = viewAnchorPair.value.moreThan(to: relatedAnchorPair.value).substracted(by: inset).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertMoreThan(constraint, viewAnchorPair, relatedAnchorPair, sign)
                        let deviation = constraint.constant + (inset * sign)
                        guard deviation == 0 else {
                            fail()
                            return
                        }
                    }
                }
            }
            it("should create less than dimension constraints") {
                for viewAnchorPair in viewXAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedXAnchors.enumerated() {
                        let constraints = viewAnchorPair.value.lessThan(to: relatedAnchorPair.value).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertLessThan(constraint, viewAnchorPair, relatedAnchorPair, sign)
                        expect(constraint.constant).to(equal(0))
                    }
                }
            }
            it("should create less than dimension constraints with adder") {
                for viewAnchorPair in viewXAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedXAnchors.enumerated() {
                        let offset = CGFloat.random(in: 0..<100)
                        let constraints = viewAnchorPair.value.lessThan(to: relatedAnchorPair.value).added(by: offset).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertLessThan(constraint, viewAnchorPair, relatedAnchorPair, sign)
                        let deviation = constraint.constant - (offset * sign)
                        guard deviation == 0 else {
                            fail()
                            return
                        }
                    }
                }
            }
            it("should create less than dimension constraints with substractor") {
                for viewAnchorPair in viewXAnchors {
                    let sign = offsetValue[viewAnchorPair.key]!
                    for (index, relatedAnchorPair) in relatedXAnchors.enumerated() {
                        let inset = CGFloat.random(in: 0..<100)
                        let constraints = viewAnchorPair.value.lessThan(to: relatedAnchorPair.value).substracted(by: inset).build()
                        expect(constraints.count).to(equal(index + 1))
                        let constraint = constraints[index]
                        assertLessThan(constraint, viewAnchorPair, relatedAnchorPair, sign)
                        let deviation = constraint.constant + (inset * sign)
                        guard deviation == 0 else {
                            fail()
                            return
                        }
                    }
                }
            }
        }
    }
}

fileprivate func assertEqual<Anchor: LayoutAxisAnchor>(_ constraint: NSLayoutConstraint, _ viewAnchorPair: Dictionary<Anchor, SingleAnchor<LayoutDraft<UIView>, Anchor>>.Element, _ relatedAnchorPair: Dictionary<Anchor, SingleAnchor<LayoutDraft<UIView>, Anchor>>.Element) {
    expect(constraint.firstAnchor).to(equal(viewAnchorPair.key as? NSLayoutAnchor<AnyObject>))
    expect(constraint.secondAnchor).to(equal(relatedAnchorPair.key as? NSLayoutAnchor<AnyObject>))
    expect(constraint.relation).to(equal(.equal))
}

fileprivate func assertMoreThan<Anchor: LayoutAxisAnchor>(_ constraint: NSLayoutConstraint, _ viewAnchorPair: Dictionary<Anchor, SingleAnchor<LayoutDraft<UIView>, Anchor>>.Element, _ relatedAnchorPair: Dictionary<Anchor, SingleAnchor<LayoutDraft<UIView>, Anchor>>.Element, _ sign: CGFloat) {
    expect(constraint.firstAnchor).to(equal(viewAnchorPair.key as? NSLayoutAnchor<AnyObject>))
    expect(constraint.secondAnchor).to(equal(relatedAnchorPair.key as? NSLayoutAnchor<AnyObject>))
    if sign == 1 {
        expect(constraint.relation).to(equal(.greaterThanOrEqual))
    } else {
        expect(constraint.relation).to(equal(.lessThanOrEqual))
    }
}

fileprivate func assertLessThan<Anchor: LayoutAxisAnchor>(_ constraint: NSLayoutConstraint, _ viewAnchorPair: Dictionary<Anchor, SingleAnchor<LayoutDraft<UIView>, Anchor>>.Element, _ relatedAnchorPair: Dictionary<Anchor, SingleAnchor<LayoutDraft<UIView>, Anchor>>.Element, _ sign: CGFloat) {
    expect(constraint.firstAnchor).to(equal(viewAnchorPair.key as? NSLayoutAnchor<AnyObject>))
    expect(constraint.secondAnchor).to(equal(relatedAnchorPair.key as? NSLayoutAnchor<AnyObject>))
    if sign == 1 {
        expect(constraint.relation).to(equal(.lessThanOrEqual))
    } else {
        expect(constraint.relation).to(equal(.greaterThanOrEqual))
    }
}

fileprivate func assertEqual(_ constraint: NSLayoutConstraint, _ viewAnchorPair: Dictionary<NSLayoutDimension, DimensionAnchor<LayoutDraft<UIView>>>.Element, _ relatedAnchorPair: Dictionary<NSLayoutDimension, DimensionAnchor<LayoutDraft<UIView>>>.Element) {
    expect(constraint.firstAnchor).to(equal(viewAnchorPair.key))
    expect(constraint.secondAnchor).to(equal(relatedAnchorPair.key))
    expect(constraint.relation).to(equal(.equal))
}

fileprivate func assertMoreThan(_ constraint: NSLayoutConstraint, _ viewAnchorPair: Dictionary<NSLayoutDimension, DimensionAnchor<LayoutDraft<UIView>>>.Element, _ relatedAnchorPair: Dictionary<NSLayoutDimension, DimensionAnchor<LayoutDraft<UIView>>>.Element, _ sign: CGFloat) {
    expect(constraint.firstAnchor).to(equal(viewAnchorPair.key))
    expect(constraint.secondAnchor).to(equal(relatedAnchorPair.key))
    if sign == 1 {
        expect(constraint.relation).to(equal(.greaterThanOrEqual))
    } else {
        expect(constraint.relation).to(equal(.lessThanOrEqual))
    }
}

fileprivate func assertLessThan(_ constraint: NSLayoutConstraint, _ viewAnchorPair: Dictionary<NSLayoutDimension, DimensionAnchor<LayoutDraft<UIView>>>.Element, _ relatedAnchorPair: Dictionary<NSLayoutDimension, DimensionAnchor<LayoutDraft<UIView>>>.Element, _ sign: CGFloat) {
    expect(constraint.firstAnchor).to(equal(viewAnchorPair.key))
    expect(constraint.secondAnchor).to(equal(relatedAnchorPair.key))
    if sign == 1 {
        expect(constraint.relation).to(equal(.lessThanOrEqual))
    } else {
        expect(constraint.relation).to(equal(.greaterThanOrEqual))
    }
}
