//
//  PlanConvertibleSpec.swift
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

class PlanConvertibleSpec: QuickSpec {
    override func spec() {
        describe("planing behaviour") {
            context("view") {
                var view: UIView!
                beforeEach {
                    view = .init()
                }
                it("should plan content") {
                    let child: UIView = .init()
                    let randomSize: CGSize = .init(width: .random(in: 1..<10), height: .random(in: 1..<10))
                    let randomChildSize: CGSize = .init(width: .random(in: 1..<10), height: .random(in: 1..<10))
                    view.plan
                        .size(.equalTo(randomSize))
                        .insert {
                            child.plan.size(.equalTo(randomChildSize))
                        }.apply()
                    expect(child.superview).to(equal(view))
                    expect(child.constraints.count).to(equal(2))
                    expect(view.constraints.count).to(equal(2))
                }
            }
            context("view controller") {
                var view: UIView!
                var viewController: UIViewController!
                beforeEach {
                    viewController = .init()
                    view = viewController.view
                }
                it("should plan content") {
                    let child: UIView = .init()
                    let randomSize: CGSize = .init(width: .random(in: 1..<10), height: .random(in: 1..<10))
                    let randomChildSize: CGSize = .init(width: .random(in: 1..<10), height: .random(in: 1..<10))
                    viewController.plan
                        .size(.equalTo(randomSize))
                        .insert {
                            child.plan
                                .size(.equalTo(randomChildSize))
                        }.apply()
                    expect(child.superview).to(equal(view))
                    expect(child.constraints.count).to(equal(2))
                    expect(view.constraints.count).to(equal(2))
                }
            }
        }
    }
}
#endif
