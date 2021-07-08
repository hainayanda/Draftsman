//
//  Outlined.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 07/07/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public protocol Planned {
    @LayoutPlan
    var viewPlan: ViewPlan { get }
    
    func applyPlan()
}

public extension Planned where Self: UIView {
    func applyPlan() {
        LayoutScheme(view: self, subPlan: viewPlan.subPlan).apply()
    }
}

public extension Planned where Self: UIViewController {
    func applyPlan() {
        LayoutScheme(view: view, subPlan: viewPlan.subPlan).apply()
    }
}
#endif
