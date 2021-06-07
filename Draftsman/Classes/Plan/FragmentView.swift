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
    
    var inPlanning: Bool = false
    
    open func planContent(_ plan: InsertablePlan) { }
    
    open func fragmentWillPlanContent() {}
    
    open func fragmentDidPlanContent() {}
    
    open func fragmentWillLayoutForTheFirstTime() {}
    
    open func fragmentDidLayoutForTheFirstTime() {}
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard !inPlanning else { return }
        fragmentWillPlanContent()
        removeAllPlannedConstraints()
        planContent { plan in
            self.planContent(plan)
        }
        fragmentDidPlanContent()
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
