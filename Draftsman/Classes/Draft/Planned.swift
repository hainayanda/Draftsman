//
//  Planned.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 06/04/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

public protocol Planned: AnyObject {
    var planIdentifier: ObjectIdentifier { get }
    var appliedConstraints: [NSLayoutConstraint] { get }
    var viewPlanApplied: Bool { get }
    @LayoutPlan
    var viewPlan: ViewPlan { get }
    @discardableResult
    func applyPlan() -> [NSLayoutConstraint]
}

public typealias UIPlannedController = UIViewController & Planned
public typealias UIPlannedView = UIView & Planned

var appliedConstraintsKey: String = "appliedConstraintsKey"
var viewPlanAppliedKey: String = "viewPlanAppliedKey"

extension Planned {
    public var planIdentifier: ObjectIdentifier {
        ObjectIdentifier(self)
    }
    
    public internal(set) var appliedConstraints: [NSLayoutConstraint] {
        get {
            objc_getAssociatedObject(self, &appliedConstraintsKey) as? [NSLayoutConstraint] ?? []
        }
        set {
            objc_setAssociatedObject(self, &appliedConstraintsKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    public internal(set) var viewPlanApplied: Bool {
        get {
            objc_getAssociatedObject(self, &viewPlanAppliedKey) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &viewPlanAppliedKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}

public protocol PlannedCell: Planned {
    @LayoutPlan
    var contentViewPlan: ViewPlan { get }
}

public typealias UITablePlannedCell = UITableViewCell & PlannedCell
public typealias UICollectionPlannedCell = UICollectionViewCell & PlannedCell

extension PlannedCell where Self: UITableViewCell {
    @LayoutPlan
    public var viewPlan: ViewPlan {
        contentView.drf.insert {
            contentViewPlan
        }
    }
}

extension PlannedCell where Self: UICollectionViewCell {
    @LayoutPlan
    public var viewPlan: ViewPlan {
        contentView.drf.insert {
            contentViewPlan
        }
    }
}

public protocol PlannedStack: Planned {
    @LayoutPlan
    var stackViewPlan: ViewPlan { get }
}

public typealias UIPlannedStack = UIStackView & PlannedStack

extension PlannedStack where Self: UIStackView {
    @LayoutPlan
    public var viewPlan: ViewPlan {
        drf.insertStacked {
            stackViewPlan
        }
    }
}

extension Planned where Self: UIView {
    
    @discardableResult
    public func applyPlan() -> [NSLayoutConstraint] {
        let appliedConstraints = PlannedDraft(root: self, view: self, plans: viewPlan.insertablePlans)
            .apply()
        self.appliedConstraints = appliedConstraints
        self.viewPlanApplied = true
        return appliedConstraints
    }
}

extension Planned where Self: UIViewController {
    
    @discardableResult
    public func applyPlan() -> [NSLayoutConstraint] {
        let appliedConstraints = PlannedDraft(root: self, view: self.view, plans: viewPlan.insertablePlans)
            .apply()
        self.appliedConstraints = appliedConstraints
        self.viewPlanApplied = true
        return appliedConstraints
    }
}
#endif
