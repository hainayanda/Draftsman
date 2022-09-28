//
//  TriConstraintsCreationSpec.swift
//  Draftsman_Tests
//
//  Created by Nayanda Haberty on 30/06/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Draftsman
import Quick
import Nimble

// swiftlint:disable function_body_length type_body_length file_length
class TriConstraintsCreationSpec: QuickSpec {
    override func spec() {
        var view: UIView!
        var relatedView: UIView!
        beforeEach {
            view = UIView()
            relatedView = UIView()
        }
        context("two x one y") {
            describe("equality constraints") {
                it("should create equal constraints") {
                    var constraints = view.drf.top.horizontal.equal(to: relatedView.drf.top.horizontal).build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.topAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.topAnchor))
                    expect(constraints[0].relation).to(equal(.equal))
                    expect(constraints[0].constant).to(equal(0))
                    assertEqualHorizontal(constraints: constraints, for: view, and: relatedView)
                    
                    constraints = view.drf.top.horizontal.equal(to: relatedView.drf.bottom.horizontal).build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.topAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.bottomAnchor))
                    expect(constraints[0].relation).to(equal(.equal))
                    expect(constraints[0].constant).to(equal(0))
                    assertEqualHorizontal(constraints: constraints, for: view, and: relatedView)
                    
                    constraints = view.drf.bottom.horizontal.equal(to: relatedView.drf.bottom.horizontal).build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.bottomAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.bottomAnchor))
                    expect(constraints[0].relation).to(equal(.equal))
                    expect(constraints[0].constant).to(equal(0))
                    assertEqualHorizontal(constraints: constraints, for: view, and: relatedView)
                    
                    constraints = view.drf.bottom.horizontal.equal(to: relatedView.drf.top.horizontal).build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.bottomAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.topAnchor))
                    expect(constraints[0].relation).to(equal(.equal))
                    expect(constraints[0].constant).to(equal(0))
                    assertEqualHorizontal(constraints: constraints, for: view, and: relatedView)
                }
                it("should create equal constraints with constant") {
                    let constant = CGFloat.random(in: 5..<10)
                    var constraints = view.drf.top.horizontal.equal(to: relatedView.drf.top.horizontal)
                        .offset(by: constant)
                        .build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.topAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.topAnchor))
                    expect(constraints[0].relation).to(equal(.equal))
                    expect(constraints[0].constant).to(equal(constant))
                    assertEqualHorizontal(constraints: constraints, for: view, and: relatedView, constant: constant)
                    
                    constraints = view.drf.top.horizontal.equal(to: relatedView.drf.bottom.horizontal)
                        .offset(by: constant)
                        .build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.topAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.bottomAnchor))
                    expect(constraints[0].relation).to(equal(.equal))
                    expect(constraints[0].constant).to(equal(constant))
                    assertEqualHorizontal(constraints: constraints, for: view, and: relatedView, constant: constant)
                    
                    constraints = view.drf.bottom.horizontal.equal(to: relatedView.drf.bottom.horizontal)
                        .offset(by: constant)
                        .build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.bottomAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.bottomAnchor))
                    expect(constraints[0].relation).to(equal(.equal))
                    expect(constraints[0].constant).to(equal(-constant))
                    assertEqualHorizontal(constraints: constraints, for: view, and: relatedView, constant: constant)
                    
                    constraints = view.drf.bottom.horizontal.equal(to: relatedView.drf.top.horizontal)
                        .offset(by: constant)
                        .build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.bottomAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.topAnchor))
                    expect(constraints[0].relation).to(equal(.equal))
                    expect(constraints[0].constant).to(equal(-constant))
                    assertEqualHorizontal(constraints: constraints, for: view, and: relatedView, constant: constant)
                }
            }
            describe("greater than constraints") {
                it("should create greater than constraints") {
                    var constraints = view.drf.top.horizontal.moreThan(to: relatedView.drf.top.horizontal).build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.topAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.topAnchor))
                    expect(constraints[0].relation).to(equal(.greaterThanOrEqual))
                    expect(constraints[0].constant).to(equal(0))
                    assertMoreThanHorizontal(constraints: constraints, for: view, and: relatedView)
                    
                    constraints = view.drf.top.horizontal.moreThan(to: relatedView.drf.bottom.horizontal).build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.topAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.bottomAnchor))
                    expect(constraints[0].relation).to(equal(.greaterThanOrEqual))
                    expect(constraints[0].constant).to(equal(0))
                    assertMoreThanHorizontal(constraints: constraints, for: view, and: relatedView)
                    
                    constraints = view.drf.bottom.horizontal.moreThan(to: relatedView.drf.bottom.horizontal).build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.bottomAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.bottomAnchor))
                    expect(constraints[0].relation).to(equal(.lessThanOrEqual))
                    expect(constraints[0].constant).to(equal(0))
                    assertMoreThanHorizontal(constraints: constraints, for: view, and: relatedView)
                    
                    constraints = view.drf.bottom.horizontal.moreThan(to: relatedView.drf.top.horizontal).build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.bottomAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.topAnchor))
                    expect(constraints[0].relation).to(equal(.lessThanOrEqual))
                    expect(constraints[0].constant).to(equal(0))
                    assertMoreThanHorizontal(constraints: constraints, for: view, and: relatedView)
                }
                it("should create greater than constraints with constant") {
                    let constant = CGFloat.random(in: 5..<10)
                    var constraints = view.drf.top.horizontal.moreThan(to: relatedView.drf.top.horizontal)
                        .offset(by: constant)
                        .build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.topAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.topAnchor))
                    expect(constraints[0].relation).to(equal(.greaterThanOrEqual))
                    expect(constraints[0].constant).to(equal(constant))
                    assertMoreThanHorizontal(constraints: constraints, for: view, and: relatedView, constant: constant)
                    
                    constraints = view.drf.top.horizontal.moreThan(to: relatedView.drf.bottom.horizontal)
                        .offset(by: constant)
                        .build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.topAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.bottomAnchor))
                    expect(constraints[0].relation).to(equal(.greaterThanOrEqual))
                    expect(constraints[0].constant).to(equal(constant))
                    assertMoreThanHorizontal(constraints: constraints, for: view, and: relatedView, constant: constant)
                    
                    constraints = view.drf.bottom.horizontal.moreThan(to: relatedView.drf.bottom.horizontal)
                        .offset(by: constant)
                        .build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.bottomAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.bottomAnchor))
                    expect(constraints[0].relation).to(equal(.lessThanOrEqual))
                    expect(constraints[0].constant).to(equal(-constant))
                    assertMoreThanHorizontal(constraints: constraints, for: view, and: relatedView, constant: constant)
                    
                    constraints = view.drf.bottom.horizontal.moreThan(to: relatedView.drf.top.horizontal)
                        .offset(by: constant)
                        .build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.bottomAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.topAnchor))
                    expect(constraints[0].relation).to(equal(.lessThanOrEqual))
                    expect(constraints[0].constant).to(equal(-constant))
                    assertMoreThanHorizontal(constraints: constraints, for: view, and: relatedView, constant: constant)
                }
            }
            describe("less than constraints") {
                it("should create less than constraints") {
                    var constraints = view.drf.top.horizontal.lessThan(to: relatedView.drf.top.horizontal).build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.topAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.topAnchor))
                    expect(constraints[0].relation).to(equal(.lessThanOrEqual))
                    expect(constraints[0].constant).to(equal(0))
                    assertLessThanHorizontal(constraints: constraints, for: view, and: relatedView)
                    
                    constraints = view.drf.top.horizontal.lessThan(to: relatedView.drf.bottom.horizontal).build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.topAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.bottomAnchor))
                    expect(constraints[0].relation).to(equal(.lessThanOrEqual))
                    expect(constraints[0].constant).to(equal(0))
                    assertLessThanHorizontal(constraints: constraints, for: view, and: relatedView)
                    
                    constraints = view.drf.bottom.horizontal.lessThan(to: relatedView.drf.bottom.horizontal).build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.bottomAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.bottomAnchor))
                    expect(constraints[0].relation).to(equal(.greaterThanOrEqual))
                    expect(constraints[0].constant).to(equal(0))
                    assertLessThanHorizontal(constraints: constraints, for: view, and: relatedView)
                    
                    constraints = view.drf.bottom.horizontal.lessThan(to: relatedView.drf.top.horizontal).build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.bottomAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.topAnchor))
                    expect(constraints[0].relation).to(equal(.greaterThanOrEqual))
                    expect(constraints[0].constant).to(equal(0))
                    assertLessThanHorizontal(constraints: constraints, for: view, and: relatedView)
                }
                it("should create less than constraints with constant") {
                    let constant = CGFloat.random(in: 5..<10)
                    var constraints = view.drf.top.horizontal.lessThan(to: relatedView.drf.top.horizontal)
                        .offset(by: constant)
                        .build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.topAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.topAnchor))
                    expect(constraints[0].relation).to(equal(.lessThanOrEqual))
                    expect(constraints[0].constant).to(equal(constant))
                    assertLessThanHorizontal(constraints: constraints, for: view, and: relatedView, constant: constant)
                    
                    constraints = view.drf.top.horizontal.lessThan(to: relatedView.drf.bottom.horizontal)
                        .offset(by: constant)
                        .build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.topAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.bottomAnchor))
                    expect(constraints[0].relation).to(equal(.lessThanOrEqual))
                    expect(constraints[0].constant).to(equal(constant))
                    assertLessThanHorizontal(constraints: constraints, for: view, and: relatedView, constant: constant)
                    
                    constraints = view.drf.bottom.horizontal.lessThan(to: relatedView.drf.bottom.horizontal)
                        .offset(by: constant)
                        .build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.bottomAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.bottomAnchor))
                    expect(constraints[0].relation).to(equal(.greaterThanOrEqual))
                    expect(constraints[0].constant).to(equal(-constant))
                    assertLessThanHorizontal(constraints: constraints, for: view, and: relatedView, constant: constant)
                    
                    constraints = view.drf.bottom.horizontal.lessThan(to: relatedView.drf.top.horizontal)
                        .offset(by: constant)
                        .build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.bottomAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.topAnchor))
                    expect(constraints[0].relation).to(equal(.greaterThanOrEqual))
                    expect(constraints[0].constant).to(equal(-constant))
                    assertLessThanHorizontal(constraints: constraints, for: view, and: relatedView, constant: constant)
                }
            }
        }
        context("two y one x") {
            describe("equality constraints") {
                it("should create equal constraints") {
                    var constraints = view.drf.left.vertical.equal(to: relatedView.drf.left.vertical).build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.leftAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.leftAnchor))
                    expect(constraints[0].relation).to(equal(.equal))
                    expect(constraints[0].constant).to(equal(0))
                    assertEqualVertical(constraints: constraints, for: view, and: relatedView)
                    
                    constraints = view.drf.left.vertical.equal(to: relatedView.drf.right.vertical).build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.leftAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.rightAnchor))
                    expect(constraints[0].relation).to(equal(.equal))
                    expect(constraints[0].constant).to(equal(0))
                    assertEqualVertical(constraints: constraints, for: view, and: relatedView)
                    
                    constraints = view.drf.right.vertical.equal(to: relatedView.drf.right.vertical).build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.rightAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.rightAnchor))
                    expect(constraints[0].relation).to(equal(.equal))
                    expect(constraints[0].constant).to(equal(0))
                    assertEqualVertical(constraints: constraints, for: view, and: relatedView)
                    
                    constraints = view.drf.right.vertical.equal(to: relatedView.drf.left.vertical).build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.rightAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.leftAnchor))
                    expect(constraints[0].relation).to(equal(.equal))
                    expect(constraints[0].constant).to(equal(0))
                    assertEqualVertical(constraints: constraints, for: view, and: relatedView)
                }
                it("should create equal constraints with constant") {
                    let constant = CGFloat.random(in: 5..<10)
                    var constraints = view.drf.left.vertical.equal(to: relatedView.drf.left.vertical)
                        .offset(by: constant)
                        .build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.leftAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.leftAnchor))
                    expect(constraints[0].relation).to(equal(.equal))
                    expect(constraints[0].constant).to(equal(constant))
                    assertEqualVertical(constraints: constraints, for: view, and: relatedView, constant: constant)
                    
                    constraints = view.drf.left.vertical.equal(to: relatedView.drf.right.vertical)
                        .offset(by: constant)
                        .build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.leftAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.rightAnchor))
                    expect(constraints[0].relation).to(equal(.equal))
                    expect(constraints[0].constant).to(equal(constant))
                    assertEqualVertical(constraints: constraints, for: view, and: relatedView, constant: constant)
                    
                    constraints = view.drf.right.vertical.equal(to: relatedView.drf.right.vertical)
                        .offset(by: constant)
                        .build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.rightAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.rightAnchor))
                    expect(constraints[0].relation).to(equal(.equal))
                    expect(constraints[0].constant).to(equal(-constant))
                    assertEqualVertical(constraints: constraints, for: view, and: relatedView, constant: constant)
                    
                    constraints = view.drf.right.vertical.equal(to: relatedView.drf.left.vertical)
                        .offset(by: constant)
                        .build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.rightAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.leftAnchor))
                    expect(constraints[0].relation).to(equal(.equal))
                    expect(constraints[0].constant).to(equal(-constant))
                    assertEqualVertical(constraints: constraints, for: view, and: relatedView, constant: constant)
                }
            }
            describe("greater than constraints") {
                it("should create greater than constraints") {
                    var constraints = view.drf.left.vertical.moreThan(to: relatedView.drf.left.vertical).build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.leftAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.leftAnchor))
                    expect(constraints[0].relation).to(equal(.greaterThanOrEqual))
                    expect(constraints[0].constant).to(equal(0))
                    assertMoreThanVertical(constraints: constraints, for: view, and: relatedView)
                    
                    constraints = view.drf.left.vertical.moreThan(to: relatedView.drf.right.vertical).build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.leftAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.rightAnchor))
                    expect(constraints[0].relation).to(equal(.greaterThanOrEqual))
                    expect(constraints[0].constant).to(equal(0))
                    assertMoreThanVertical(constraints: constraints, for: view, and: relatedView)
                    
                    constraints = view.drf.right.vertical.moreThan(to: relatedView.drf.right.vertical).build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.rightAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.rightAnchor))
                    expect(constraints[0].relation).to(equal(.lessThanOrEqual))
                    expect(constraints[0].constant).to(equal(0))
                    assertMoreThanVertical(constraints: constraints, for: view, and: relatedView)
                    
                    constraints = view.drf.right.vertical.moreThan(to: relatedView.drf.left.vertical).build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.rightAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.leftAnchor))
                    expect(constraints[0].relation).to(equal(.lessThanOrEqual))
                    expect(constraints[0].constant).to(equal(0))
                    assertMoreThanVertical(constraints: constraints, for: view, and: relatedView)
                }
                it("should create greater than constraints with constant") {
                    let constant = CGFloat.random(in: 5..<10)
                    var constraints = view.drf.left.vertical.moreThan(to: relatedView.drf.left.vertical)
                        .offset(by: constant)
                        .build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.leftAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.leftAnchor))
                    expect(constraints[0].relation).to(equal(.greaterThanOrEqual))
                    expect(constraints[0].constant).to(equal(constant))
                    assertMoreThanVertical(constraints: constraints, for: view, and: relatedView, constant: constant)
                    
                    constraints = view.drf.left.vertical.moreThan(to: relatedView.drf.right.vertical)
                        .offset(by: constant)
                        .build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.leftAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.rightAnchor))
                    expect(constraints[0].relation).to(equal(.greaterThanOrEqual))
                    expect(constraints[0].constant).to(equal(constant))
                    assertMoreThanVertical(constraints: constraints, for: view, and: relatedView, constant: constant)
                    
                    constraints = view.drf.right.vertical.moreThan(to: relatedView.drf.right.vertical)
                        .offset(by: constant)
                        .build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.rightAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.rightAnchor))
                    expect(constraints[0].relation).to(equal(.lessThanOrEqual))
                    expect(constraints[0].constant).to(equal(-constant))
                    assertMoreThanVertical(constraints: constraints, for: view, and: relatedView, constant: constant)
                    
                    constraints = view.drf.right.vertical.moreThan(to: relatedView.drf.left.vertical)
                        .offset(by: constant)
                        .build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.rightAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.leftAnchor))
                    expect(constraints[0].relation).to(equal(.lessThanOrEqual))
                    expect(constraints[0].constant).to(equal(-constant))
                    assertMoreThanVertical(constraints: constraints, for: view, and: relatedView, constant: constant)
                }
            }
            describe("less than constraints") {
                it("should create less than constraints") {
                    var constraints = view.drf.left.vertical.lessThan(to: relatedView.drf.left.vertical).build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.leftAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.leftAnchor))
                    expect(constraints[0].relation).to(equal(.lessThanOrEqual))
                    expect(constraints[0].constant).to(equal(0))
                    assertLessThanVertical(constraints: constraints, for: view, and: relatedView)
                    
                    constraints = view.drf.left.vertical.lessThan(to: relatedView.drf.right.vertical).build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.leftAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.rightAnchor))
                    expect(constraints[0].relation).to(equal(.lessThanOrEqual))
                    expect(constraints[0].constant).to(equal(0))
                    assertLessThanVertical(constraints: constraints, for: view, and: relatedView)
                    
                    constraints = view.drf.right.vertical.lessThan(to: relatedView.drf.right.vertical).build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.rightAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.rightAnchor))
                    expect(constraints[0].relation).to(equal(.greaterThanOrEqual))
                    expect(constraints[0].constant).to(equal(0))
                    assertLessThanVertical(constraints: constraints, for: view, and: relatedView)
                    
                    constraints = view.drf.right.vertical.lessThan(to: relatedView.drf.left.vertical).build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.rightAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.leftAnchor))
                    expect(constraints[0].relation).to(equal(.greaterThanOrEqual))
                    expect(constraints[0].constant).to(equal(0))
                    assertLessThanVertical(constraints: constraints, for: view, and: relatedView)
                }
                it("should create less than constraints with constant") {
                    let constant = CGFloat.random(in: 5..<10)
                    var constraints = view.drf.left.vertical.lessThan(to: relatedView.drf.left.vertical)
                        .offset(by: constant)
                        .build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.leftAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.leftAnchor))
                    expect(constraints[0].relation).to(equal(.lessThanOrEqual))
                    expect(constraints[0].constant).to(equal(constant))
                    assertLessThanVertical(constraints: constraints, for: view, and: relatedView, constant: constant)
                    
                    constraints = view.drf.left.vertical.lessThan(to: relatedView.drf.right.vertical)
                        .offset(by: constant)
                        .build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.leftAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.rightAnchor))
                    expect(constraints[0].relation).to(equal(.lessThanOrEqual))
                    expect(constraints[0].constant).to(equal(constant))
                    assertLessThanVertical(constraints: constraints, for: view, and: relatedView, constant: constant)
                    
                    constraints = view.drf.right.vertical.lessThan(to: relatedView.drf.right.vertical)
                        .offset(by: constant)
                        .build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.rightAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.rightAnchor))
                    expect(constraints[0].relation).to(equal(.greaterThanOrEqual))
                    expect(constraints[0].constant).to(equal(-constant))
                    assertLessThanVertical(constraints: constraints, for: view, and: relatedView, constant: constant)
                    
                    constraints = view.drf.right.vertical.lessThan(to: relatedView.drf.left.vertical)
                        .offset(by: constant)
                        .build()
                    expect(constraints.count).to(equal(3))
                    expect(constraints[0].firstAnchor).to(equal(view.rightAnchor))
                    expect(constraints[0].secondAnchor).to(equal(relatedView.leftAnchor))
                    expect(constraints[0].relation).to(equal(.greaterThanOrEqual))
                    expect(constraints[0].constant).to(equal(-constant))
                    assertLessThanVertical(constraints: constraints, for: view, and: relatedView, constant: constant)
                }
            }
        }
    }
}
// swiftlint:enable cyclomatic_complexity function_body_length type_body_length

func assertEqualHorizontal(constraints: [NSLayoutConstraint], for view: UIView, and relatedView: UIView, constant: CGFloat = 0) {
    expect(constraints[1].firstAnchor).to(equal(view.leftAnchor))
    expect(constraints[1].secondAnchor).to(equal(relatedView.leftAnchor))
    expect(constraints[1].relation).to(equal(.equal))
    expect(constraints[1].constant).to(equal(constant))
    expect(constraints[2].firstAnchor).to(equal(view.rightAnchor))
    expect(constraints[2].secondAnchor).to(equal(relatedView.rightAnchor))
    expect(constraints[2].relation).to(equal(.equal))
    expect(constraints[2].constant).to(equal(-constant))
}

func assertMoreThanHorizontal(constraints: [NSLayoutConstraint], for view: UIView, and relatedView: UIView, constant: CGFloat = 0) {
    expect(constraints[1].firstAnchor).to(equal(view.leftAnchor))
    expect(constraints[1].secondAnchor).to(equal(relatedView.leftAnchor))
    expect(constraints[1].relation).to(equal(.greaterThanOrEqual))
    expect(constraints[1].constant).to(equal(constant))
    expect(constraints[2].firstAnchor).to(equal(view.rightAnchor))
    expect(constraints[2].secondAnchor).to(equal(relatedView.rightAnchor))
    expect(constraints[2].relation).to(equal(.lessThanOrEqual))
    expect(constraints[2].constant).to(equal(-constant))
}

func assertLessThanHorizontal(constraints: [NSLayoutConstraint], for view: UIView, and relatedView: UIView, constant: CGFloat = 0) {
    expect(constraints[1].firstAnchor).to(equal(view.leftAnchor))
    expect(constraints[1].secondAnchor).to(equal(relatedView.leftAnchor))
    expect(constraints[1].relation).to(equal(.lessThanOrEqual))
    expect(constraints[1].constant).to(equal(constant))
    expect(constraints[2].firstAnchor).to(equal(view.rightAnchor))
    expect(constraints[2].secondAnchor).to(equal(relatedView.rightAnchor))
    expect(constraints[2].relation).to(equal(.greaterThanOrEqual))
    expect(constraints[2].constant).to(equal(-constant))
}

func assertEqualVertical(constraints: [NSLayoutConstraint], for view: UIView, and relatedView: UIView, constant: CGFloat = 0) {
    expect(constraints[1].firstAnchor).to(equal(view.topAnchor))
    expect(constraints[1].secondAnchor).to(equal(relatedView.topAnchor))
    expect(constraints[1].relation).to(equal(.equal))
    expect(constraints[1].constant).to(equal(constant))
    expect(constraints[2].firstAnchor).to(equal(view.bottomAnchor))
    expect(constraints[2].secondAnchor).to(equal(relatedView.bottomAnchor))
    expect(constraints[2].relation).to(equal(.equal))
    expect(constraints[2].constant).to(equal(-constant))
}

func assertMoreThanVertical(constraints: [NSLayoutConstraint], for view: UIView, and relatedView: UIView, constant: CGFloat = 0) {
    expect(constraints[1].firstAnchor).to(equal(view.topAnchor))
    expect(constraints[1].secondAnchor).to(equal(relatedView.topAnchor))
    expect(constraints[1].relation).to(equal(.greaterThanOrEqual))
    expect(constraints[1].constant).to(equal(constant))
    expect(constraints[2].firstAnchor).to(equal(view.bottomAnchor))
    expect(constraints[2].secondAnchor).to(equal(relatedView.bottomAnchor))
    expect(constraints[2].relation).to(equal(.lessThanOrEqual))
    expect(constraints[2].constant).to(equal(-constant))
}

func assertLessThanVertical(constraints: [NSLayoutConstraint], for view: UIView, and relatedView: UIView, constant: CGFloat = 0) {
    expect(constraints[1].firstAnchor).to(equal(view.topAnchor))
    expect(constraints[1].secondAnchor).to(equal(relatedView.topAnchor))
    expect(constraints[1].relation).to(equal(.lessThanOrEqual))
    expect(constraints[1].constant).to(equal(constant))
    expect(constraints[2].firstAnchor).to(equal(view.bottomAnchor))
    expect(constraints[2].secondAnchor).to(equal(relatedView.bottomAnchor))
    expect(constraints[2].relation).to(equal(.greaterThanOrEqual))
    expect(constraints[2].constant).to(equal(-constant))
}
#endif
