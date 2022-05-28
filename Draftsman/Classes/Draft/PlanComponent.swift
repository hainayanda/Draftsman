//
//  PlanComponent.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 06/04/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

public protocol PlanComponent {
    var insertablePlans: [ViewDraft] { get }
}

extension UIView: PlanComponent { }

extension UIViewController: PlanComponent { }

extension PlanComponent where Self: UIView {
    
    public var insertablePlans: [ViewDraft] { drf.insertablePlans }
    
    public var drf: LayoutDraft<Self> {
        LayoutDraft(view: self)
    }
    
    public func draftContent(@LayoutPlan _ layouter: () -> ViewPlan) -> LayoutDraft<Self> {
        drf.insert(layouter)
    }
}

extension PlanComponent where Self: StackCompatible {
    
    public func draftStackContent(@LayoutPlan _ layouter: () -> ViewPlan) -> LayoutDraft<Self> {
        drf.insertStacked(layouter)
    }
}

extension PlanComponent where Self: UIViewController {
    
    public var insertablePlans: [ViewDraft] { drf.insertablePlans }
    
    public var drf: LayoutDraft<UIView> {
        LayoutDraft(view: self.view)
    }
    
    public func draftContent(@LayoutPlan _ layouter: () -> ViewPlan) -> LayoutDraft<UIView> {
        drf.insert(layouter)
    }
}
#endif
