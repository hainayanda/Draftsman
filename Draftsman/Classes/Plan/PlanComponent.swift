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
    var insertablePlans: [ViewScheme] { get }
}

extension UIView: PlanComponent { }

extension UIViewController: PlanComponent { }

extension PlanComponent where Self: UIView {
    
    public var insertablePlans: [ViewScheme] { drf.insertablePlans }
    
    public var drf: LayoutScheme<Self> {
        LayoutScheme(view: self)
    }
}

extension PlanComponent where Self: UIViewController {
    
    public var insertablePlans: [ViewScheme] { drf.insertablePlans }
    
    public var drf: LayoutScheme<UIView> {
        LayoutScheme(view: self.view)
    }
}
#endif
