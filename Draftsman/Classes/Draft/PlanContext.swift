//
//  PlanContext.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 06/04/22.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Clavier

public final class PlanContext {
    var root: Planned?
    var currentView: UIView {
        didSet {
            guard currentView != oldValue else { return }
            currentViewController = currentView.responderViewController
            previousView = oldValue
        }
    }
    var currentViewController: UIViewController? {
        didSet {
            guard currentViewController != oldValue else { return }
            previousViewController = oldValue
        }
    }
    var previousView: UIView?
    var previousViewController: UIViewController?
    private var currentPriority: Float = 1000
    
    init(root: Planned? = nil, view: UIView) {
        self.root = root
        currentView = view
        currentViewController = view.responderViewController
    }
    
    func layout(of anonymous: AnonymousLayout) -> LayoutWithAnchors {
        switch anonymous {
        case .mySelf:
            return currentView
        case .parent:
            return currentView.superview!
        case .safeArea:
            return currentView.superview!.safeAreaLayoutGuide
        case .keyboard:
            return currentView.superview!.clavierLayoutGuide
        case .keyboardSafeArea:
            return currentView.superview!.safeClavierLayoutGuide
        case .previous:
            return previousView!
        case .previousSafeArea:
            return previousView!.safeAreaLayoutGuide
        }
    }
}
#endif
