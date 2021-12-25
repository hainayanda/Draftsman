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
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard superview != nil else { return }
        fragmentWillPlanContent()
        defer {
            fragmentDidPlanContent()
            notifyViewDidPlanned()
        }
        let rootPlan = viewPlan as? RootViewPlan ?? RootViewPlan(subPlan: viewPlan.subPlan, inViewPlan: true)
        rootPlan.apply(for: self)
    }
    
    open override func layoutSubviews() {
        let isFirstTimeLayout = !layouted
        if isFirstTimeLayout {
            fragmentWillLayoutForTheFirstTime()
        }
        super.layoutSubviews()
        layouted = true
        if isFirstTimeLayout {
            fragmentDidLayoutForTheFirstTime()
        }
    }
}
#endif
