//
//  PairConstraintsCreationSpec.swift
//  Draftsman_Tests
//
//  Created by Nayanda Haberty on 24/05/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Draftsman
import Quick
import Nimble

class PairConstraintsCreationSpec: QuickSpec {
    
    override func spec() {
        var view: UIView!
        var relatedView: UIView!
        beforeEach {
            view = UIView()
            relatedView = UIView()
        }
        context("pair y") {
            var pairs: [NSLayoutYAxisAnchor: NSLayoutYAxisAnchor]!
            var signs: [NSLayoutYAxisAnchor: CGFloat]!
            beforeEach {
                pairs = [
                    view.topAnchor : relatedView.topAnchor,
                    view.bottomAnchor : relatedView.bottomAnchor
                ]
                signs = [
                    view.topAnchor : 1,
                    view.bottomAnchor : -1
                ]
            }
            it("should create equal pair y constraints") {
                let constraints = view.drf.vertical.equal(to: relatedView.drf.vertical).build()
                expect(constraints.count).to(equal(2))
                for constraint in constraints {
                    assertEqual(constraint, pairs)
                    expect(constraint.constant).to(equal(0))
                }
            }
            it("should create equal pair y constraints with offset") {
                let offset = CGFloat.random(in: 1..<50)
                let constraints = view.drf.vertical.equal(to: relatedView.drf.vertical).offset(by: offset).build()
                expect(constraints.count).to(equal(2))
                for constraint in constraints {
                    guard let sign = signs.value(for: constraint.firstAnchor) else {
                        fail()
                        return
                    }
                    assertEqual(constraint, pairs)
                    let deviation = constraint.constant - (offset * sign)
                    expect(deviation).to(equal(0))
                }
            }
            it("should create equal pair y constraints with inset") {
                let inset = CGFloat.random(in: 1..<50)
                let constraints = view.drf.vertical.equal(to: relatedView.drf.vertical).inset(by: inset).build()
                expect(constraints.count).to(equal(2))
                for constraint in constraints {
                    guard let sign = signs.value(for: constraint.firstAnchor) else {
                        fail()
                        return
                    }
                    assertEqual(constraint, pairs)
                    let deviation = constraint.constant + (inset * sign)
                    expect(deviation).to(equal(0))
                }
            }
            it("should create more than pair y constraints") {
                let constraints = view.drf.vertical.moreThan(to: relatedView.drf.vertical).build()
                expect(constraints.count).to(equal(2))
                for constraint in constraints {
                    guard let sign = signs.value(for: constraint.firstAnchor) else {
                        fail()
                        return
                    }
                    assertMoreThan(constraint, pairs, sign)
                    expect(constraint.constant).to(equal(0))
                }
            }
            it("should create more than pair y constraints with offset") {
                let offset = CGFloat.random(in: 1..<50)
                let constraints = view.drf.vertical.moreThan(to: relatedView.drf.vertical).offset(by: offset).build()
                expect(constraints.count).to(equal(2))
                for constraint in constraints {
                    guard let sign = signs.value(for: constraint.firstAnchor) else {
                        fail()
                        return
                    }
                    assertMoreThan(constraint, pairs, sign)
                    let deviation = constraint.constant - (offset * sign)
                    expect(deviation).to(equal(0))
                }
            }
            it("should create more than pair y constraints with inset") {
                let inset = CGFloat.random(in: 1..<50)
                let constraints = view.drf.vertical.moreThan(to: relatedView.drf.vertical).inset(by: inset).build()
                expect(constraints.count).to(equal(2))
                for constraint in constraints {
                    guard let sign = signs.value(for: constraint.firstAnchor) else {
                        fail()
                        return
                    }
                    assertMoreThan(constraint, pairs, sign)
                    let deviation = constraint.constant + (inset * sign)
                    expect(deviation).to(equal(0))
                }
            }
            it("should create less than pair y constraints") {
                let constraints = view.drf.vertical.lessThan(to: relatedView.drf.vertical).build()
                expect(constraints.count).to(equal(2))
                for constraint in constraints {
                    guard let sign = signs.value(for: constraint.firstAnchor) else {
                        fail()
                        return
                    }
                    assertLessThan(constraint, pairs, sign)
                    expect(constraint.constant).to(equal(0))
                }
            }
            it("should create less than pair y constraints with offset") {
                let offset = CGFloat.random(in: 1..<50)
                let constraints = view.drf.vertical.lessThan(to: relatedView.drf.vertical).offset(by: offset).build()
                expect(constraints.count).to(equal(2))
                for constraint in constraints {
                    guard let sign = signs.value(for: constraint.firstAnchor) else {
                        fail()
                        return
                    }
                    assertLessThan(constraint, pairs, sign)
                    let deviation = constraint.constant - (offset * sign)
                    expect(deviation).to(equal(0))
                }
            }
            it("should create less than pair y constraints with inset") {
                let inset = CGFloat.random(in: 1..<50)
                let constraints = view.drf.vertical.lessThan(to: relatedView.drf.vertical).inset(by: inset).build()
                expect(constraints.count).to(equal(2))
                for constraint in constraints {
                    guard let sign = signs.value(for: constraint.firstAnchor) else {
                        fail()
                        return
                    }
                    assertLessThan(constraint, pairs, sign)
                    let deviation = constraint.constant + (inset * sign)
                    expect(deviation).to(equal(0))
                }
            }
        }
        context("pair x") {
            var pairs: [NSLayoutXAxisAnchor: NSLayoutXAxisAnchor]!
            var signs: [NSLayoutXAxisAnchor: CGFloat]!
            beforeEach {
                pairs = [
                    view.leftAnchor : relatedView.leftAnchor,
                    view.rightAnchor : relatedView.rightAnchor
                ]
                signs = [
                    view.leftAnchor : 1,
                    view.rightAnchor : -1
                ]
            }
            it("should create equal pair x constraints") {
                let constraints = view.drf.horizontal.equal(to: relatedView.drf.horizontal).build()
                expect(constraints.count).to(equal(2))
                for constraint in constraints {
                    assertEqual(constraint, pairs)
                    expect(constraint.constant).to(equal(0))
                }
            }
            it("should create equal pair x constraints with offset") {
                let offset = CGFloat.random(in: 1..<50)
                let constraints = view.drf.horizontal.equal(to: relatedView.drf.horizontal).offset(by: offset).build()
                expect(constraints.count).to(equal(2))
                for constraint in constraints {
                    guard let sign = signs.value(for: constraint.firstAnchor) else {
                        fail()
                        return
                    }
                    assertEqual(constraint, pairs)
                    let deviation = constraint.constant - (offset * sign)
                    expect(deviation).to(equal(0))
                }
            }
            it("should create equal pair x constraints with inset") {
                let inset = CGFloat.random(in: 1..<50)
                let constraints = view.drf.horizontal.equal(to: relatedView.drf.horizontal).inset(by: inset).build()
                expect(constraints.count).to(equal(2))
                for constraint in constraints {
                    guard let sign = signs.value(for: constraint.firstAnchor) else {
                        fail()
                        return
                    }
                    assertEqual(constraint, pairs)
                    let deviation = constraint.constant + (inset * sign)
                    expect(deviation).to(equal(0))
                }
            }
            it("should create more than pair x constraints") {
                let constraints = view.drf.horizontal.moreThan(to: relatedView.drf.horizontal).build()
                expect(constraints.count).to(equal(2))
                for constraint in constraints {
                    guard let sign = signs.value(for: constraint.firstAnchor) else {
                        fail()
                        return
                    }
                    assertMoreThan(constraint, pairs, sign)
                    expect(constraint.constant).to(equal(0))
                }
            }
            it("should create more than pair x constraints with offset") {
                let offset = CGFloat.random(in: 1..<50)
                let constraints = view.drf.horizontal.moreThan(to: relatedView.drf.horizontal).offset(by: offset).build()
                expect(constraints.count).to(equal(2))
                for constraint in constraints {
                    guard let sign = signs.value(for: constraint.firstAnchor) else {
                        fail()
                        return
                    }
                    assertMoreThan(constraint, pairs, sign)
                    let deviation = constraint.constant - (offset * sign)
                    expect(deviation).to(equal(0))
                }
            }
            it("should create more than pair x constraints with inset") {
                let inset = CGFloat.random(in: 1..<50)
                let constraints = view.drf.horizontal.moreThan(to: relatedView.drf.horizontal).inset(by: inset).build()
                expect(constraints.count).to(equal(2))
                for constraint in constraints {
                    guard let sign = signs.value(for: constraint.firstAnchor) else {
                        fail()
                        return
                    }
                    assertMoreThan(constraint, pairs, sign)
                    let deviation = constraint.constant + (inset * sign)
                    expect(deviation).to(equal(0))
                }
            }
            it("should create less than pair x constraints") {
                let constraints = view.drf.horizontal.lessThan(to: relatedView.drf.horizontal).build()
                expect(constraints.count).to(equal(2))
                for constraint in constraints {
                    guard let sign = signs.value(for: constraint.firstAnchor) else {
                        fail()
                        return
                    }
                    assertLessThan(constraint, pairs, sign)
                    expect(constraint.constant).to(equal(0))
                }
            }
            it("should create less than pair x constraints with offset") {
                let offset = CGFloat.random(in: 1..<50)
                let constraints = view.drf.horizontal.lessThan(to: relatedView.drf.horizontal).offset(by: offset).build()
                expect(constraints.count).to(equal(2))
                for constraint in constraints {
                    guard let sign = signs.value(for: constraint.firstAnchor) else {
                        fail()
                        return
                    }
                    assertLessThan(constraint, pairs, sign)
                    let deviation = constraint.constant - (offset * sign)
                    expect(deviation).to(equal(0))
                }
            }
            it("should create less than pair x constraints with inset") {
                let inset = CGFloat.random(in: 1..<50)
                let constraints = view.drf.horizontal.lessThan(to: relatedView.drf.horizontal).inset(by: inset).build()
                expect(constraints.count).to(equal(2))
                for constraint in constraints {
                    guard let sign = signs.value(for: constraint.firstAnchor) else {
                        fail()
                        return
                    }
                    assertLessThan(constraint, pairs, sign)
                    let deviation = constraint.constant + (inset * sign)
                    expect(deviation).to(equal(0))
                }
            }
        }
        context("pair localized x") {
            var pairs: [NSLayoutXAxisAnchor: NSLayoutXAxisAnchor]!
            var signs: [NSLayoutXAxisAnchor: CGFloat]!
            beforeEach {
                pairs = [
                    view.leadingAnchor : relatedView.leadingAnchor,
                    view.trailingAnchor : relatedView.trailingAnchor
                ]
                signs = [
                    view.leadingAnchor : 1,
                    view.trailingAnchor : -1
                ]
            }
            it("should create equal pair x constraints") {
                let constraints = view.drf.localizedHorizontal.equal(to: relatedView.drf.localizedHorizontal).build()
                expect(constraints.count).to(equal(2))
                for constraint in constraints {
                    assertEqual(constraint, pairs)
                    expect(constraint.constant).to(equal(0))
                }
            }
            it("should create equal pair x constraints with offset") {
                let offset = CGFloat.random(in: 1..<50)
                let constraints = view.drf.localizedHorizontal.equal(to: relatedView.drf.localizedHorizontal).offset(by: offset).build()
                expect(constraints.count).to(equal(2))
                for constraint in constraints {
                    guard let sign = signs.value(for: constraint.firstAnchor) else {
                        fail()
                        return
                    }
                    assertEqual(constraint, pairs)
                    let deviation = constraint.constant - (offset * sign)
                    expect(deviation).to(equal(0))
                }
            }
            it("should create equal pair x constraints with inset") {
                let inset = CGFloat.random(in: 1..<50)
                let constraints = view.drf.localizedHorizontal.equal(to: relatedView.drf.localizedHorizontal).inset(by: inset).build()
                expect(constraints.count).to(equal(2))
                for constraint in constraints {
                    guard let sign = signs.value(for: constraint.firstAnchor) else {
                        fail()
                        return
                    }
                    assertEqual(constraint, pairs)
                    let deviation = constraint.constant + (inset * sign)
                    expect(deviation).to(equal(0))
                }
            }
            it("should create more than pair x constraints") {
                let constraints = view.drf.localizedHorizontal.moreThan(to: relatedView.drf.localizedHorizontal).build()
                expect(constraints.count).to(equal(2))
                for constraint in constraints {
                    guard let sign = signs.value(for: constraint.firstAnchor) else {
                        fail()
                        return
                    }
                    assertMoreThan(constraint, pairs, sign)
                    expect(constraint.constant).to(equal(0))
                }
            }
            it("should create more than pair x constraints with offset") {
                let offset = CGFloat.random(in: 1..<50)
                let constraints = view.drf.localizedHorizontal.moreThan(to: relatedView.drf.localizedHorizontal).offset(by: offset).build()
                expect(constraints.count).to(equal(2))
                for constraint in constraints {
                    guard let sign = signs.value(for: constraint.firstAnchor) else {
                        fail()
                        return
                    }
                    assertMoreThan(constraint, pairs, sign)
                    let deviation = constraint.constant - (offset * sign)
                    expect(deviation).to(equal(0))
                }
            }
            it("should create more than pair x constraints with inset") {
                let inset = CGFloat.random(in: 1..<50)
                let constraints = view.drf.localizedHorizontal.moreThan(to: relatedView.drf.localizedHorizontal).inset(by: inset).build()
                expect(constraints.count).to(equal(2))
                for constraint in constraints {
                    guard let sign = signs.value(for: constraint.firstAnchor) else {
                        fail()
                        return
                    }
                    assertMoreThan(constraint, pairs, sign)
                    let deviation = constraint.constant + (inset * sign)
                    expect(deviation).to(equal(0))
                }
            }
            it("should create less than pair x constraints") {
                let constraints = view.drf.localizedHorizontal.lessThan(to: relatedView.drf.localizedHorizontal).build()
                expect(constraints.count).to(equal(2))
                for constraint in constraints {
                    guard let sign = signs.value(for: constraint.firstAnchor) else {
                        fail()
                        return
                    }
                    assertLessThan(constraint, pairs, sign)
                    expect(constraint.constant).to(equal(0))
                }
            }
            it("should create less than pair x constraints with offset") {
                let offset = CGFloat.random(in: 1..<50)
                let constraints = view.drf.localizedHorizontal.lessThan(to: relatedView.drf.localizedHorizontal).offset(by: offset).build()
                expect(constraints.count).to(equal(2))
                for constraint in constraints {
                    guard let sign = signs.value(for: constraint.firstAnchor) else {
                        fail()
                        return
                    }
                    assertLessThan(constraint, pairs, sign)
                    let deviation = constraint.constant - (offset * sign)
                    expect(deviation).to(equal(0))
                }
            }
            it("should create less than pair x constraints with inset") {
                let inset = CGFloat.random(in: 1..<50)
                let constraints = view.drf.localizedHorizontal.lessThan(to: relatedView.drf.localizedHorizontal).inset(by: inset).build()
                expect(constraints.count).to(equal(2))
                for constraint in constraints {
                    guard let sign = signs.value(for: constraint.firstAnchor) else {
                        fail()
                        return
                    }
                    assertLessThan(constraint, pairs, sign)
                    let deviation = constraint.constant + (inset * sign)
                    expect(deviation).to(equal(0))
                }
            }
        }
    }
}

fileprivate func assertEqual(_ constraint: NSLayoutConstraint, _ pairs: [NSLayoutYAxisAnchor: NSLayoutYAxisAnchor]) {
    guard let secondAnchor = pairs.value(for: constraint.firstAnchor) else {
        fail()
        return
    }
    expect(secondAnchor).to(equal(constraint.secondAnchor))
    expect(constraint.relation).to(equal(.equal))
}

fileprivate func assertEqual(_ constraint: NSLayoutConstraint, _ pairs: [NSLayoutXAxisAnchor: NSLayoutXAxisAnchor]) {
    guard let secondAnchor = pairs.value(for: constraint.firstAnchor) else {
        fail()
        return
    }
    expect(secondAnchor).to(equal(constraint.secondAnchor))
    expect(constraint.relation).to(equal(.equal))
}

fileprivate func assertMoreThan(_ constraint: NSLayoutConstraint, _ pairs: [NSLayoutYAxisAnchor: NSLayoutYAxisAnchor], _ sign: CGFloat) {
    guard let secondAnchor = pairs.value(for: constraint.firstAnchor) else {
        fail()
        return
    }
    expect(secondAnchor).to(equal(constraint.secondAnchor))
    expect(constraint.relation).to(equal(sign == 1 ? .greaterThanOrEqual : .lessThanOrEqual))
}

fileprivate func assertMoreThan(_ constraint: NSLayoutConstraint, _ pairs: [NSLayoutXAxisAnchor: NSLayoutXAxisAnchor], _ sign: CGFloat) {
    guard let secondAnchor = pairs.value(for: constraint.firstAnchor) else {
        fail()
        return
    }
    expect(secondAnchor).to(equal(constraint.secondAnchor))
    expect(constraint.relation).to(equal(sign == 1 ? .greaterThanOrEqual : .lessThanOrEqual))
}

fileprivate func assertLessThan(_ constraint: NSLayoutConstraint, _ pairs: [NSLayoutYAxisAnchor: NSLayoutYAxisAnchor], _ sign: CGFloat) {
    guard let secondAnchor = pairs.value(for: constraint.firstAnchor) else {
        fail()
        return
    }
    expect(secondAnchor).to(equal(constraint.secondAnchor))
    expect(constraint.relation).to(equal(sign == 1 ? .lessThanOrEqual: .greaterThanOrEqual))
}

fileprivate func assertLessThan(_ constraint: NSLayoutConstraint, _ pairs: [NSLayoutXAxisAnchor: NSLayoutXAxisAnchor], _ sign: CGFloat) {
    guard let secondAnchor = pairs.value(for: constraint.firstAnchor) else {
        fail()
        return
    }
    expect(secondAnchor).to(equal(constraint.secondAnchor))
    expect(constraint.relation).to(equal(sign == 1 ? .lessThanOrEqual: .greaterThanOrEqual))
}

fileprivate extension Dictionary where Key: NSLayoutYAxisAnchor {
    func value(for anchor: NSLayoutAnchor<AnyObject>) -> Value? {
        guard let key = keys.first(where: { $0 == anchor }) else {
            return nil
        }
        return self[key]
    }
}

fileprivate extension Dictionary where Key: NSLayoutXAxisAnchor {
    func value(for anchor: NSLayoutAnchor<AnyObject>) -> Value? {
        guard let key = keys.first(where: { $0 == anchor }) else {
            return nil
        }
        return self[key]
    }
}
#endif
