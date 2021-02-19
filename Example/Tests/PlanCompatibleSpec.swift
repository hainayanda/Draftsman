//
//  PlanCompatibleSpec.swift
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

class PlanCompatibleSpec: QuickSpec {
    override func spec() {
        describe("planing behaviour") {
            context("view") {
                var view: UIView!
                beforeEach {
                    view = .init()
                }
                it("should plan content") {
                    var planed: Bool = false
                    let child: UIView = .init()
                    let randomSize: CGSize = .init(width: .random(in: 1..<10), height: .random(in: 1..<10))
                    let randomChildSize: CGSize = .init(width: .random(in: 1..<10), height: .random(in: 1..<10))
                    view.plan(.append) { plan in
                        plan.size(.equalTo(randomSize))
                        plan.planContent { content in
                            content.fit(child)
                                .size(.equalTo(randomChildSize))
                        }
                        planed = true
                    }
                    expect(planed).to(beTrue())
                    expect(child.superview).to(equal(view))
                    expect(child.constraints.count).to(equal(2))
                    expect(view.constraints.count).to(equal(2))
                    planed = false
                    view.plan(.startClean) { plan in
                        expect(view.subviews.isEmpty).to(beTrue())
                        expect(child.constraints.isEmpty).to(beTrue())
                        expect(view.constraints.isEmpty).to(beTrue())
                        plan.size(.equalTo(randomSize))
                        plan.planContent { content in
                            content.fit(child)
                                .size(.equalTo(randomChildSize))
                        }
                        planed = true
                    }
                    expect(planed).to(beTrue())
                    expect(child.superview).to(equal(view))
                    expect(child.constraints.count).to(equal(2))
                    expect(view.constraints.count).to(equal(2))
                    planed = false
                    view.plan(.renew) { plan in
                        expect(view.subviews.count).to(equal(1))
                        expect(child.constraints.count).to(equal(2))
                        expect(view.constraints.count).to(equal(2))
                        plan.size(.equalTo(randomSize))
                        plan.planContent { content in
                            content.fit(child)
                                .size(.equalTo(randomChildSize))
                        }
                        planed = true
                    }
                    expect(planed).to(beTrue())
                    expect(child.superview).to(equal(view))
                    expect(child.constraints.count).to(equal(2))
                    expect(view.constraints.count).to(equal(2))
                    planed = false
                    view.plan(.startFresh) { plan in
                        expect(child.constraints.isEmpty).to(beTrue())
                        expect(view.constraints.isEmpty).to(beTrue())
                        plan.size(.equalTo(randomSize))
                        plan.planContent { content in
                            content.fit(child)
                                .size(.equalTo(randomChildSize))
                        }
                        planed = true
                    }
                    expect(planed).to(beTrue())
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
                    var planed: Bool = false
                    let child: UIView = .init()
                    let randomSize: CGSize = .init(width: .random(in: 1..<10), height: .random(in: 1..<10))
                    let randomChildSize: CGSize = .init(width: .random(in: 1..<10), height: .random(in: 1..<10))
                    viewController.plan(.append) { plan in
                        plan.size(.equalTo(randomSize))
                        plan.planContent { content in
                            content.fit(child)
                                .size(.equalTo(randomChildSize))
                        }
                        planed = true
                    }
                    expect(planed).to(beTrue())
                    expect(child.superview).to(equal(view))
                    expect(child.constraints.count).to(equal(2))
                    expect(view.constraints.count).to(equal(2))
                    planed = false
                    viewController.plan(.startClean) { plan in
                        expect(view.subviews.isEmpty).to(beTrue())
                        expect(child.constraints.isEmpty).to(beTrue())
                        expect(view.constraints.isEmpty).to(beTrue())
                        plan.size(.equalTo(randomSize))
                        plan.planContent { content in
                            content.fit(child)
                                .size(.equalTo(randomChildSize))
                        }
                        planed = true
                    }
                    expect(planed).to(beTrue())
                    expect(child.superview).to(equal(view))
                    expect(child.constraints.count).to(equal(2))
                    expect(view.constraints.count).to(equal(2))
                    planed = false
                    viewController.plan(.renew) { plan in
                        expect(view.subviews.count).to(equal(1))
                        expect(child.constraints.count).to(equal(2))
                        expect(view.constraints.count).to(equal(2))
                        plan.size(.equalTo(randomSize))
                        plan.planContent { content in
                            content.fit(child)
                                .size(.equalTo(randomChildSize))
                        }
                        planed = true
                    }
                    expect(planed).to(beTrue())
                    expect(child.superview).to(equal(view))
                    expect(child.constraints.count).to(equal(2))
                    expect(view.constraints.count).to(equal(2))
                    planed = false
                    viewController.plan(.startFresh) { plan in
                        expect(child.constraints.isEmpty).to(beTrue())
                        expect(view.constraints.isEmpty).to(beTrue())
                        plan.size(.equalTo(randomSize))
                        plan.planContent { content in
                            content.fit(child)
                                .size(.equalTo(randomChildSize))
                        }
                        planed = true
                    }
                    expect(planed).to(beTrue())
                    expect(child.superview).to(equal(view))
                    expect(child.constraints.count).to(equal(2))
                    expect(view.constraints.count).to(equal(2))
                }
            }
        }
    }
}
#endif
