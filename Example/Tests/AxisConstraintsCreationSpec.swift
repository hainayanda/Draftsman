//
//  AxisConstraintsCreationSpec.swift
//  Draftsman_Tests
//
//  Created by Nayanda Haberty on 25/05/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Draftsman
import Quick
import Nimble

struct AxisTestGroup {
    let axis: AxisAnchor<LayoutDraft<UIView>>
    let xAnchor: NSLayoutXAxisAnchor
    let yAnchor: NSLayoutYAxisAnchor
    let xSign: CGFloat
    let ySign: CGFloat
    
    init(axis: AxisAnchor<LayoutDraft<UIView>>, xAnchor: NSLayoutXAxisAnchor, yAnchor: NSLayoutYAxisAnchor, xSign: CGFloat = 1, ySign: CGFloat = 1) {
        self.axis = axis
        self.xAnchor = xAnchor
        self.yAnchor = yAnchor
        self.xSign = xSign
        self.ySign = ySign
    }
}

class AxisConstraintsCreationSpec: QuickSpec {
    
    override func spec() {
        var view: UIView!
        var relationView: UIView!
        beforeEach {
            view = UIView()
            relationView = UIView()
        }
        context("non localized axis") {
            var viewTestGroups: [AxisTestGroup]!
            var relationViewTestGroups: [AxisTestGroup]!
            beforeEach {
                viewTestGroups = [
                    .init(axis: view.drf.top.left, xAnchor: view.leftAnchor, yAnchor: view.topAnchor, xSign: 1, ySign: 1),
                    .init(axis: view.drf.top.right, xAnchor: view.rightAnchor, yAnchor: view.topAnchor, xSign: -1, ySign: 1),
                    .init(axis: view.drf.bottom.left, xAnchor: view.leftAnchor, yAnchor: view.bottomAnchor, xSign: 1, ySign: -1),
                    .init(axis: view.drf.bottom.right, xAnchor: view.rightAnchor, yAnchor: view.bottomAnchor, xSign: -1, ySign: -1),
                    .init(axis: view.drf.center, xAnchor: view.centerXAnchor, yAnchor: view.centerYAnchor, xSign: 1, ySign: 1)
                ]
                relationViewTestGroups = [
                    .init(axis: relationView.drf.top.left, xAnchor: relationView.leftAnchor, yAnchor: relationView.topAnchor),
                    .init(axis: relationView.drf.top.right, xAnchor: relationView.rightAnchor, yAnchor: relationView.topAnchor),
                    .init(axis: relationView.drf.bottom.left, xAnchor: relationView.leftAnchor, yAnchor: relationView.bottomAnchor),
                    .init(axis: relationView.drf.bottom.right, xAnchor: relationView.rightAnchor, yAnchor: relationView.bottomAnchor),
                    .init(axis: relationView.drf.center, xAnchor: relationView.centerXAnchor, yAnchor: relationView.centerYAnchor)
                ]
            }
            it("should create axis equal constraints") {
                for viewGroup in viewTestGroups {
                    for relationGroup in relationViewTestGroups {
                        let constraints = viewGroup.axis.equal(to: relationGroup.axis).build()
                        assertEqual(constraints, viewGroup, relationGroup)
                    }
                }
            }
            it("should create axis moreThan constraints") {
                for viewGroup in viewTestGroups {
                    for relationGroup in relationViewTestGroups {
                        let constraints = viewGroup.axis.moreThan(to: relationGroup.axis).build()
                        assertMoreThan(constraints, viewGroup, relationGroup)
                    }
                }
            }
            it("should create axis lessThan constraints") {
                for viewGroup in viewTestGroups {
                    for relationGroup in relationViewTestGroups {
                        let constraints = viewGroup.axis.lessThan(to: relationGroup.axis).build()
                        assertLessThan(constraints, viewGroup, relationGroup)
                    }
                }
            }
            it("should create axis equal constraints with offset") {
                for viewGroup in viewTestGroups {
                    for relationGroup in relationViewTestGroups {
                        let offset = CGFloat.random(in: 1..<50)
                        let constraints = viewGroup.axis.equal(to: relationGroup.axis).offset(by: offset).build()
                        assertEqual(constraints, viewGroup, relationGroup, offset: offset)
                    }
                }
            }
            it("should create axis moreThan constraints with offset") {
                for viewGroup in viewTestGroups {
                    for relationGroup in relationViewTestGroups {
                        let offset = CGFloat.random(in: 1..<50)
                        let constraints = viewGroup.axis.moreThan(to: relationGroup.axis).offset(by: offset).build()
                        assertMoreThan(constraints, viewGroup, relationGroup, offset: offset)
                    }
                }
            }
            it("should create axis lessThan constraints with offset") {
                for viewGroup in viewTestGroups {
                    for relationGroup in relationViewTestGroups {
                        let offset = CGFloat.random(in: 1..<50)
                        let constraints = viewGroup.axis.lessThan(to: relationGroup.axis).offset(by: offset).build()
                        assertLessThan(constraints, viewGroup, relationGroup, offset: offset)
                    }
                }
            }
            it("should create axis equal constraints with inset") {
                for viewGroup in viewTestGroups {
                    for relationGroup in relationViewTestGroups {
                        let inset = CGFloat.random(in: 1..<50)
                        let constraints = viewGroup.axis.equal(to: relationGroup.axis).inset(by: inset).build()
                        assertEqual(constraints, viewGroup, relationGroup, inset: inset)
                    }
                }
            }
            it("should create axis moreThan constraints with inset") {
                for viewGroup in viewTestGroups {
                    for relationGroup in relationViewTestGroups {
                        let inset = CGFloat.random(in: 1..<50)
                        let constraints = viewGroup.axis.moreThan(to: relationGroup.axis).inset(by: inset).build()
                        assertMoreThan(constraints, viewGroup, relationGroup, inset: inset)
                    }
                }
            }
            it("should create axis lessThan constraints with inset") {
                for viewGroup in viewTestGroups {
                    for relationGroup in relationViewTestGroups {
                        let inset = CGFloat.random(in: 1..<50)
                        let constraints = viewGroup.axis.lessThan(to: relationGroup.axis).inset(by: inset).build()
                        assertLessThan(constraints, viewGroup, relationGroup, inset: inset)
                    }
                }
            }
        }
    }
}

fileprivate func assertEqual(_ constraints: [NSLayoutConstraint], _ viewGroup: AxisTestGroup, _ relationGroup: AxisTestGroup) {
    let yIndex = constraints.count - 1
    let xIndex = yIndex - 1
    let xConstraint = constraints[xIndex]
    let yConstraint = constraints[yIndex]
    expect(xConstraint.firstAnchor).to(equal(viewGroup.xAnchor))
    expect(xConstraint.secondAnchor).to(equal(relationGroup.xAnchor))
    expect(xConstraint.relation).to(equal(.equal))
    expect(yConstraint.firstAnchor).to(equal(viewGroup.yAnchor))
    expect(yConstraint.secondAnchor).to(equal(relationGroup.yAnchor))
    expect(yConstraint.relation).to(equal(.equal))
    expect(yConstraint.constant).to(equal(0))
}

fileprivate func assertMoreThan(_ constraints: [NSLayoutConstraint], _ viewGroup: AxisTestGroup, _ relationGroup: AxisTestGroup) {
    let yIndex = constraints.count - 1
    let xIndex = yIndex - 1
    let xConstraint = constraints[xIndex]
    let yConstraint = constraints[yIndex]
    expect(xConstraint.firstAnchor).to(equal(viewGroup.xAnchor))
    expect(xConstraint.secondAnchor).to(equal(relationGroup.xAnchor))
    expect(xConstraint.relation).to(equal(viewGroup.xSign == 1 ? .greaterThanOrEqual : .lessThanOrEqual))
    expect(yConstraint.firstAnchor).to(equal(viewGroup.yAnchor))
    expect(yConstraint.secondAnchor).to(equal(relationGroup.yAnchor))
    expect(yConstraint.relation).to(equal(viewGroup.ySign == 1 ? .greaterThanOrEqual : .lessThanOrEqual))
    expect(yConstraint.constant).to(equal(0))
}

fileprivate func assertLessThan(_ constraints: [NSLayoutConstraint], _ viewGroup: AxisTestGroup, _ relationGroup: AxisTestGroup) {
    let yIndex = constraints.count - 1
    let xIndex = yIndex - 1
    let xConstraint = constraints[xIndex]
    let yConstraint = constraints[yIndex]
    expect(xConstraint.firstAnchor).to(equal(viewGroup.xAnchor))
    expect(xConstraint.secondAnchor).to(equal(relationGroup.xAnchor))
    expect(xConstraint.relation).to(equal(viewGroup.xSign == 1 ? .lessThanOrEqual : .greaterThanOrEqual))
    expect(yConstraint.firstAnchor).to(equal(viewGroup.yAnchor))
    expect(yConstraint.secondAnchor).to(equal(relationGroup.yAnchor))
    expect(yConstraint.relation).to(equal(viewGroup.ySign == 1 ? .lessThanOrEqual : .greaterThanOrEqual))
    expect(yConstraint.constant).to(equal(0))
}

fileprivate func assertEqual(_ constraints: [NSLayoutConstraint], _ viewGroup: AxisTestGroup, _ relationGroup: AxisTestGroup, offset: CGFloat) {
    let yIndex = constraints.count - 1
    let xIndex = yIndex - 1
    let xConstraint = constraints[xIndex]
    let yConstraint = constraints[yIndex]
    let xDeviation = xConstraint.constant - offset * viewGroup.xSign
    let yDeviation = yConstraint.constant - offset * viewGroup.ySign
    expect(xConstraint.firstAnchor).to(equal(viewGroup.xAnchor))
    expect(xConstraint.secondAnchor).to(equal(relationGroup.xAnchor))
    expect(xConstraint.relation).to(equal(.equal))
    expect(yConstraint.firstAnchor).to(equal(viewGroup.yAnchor))
    expect(yConstraint.secondAnchor).to(equal(relationGroup.yAnchor))
    expect(yConstraint.relation).to(equal(.equal))
    expect(xDeviation).to(equal(0))
    expect(yDeviation).to(equal(0))
}

fileprivate func assertMoreThan(_ constraints: [NSLayoutConstraint], _ viewGroup: AxisTestGroup, _ relationGroup: AxisTestGroup, offset: CGFloat) {
    let yIndex = constraints.count - 1
    let xIndex = yIndex - 1
    let xConstraint = constraints[xIndex]
    let yConstraint = constraints[yIndex]
    let xDeviation = xConstraint.constant - offset * viewGroup.xSign
    let yDeviation = yConstraint.constant - offset * viewGroup.ySign
    expect(xConstraint.firstAnchor).to(equal(viewGroup.xAnchor))
    expect(xConstraint.secondAnchor).to(equal(relationGroup.xAnchor))
    expect(xConstraint.relation).to(equal(viewGroup.xSign == 1 ? .greaterThanOrEqual : .lessThanOrEqual))
    expect(yConstraint.firstAnchor).to(equal(viewGroup.yAnchor))
    expect(yConstraint.secondAnchor).to(equal(relationGroup.yAnchor))
    expect(yConstraint.relation).to(equal(viewGroup.ySign == 1 ? .greaterThanOrEqual : .lessThanOrEqual))
    expect(xDeviation).to(equal(0))
    expect(yDeviation).to(equal(0))
}

fileprivate func assertLessThan(_ constraints: [NSLayoutConstraint], _ viewGroup: AxisTestGroup, _ relationGroup: AxisTestGroup, offset: CGFloat) {
    let yIndex = constraints.count - 1
    let xIndex = yIndex - 1
    let xConstraint = constraints[xIndex]
    let yConstraint = constraints[yIndex]
    let xDeviation = xConstraint.constant - offset * viewGroup.xSign
    let yDeviation = yConstraint.constant - offset * viewGroup.ySign
    expect(xConstraint.firstAnchor).to(equal(viewGroup.xAnchor))
    expect(xConstraint.secondAnchor).to(equal(relationGroup.xAnchor))
    expect(xConstraint.relation).to(equal(viewGroup.xSign == 1 ? .lessThanOrEqual : .greaterThanOrEqual))
    expect(yConstraint.firstAnchor).to(equal(viewGroup.yAnchor))
    expect(yConstraint.secondAnchor).to(equal(relationGroup.yAnchor))
    expect(yConstraint.relation).to(equal(viewGroup.ySign == 1 ? .lessThanOrEqual : .greaterThanOrEqual))
    expect(xDeviation).to(equal(0))
    expect(yDeviation).to(equal(0))
}

fileprivate func assertEqual(_ constraints: [NSLayoutConstraint], _ viewGroup: AxisTestGroup, _ relationGroup: AxisTestGroup, inset: CGFloat) {
    let yIndex = constraints.count - 1
    let xIndex = yIndex - 1
    let xConstraint = constraints[xIndex]
    let yConstraint = constraints[yIndex]
    let xDeviation = xConstraint.constant + (inset * viewGroup.xSign)
    let yDeviation = yConstraint.constant + (inset * viewGroup.ySign)
    expect(xConstraint.firstAnchor).to(equal(viewGroup.xAnchor))
    expect(xConstraint.secondAnchor).to(equal(relationGroup.xAnchor))
    expect(xConstraint.relation).to(equal(.equal))
    expect(yConstraint.firstAnchor).to(equal(viewGroup.yAnchor))
    expect(yConstraint.secondAnchor).to(equal(relationGroup.yAnchor))
    expect(xDeviation).to(equal(0))
    expect(yDeviation).to(equal(0))
}

fileprivate func assertMoreThan(_ constraints: [NSLayoutConstraint], _ viewGroup: AxisTestGroup, _ relationGroup: AxisTestGroup, inset: CGFloat) {
    let yIndex = constraints.count - 1
    let xIndex = yIndex - 1
    let xConstraint = constraints[xIndex]
    let yConstraint = constraints[yIndex]
    let xDeviation = xConstraint.constant + (inset * viewGroup.xSign)
    let yDeviation = yConstraint.constant + (inset * viewGroup.ySign)
    expect(xConstraint.firstAnchor).to(equal(viewGroup.xAnchor))
    expect(xConstraint.secondAnchor).to(equal(relationGroup.xAnchor))
    expect(xConstraint.relation).to(equal(viewGroup.xSign == 1 ? .greaterThanOrEqual : .lessThanOrEqual))
    expect(yConstraint.firstAnchor).to(equal(viewGroup.yAnchor))
    expect(yConstraint.secondAnchor).to(equal(relationGroup.yAnchor))
    expect(yConstraint.relation).to(equal(viewGroup.ySign == 1 ? .greaterThanOrEqual : .lessThanOrEqual))
    expect(xDeviation).to(equal(0))
    expect(yDeviation).to(equal(0))
}

fileprivate func assertLessThan(_ constraints: [NSLayoutConstraint], _ viewGroup: AxisTestGroup, _ relationGroup: AxisTestGroup, inset: CGFloat) {
    let yIndex = constraints.count - 1
    let xIndex = yIndex - 1
    let xConstraint = constraints[xIndex]
    let yConstraint = constraints[yIndex]
    let xDeviation = xConstraint.constant + (inset * viewGroup.xSign)
    let yDeviation = yConstraint.constant + (inset * viewGroup.ySign)
    expect(xConstraint.firstAnchor).to(equal(viewGroup.xAnchor))
    expect(xConstraint.secondAnchor).to(equal(relationGroup.xAnchor))
    expect(xConstraint.relation).to(equal(viewGroup.xSign == 1 ? .lessThanOrEqual : .greaterThanOrEqual))
    expect(yConstraint.firstAnchor).to(equal(viewGroup.yAnchor))
    expect(yConstraint.secondAnchor).to(equal(relationGroup.yAnchor))
    expect(yConstraint.relation).to(equal(viewGroup.ySign == 1 ? .lessThanOrEqual : .greaterThanOrEqual))
    expect(xDeviation).to(equal(0))
    expect(yDeviation).to(equal(0))
}
#endif
