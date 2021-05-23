//
//  FragmentCellSpec.swift
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

class FragmentCellSpec: QuickSpec {
    override func spec() {
        describe("fragment cell behaviour") {
            context("table molecule cell") {
                var tableCell: TestableTableCell!
                beforeEach {
                    tableCell = .init()
                }
                it("should plan content only first load") {
                    var planed: Bool = false
                    tableCell.layoutPhase = .firstLoad
                    tableCell.planningBehavior = .planOnce
                    tableCell.didPlanContent = { plan in
                        expect((plan as? LayoutPlan<UIView>)?.view)
                            .to(equal(tableCell.contentView))
                        planed = true
                    }
                    tableCell.layoutSubviews()
                    expect(planed).to(beTrue())
                    planed = false
                    tableCell.layoutPhase = .reused
                    tableCell.layoutSubviews()
                    expect(planed).to(beFalse())
                    tableCell.layoutPhase = .setNeedsLayout
                    tableCell.layoutSubviews()
                    expect(planed).to(beFalse())
                    tableCell.layoutPhase = .none
                    tableCell.layoutSubviews()
                    expect(planed).to(beFalse())
                }
                it("should plan content only on reused") {
                    var planed: Bool = false
                    tableCell.layoutPhase = .firstLoad
                    tableCell.planningBehavior = .planOn(.reused)
                    tableCell.didPlanContent = { plan in
                        expect((plan as? LayoutPlan<UIView>)?.view)
                            .to(equal(tableCell.contentView))
                        planed = true
                    }
                    tableCell.layoutSubviews()
                    expect(planed).to(beFalse())
                    planed = false
                    tableCell.layoutPhase = .reused
                    tableCell.layoutSubviews()
                    expect(planed).to(beTrue())
                    planed = false
                    tableCell.layoutPhase = .setNeedsLayout
                    tableCell.layoutSubviews()
                    expect(planed).to(beFalse())
                    tableCell.layoutPhase = .none
                    tableCell.layoutSubviews()
                    expect(planed).to(beFalse())
                }
                it("should plan content only on setNeedsLayout") {
                    var planed: Bool = false
                    tableCell.layoutPhase = .firstLoad
                    tableCell.planningBehavior = .planOn(.setNeedsLayout)
                    tableCell.didPlanContent = { plan in
                        expect((plan as? LayoutPlan<UIView>)?.view)
                            .to(equal(tableCell.contentView))
                        planed = true
                    }
                    tableCell.layoutSubviews()
                    expect(planed).to(beFalse())
                    planed = false
                    tableCell.layoutPhase = .setNeedsLayout
                    tableCell.layoutSubviews()
                    expect(planed).to(beTrue())
                    planed = false
                    tableCell.layoutPhase = .reused
                    tableCell.layoutSubviews()
                    expect(planed).to(beFalse())
                    tableCell.layoutPhase = .none
                    tableCell.layoutSubviews()
                    expect(planed).to(beFalse())
                }
                it("should plan content on any given phase") {
                    var planed: Bool = false
                    tableCell.layoutPhase = .firstLoad
                    tableCell.planningBehavior = .planOnEach([.none, .reused, .setNeedsLayout])
                    tableCell.didPlanContent = { plan in
                        expect((plan as? LayoutPlan<UIView>)?.view)
                            .to(equal(tableCell.contentView))
                        planed = true
                    }
                    tableCell.layoutSubviews()
                    expect(planed).to(beFalse())
                    planed = false
                    tableCell.layoutPhase = .setNeedsLayout
                    tableCell.layoutSubviews()
                    expect(planed).to(beTrue())
                    planed = false
                    tableCell.layoutPhase = .reused
                    tableCell.layoutSubviews()
                    expect(planed).to(beTrue())
                    planed = false
                    tableCell.layoutPhase = .none
                    tableCell.layoutSubviews()
                    expect(planed).to(beTrue())
                }
                it("should get subplaning option") {
                    var planOptionPhase: CellLayoutingPhase = .none
                    var planed: Bool = false
                    tableCell.planningBehavior = .planIfPossible
                    tableCell.didNeedPlanningOption = { phase in
                        planOptionPhase = phase
                        return .append
                    }
                    tableCell.didPlanContent = { plan in
                        let container = plan as? LayoutPlan<UIView>
                        expect(container?.view)
                            .to(equal(tableCell.contentView))
                        planed = true
                    }
                    tableCell.layoutPhase = .firstLoad
                    tableCell.layoutSubviews()
                    expect(planed).to(beTrue())
                    expect(planOptionPhase).to(equal(.firstLoad))
                    planed = false
                    tableCell.layoutPhase = .reused
                    tableCell.layoutSubviews()
                    expect(planed).to(beTrue())
                    expect(planOptionPhase).to(equal(.reused))
                    planed = false
                    tableCell.layoutPhase = .setNeedsLayout
                    tableCell.layoutSubviews()
                    expect(planed).to(beTrue())
                    expect(planOptionPhase).to(equal(.setNeedsLayout))
                }
                it("should use calculated size") {
                    var planFitted: Bool = false
                    var calculated: Bool = false
                    var tableWidth: CGFloat = .automatic
                    let tableHeight: CGFloat = .random(in: 0..<500)
                    tableCell.didLayoutFitting = { _ in
                        planFitted = true
                    }
                    tableCell.didCalculatedCellHeight = { width in
                        defer {
                            calculated = true
                        }
                        tableWidth = width
                        return tableHeight
                    }
                    let size = tableCell.systemLayoutSizeFitting(
                        .init(width: .random(in: 0..<50), height: .random(in: 0..<100)),
                        withHorizontalFittingPriority: .defaultHigh,
                        verticalFittingPriority: .defaultHigh
                    )
                    expect(planFitted).to(beTrue())
                    expect(calculated).to(beTrue())
                    expect(size.width).to(equal(tableWidth))
                    expect(size.height).to(equal(tableHeight))
                }
            }
            context("collection molecule cell") {
                var collectionCell: TestableCollectionCell!
                beforeEach {
                    collectionCell = .init()
                }
                it("should plan content only first load") {
                    var planed: Bool = false
                    collectionCell.layoutPhase = .firstLoad
                    collectionCell.planningBehavior = .planOnce
                    collectionCell.didPlanContent = { plan in
                        expect((plan as? LayoutPlan<UIView>)?.view)
                            .to(equal(collectionCell.contentView))
                        planed = true
                    }
                    collectionCell.layoutSubviews()
                    expect(planed).to(beTrue())
                    planed = false
                    collectionCell.layoutPhase = .reused
                    collectionCell.layoutSubviews()
                    expect(planed).to(beFalse())
                    collectionCell.layoutPhase = .setNeedsLayout
                    collectionCell.layoutSubviews()
                    expect(planed).to(beFalse())
                    collectionCell.layoutPhase = .none
                    collectionCell.layoutSubviews()
                    expect(planed).to(beFalse())
                }
                it("should plan content only on reused") {
                    var planed: Bool = false
                    collectionCell.layoutPhase = .firstLoad
                    collectionCell.planningBehavior = .planOn(.reused)
                    collectionCell.didPlanContent = { plan in
                        expect((plan as? LayoutPlan<UIView>)?.view)
                            .to(equal(collectionCell.contentView))
                        planed = true
                    }
                    collectionCell.layoutSubviews()
                    expect(planed).to(beFalse())
                    planed = false
                    collectionCell.layoutPhase = .reused
                    collectionCell.layoutSubviews()
                    expect(planed).to(beTrue())
                    planed = false
                    collectionCell.layoutPhase = .setNeedsLayout
                    collectionCell.layoutSubviews()
                    expect(planed).to(beFalse())
                    collectionCell.layoutPhase = .none
                    collectionCell.layoutSubviews()
                    expect(planed).to(beFalse())
                }
                it("should plan content only on setNeedsLayout") {
                    var planed: Bool = false
                    collectionCell.layoutPhase = .firstLoad
                    collectionCell.planningBehavior = .planOn(.setNeedsLayout)
                    collectionCell.didPlanContent = { plan in
                        expect((plan as? LayoutPlan<UIView>)?.view)
                            .to(equal(collectionCell.contentView))
                        planed = true
                    }
                    collectionCell.layoutSubviews()
                    expect(planed).to(beFalse())
                    planed = false
                    collectionCell.layoutPhase = .setNeedsLayout
                    collectionCell.layoutSubviews()
                    expect(planed).to(beTrue())
                    planed = false
                    collectionCell.layoutPhase = .reused
                    collectionCell.layoutSubviews()
                    expect(planed).to(beFalse())
                    collectionCell.layoutPhase = .none
                    collectionCell.layoutSubviews()
                    expect(planed).to(beFalse())
                }
                it("should plan content on any given phase") {
                    var planed: Bool = false
                    collectionCell.layoutPhase = .firstLoad
                    collectionCell.planningBehavior = .planOnEach([.none, .reused, .setNeedsLayout])
                    collectionCell.didPlanContent = { plan in
                        expect((plan as? LayoutPlan<UIView>)?.view)
                            .to(equal(collectionCell.contentView))
                        planed = true
                    }
                    collectionCell.layoutSubviews()
                    expect(planed).to(beFalse())
                    planed = false
                    collectionCell.layoutPhase = .setNeedsLayout
                    collectionCell.layoutSubviews()
                    expect(planed).to(beTrue())
                    planed = false
                    collectionCell.layoutPhase = .reused
                    collectionCell.layoutSubviews()
                    expect(planed).to(beTrue())
                    planed = false
                    collectionCell.layoutPhase = .none
                    collectionCell.layoutSubviews()
                    expect(planed).to(beTrue())
                }
                it("should get subplaning option") {
                    var planOptionPhase: CellLayoutingPhase = .none
                    var planed: Bool = false
                    collectionCell.planningBehavior = .planIfPossible
                    collectionCell.didNeedPlanningOption = { phase in
                        planOptionPhase = phase
                        return .append
                    }
                    collectionCell.didPlanContent = { plan in
                        let container = plan as? LayoutPlan<UIView>
                        expect(container?.view)
                            .to(equal(collectionCell.contentView))
                        planed = true
                    }
                    collectionCell.layoutPhase = .firstLoad
                    collectionCell.layoutSubviews()
                    expect(planed).to(beTrue())
                    expect(planOptionPhase).to(equal(.firstLoad))
                    planed = false
                    collectionCell.layoutPhase = .reused
                    collectionCell.layoutSubviews()
                    expect(planed).to(beTrue())
                    expect(planOptionPhase).to(equal(.reused))
                    planed = false
                    collectionCell.layoutPhase = .setNeedsLayout
                    collectionCell.layoutSubviews()
                    expect(planed).to(beTrue())
                    expect(planOptionPhase).to(equal(.setNeedsLayout))
                }
            }
        }
    }
}

class TestableTableCell: TableFragmentCell {
    private var mockLayoutPhase: CellLayoutingPhase = .firstLoad
    public override var layoutPhase: CellLayoutingPhase {
        get {
            mockLayoutPhase
        }
        set {
            mockLayoutPhase = newValue
        }
    }
    private var _planBehaviour: CellPlanningBehavior = .planOnce
    override var planningBehavior: CellPlanningBehavior {
        get {
            _planBehaviour
        }
        set {
            _planBehaviour = newValue
        }
    }
    
    var didNeedPlanningOption: ((CellLayoutingPhase) -> PlanningOption)?
    override func planningOption(on phase: CellLayoutingPhase) -> PlanningOption {
        didNeedPlanningOption?(phase) ?? super.planningOption(on: phase)
    }
    
    var didPlanContent: ((InsertablePlan) -> Void)?
    override func planContent(_ plan: InsertablePlan) {
        didPlanContent?(plan)
    }
    
    var didCalculatedCellHeight: ((CGFloat) -> CGFloat)?
    override func calculatedCellHeight(for cellWidth: CGFloat) -> CGFloat {
        didCalculatedCellHeight?(cellWidth) ?? super.calculatedCellHeight(for: cellWidth)
    }
    
    var didLayoutFitting: ((CGSize) -> Void)?
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        let size = super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
        didLayoutFitting?(size)
        return size
    }
}

class TestableCollectionCell: CollectionFragmentCell {
    private var mockLayoutPhase: CellLayoutingPhase = .firstLoad
    public override var layoutPhase: CellLayoutingPhase {
        get {
            mockLayoutPhase
        }
        set {
            mockLayoutPhase = newValue
        }
    }
    private var _planningBehavior: CellPlanningBehavior = .planOnce
    override var planningBehavior: CellPlanningBehavior {
        get {
            _planningBehavior
        }
        set {
            _planningBehavior = newValue
        }
    }
    
    var didNeedPlanningOption: ((CellLayoutingPhase) -> PlanningOption)?
    override func planningOption(on phase: CellLayoutingPhase) -> PlanningOption {
        didNeedPlanningOption?(phase) ?? super.planningOption(on: phase)
    }
    
    var didPlanContent: ((InsertablePlan) -> Void)?
    override func planContent(_ plan: InsertablePlan) {
        didPlanContent?(plan)
    }
}
#endif
