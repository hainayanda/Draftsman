//
//  FragmentCell.swift
//  Draftsman
//
//  Created by Nayanda Haberty (ID) on 28/08/20.
//

import Foundation
#if canImport(UIKit)
import UIKit

public protocol FragmentCell: Fragment {
    var layoutPhase: CellLayoutingPhase { get }
    var planningBehavior: CellPlanningBehavior { get }
    func planningOption(on phase: CellLayoutingPhase) -> PlanningOption
}

extension UITableViewCell {
    
    @objc open class func defaultCellHeight(for cellWidth: CGFloat) -> CGFloat { .automatic }
    
}

open class TableFragmentCell: UITableViewCell, FragmentCell {
    
    var _layoutPhase: CellLayoutingPhase = .firstLoad
    public internal(set) var layoutPhase: CellLayoutingPhase {
        get {
            layouted ? _layoutPhase : .firstLoad
        }
        set {
            _layoutPhase = newValue
        }
    }
    
    var layouted: Bool = false
    
    var customHeightCalculator: (CGFloat) -> CGFloat = { _ in .automatic }
    
    open var planningBehavior: CellPlanningBehavior { .planOnce }
    
    @LayoutPlan
    open var viewPlan: ViewPlan { VoidViewPlan() }
    
    open func fragmentWillPlanContent() {}
    
    open func fragmentDidPlanContent() {}
    
    open func fragmentWillLayoutForTheFirstTime() {}
    
    open func fragmentDidLayoutForTheFirstTime() {}
    
    @discardableResult
    open func layoutContentIfNeeded() -> Bool {
        defer {
            layouted = true
        }
        guard planningBehavior.whitelistedPhases.contains(layoutPhase) else {
            return false
        }
        fragmentWillPlanContent()
        let plan = RootViewPlan(subPlan: viewPlan.subPlan)
        plan.planOption = planningOption(on: layoutPhase)
        plan.apply(for: contentView)
        fragmentDidPlanContent()
        return true
    }
    
    open override class func defaultCellHeight(for cellWidth: CGFloat) -> CGFloat { .automatic }
    
    open func calculatedCellHeight(for cellWidth: CGFloat) -> CGFloat { .automatic }
    
    public func whenNeedCellHeight(calculate: @escaping (CGFloat) -> CGFloat) {
        customHeightCalculator = calculate
    }
    
    open override func systemLayoutSizeFitting(
        _ targetSize: CGSize,
        withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
        verticalFittingPriority: UILayoutPriority) -> CGSize {
        let layouted = layoutContentIfNeeded()
        if layouted {
            setNeedsDisplay()
        }
        let size = super.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: horizontalFittingPriority,
            verticalFittingPriority: verticalFittingPriority
        )
        let cellHeight = getHeight(for: size.width)
        let height = cellHeight.isAutomatic ? size.height : cellHeight
        return CGSize(width: size.width, height: height)
    }
    
    func getHeight(for cellWidth: CGFloat) -> CGFloat {
        let customHeight = customHeightCalculator(cellWidth)
        guard customHeight.isAutomatic else {
            return customHeight
        }
        let defaultHeight = Self.defaultCellHeight(for: cellWidth)
        let calculatedHeight = calculatedCellHeight(for: cellWidth)
        return calculatedHeight.isCalculated ? calculatedHeight : defaultHeight
    }
    
    open func planningOption(on phase: CellLayoutingPhase) -> PlanningOption {
        switch phase {
        case .firstLoad:
            return .append
        default:
            return .startClean
        }
    }
    
    open override func prepareForReuse() {
        layoutPhase = .reused
        layoutContentIfNeeded()
    }
    
    open override func setNeedsLayout() {
        defer {
            super.setNeedsLayout()
        }
        guard layouted else { return }
        layoutPhase = .setNeedsLayout
    }
    
    open override func layoutSubviews() {
        let isFirstTimeLayout = !layouted
        if isFirstTimeLayout {
            fragmentWillLayoutForTheFirstTime()
        }
        super.layoutSubviews()
        layoutContentIfNeeded()
        if isFirstTimeLayout {
            fragmentDidLayoutForTheFirstTime()
        }
        layoutPhase = .none
    }
}

open class CollectionFragmentCell: UICollectionViewCell, FragmentCell {
    var _layoutPhase: CellLayoutingPhase = .firstLoad
    public internal(set) var layoutPhase: CellLayoutingPhase {
        get {
            layouted ? _layoutPhase : .firstLoad
        }
        set {
            _layoutPhase = newValue
        }
    }
    
    var layouted: Bool = false
    
    var customSizeCalculator: (CGSize) -> CGSize = { _ in .automatic }
    
    open var planningBehavior: CellPlanningBehavior { .planOnce }
    
    @LayoutPlan
    open var viewPlan: ViewPlan { VoidViewPlan() }
    
    open func fragmentWillPlanContent() {}
    
    open func fragmentDidPlanContent() {}
    
    open func fragmentWillLayoutForTheFirstTime() {}
    
    open func fragmentDidLayoutForTheFirstTime() {}
    
    @discardableResult
    open func layoutContentIfNeeded() -> Bool {
        defer {
            layouted = true
        }
        guard planningBehavior.whitelistedPhases.contains(layoutPhase) else {
            return false
        }
        fragmentWillPlanContent()
        let plan = RootViewPlan(subPlan: viewPlan.subPlan)
        plan.planOption = planningOption(on: layoutPhase)
        plan.apply(for: contentView)
        fragmentDidPlanContent()
        return true
    }
    
    open func planningOption(on phase: CellLayoutingPhase) -> PlanningOption {
        switch phase {
        case .firstLoad:
            return .append
        default:
            return .startClean
        }
    }
    
    open override func prepareForReuse() {
        layoutPhase = .reused
        layoutContentIfNeeded()
    }
    
    open override func setNeedsLayout() {
        defer {
            super.setNeedsLayout()
        }
        guard layouted else { return }
        layoutPhase = .setNeedsLayout
    }
    
    open override func layoutSubviews() {
        let isFirstTimeLayout = !layouted
        if isFirstTimeLayout {
            fragmentWillLayoutForTheFirstTime()
        }
        super.layoutSubviews()
        layoutContentIfNeeded()
        if isFirstTimeLayout {
            fragmentDidLayoutForTheFirstTime()
        }
        layoutPhase = .none
    }
}
#endif
