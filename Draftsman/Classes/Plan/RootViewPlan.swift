//
//  RootViewPlan.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 07/07/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

final class RootViewPlan: SchemeCollection {
    public weak var delegate: PlanDelegate?
    
    override func build(for view: UIView) -> [NSLayoutConstraint] {
        context.currentView = view
        context._delegate = delegate
        return super.build(for: view)
    }
}
#endif
