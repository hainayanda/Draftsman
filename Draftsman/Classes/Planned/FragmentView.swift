//
//  FragmentView.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 07/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

open class FragmentView: UIView, Fragment {
    
    var layouted: Bool = false
    
    @LayoutPlan
    open var viewPlan: ViewPlan { VoidViewPlan() }
    
    open func fragmentWillPlanContent() {}
    
    open func fragmentDidPlanContent() {}
    
    open func fragmentWillLayoutForTheFirstTime() {}
    
    open func fragmentDidLayoutForTheFirstTime() {}
    
    public func applyPlan(delegate: PlanDelegate?) {
        selfPlanned = true
        applyScheme(delegate: delegate)
        DispatchQueue.main.async { [weak self] in
            self?.layoutIfNeeded()
        }
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard superview != nil else { return }
        applyPlan()
    }
    
    open override func layoutSubviews() {
        let isFirstTimeLayout = !layouted
        if isFirstTimeLayout {
            fragmentWillLayoutForTheFirstTime()
        }
        applyScheme(delegate: nil)
        super.layoutSubviews()
        layouted = true
        if isFirstTimeLayout {
            fragmentDidLayoutForTheFirstTime()
        }
    }
    
    func applyScheme(delegate: PlanDelegate?) {
        fragmentWillPlanContent()
        defer {
            fragmentDidPlanContent()
            notifyViewDidPlanned()
        }
        let scheme = LayoutScheme(view: self, subPlan: viewPlan.subPlan, originalViewPlanId: self.uniqueKey)
        scheme.delegate = delegate
        scheme.apply()
    }
}
#endif
