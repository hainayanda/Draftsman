//
//  SafeAreaKeyboardLayoutGuide.swift
//  Clavier
//
//  Created by Nayanda Haberty on 22/04/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

@available(iOS 15.0, *)
public class SafeAreaKeyboardLayoutGuide: UILayoutGuide {
    
    public override var owningView: UIView? {
        get {
            super.owningView
        } set {
            super.owningView = newValue
            guard let view = newValue else { return }
            self.constraints = createConstraints(for: view)
        }
    }
    
    var constraints: [NSLayoutConstraint] = [] {
        didSet {
            NSLayoutConstraint.deactivate(oldValue)
            NSLayoutConstraint.activate(constraints)
        }
    }
    
    func createConstraints(for view: UIView) -> [NSLayoutConstraint] {
        let safeAreaConstraints: [NSLayoutConstraint] = [
            topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor),
            leftAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leftAnchor),
            bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor),
            rightAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.rightAnchor),
        ]
        let keyboardConstraints: [NSLayoutConstraint] = [
            topAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor),
            leftAnchor.constraint(equalTo: view.keyboardLayoutGuide.leftAnchor),
            bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.bottomAnchor),
            rightAnchor.constraint(equalTo: view.keyboardLayoutGuide.rightAnchor),
        ]
        safeAreaConstraints.forEach {
            $0.priority = .required
        }
        keyboardConstraints.forEach {
            $0.priority = .defaultHigh
        }
        var newConstraints: [NSLayoutConstraint] = []
        newConstraints.append(contentsOf: safeAreaConstraints)
        newConstraints.append(contentsOf: keyboardConstraints)
        return newConstraints
    }
}


#endif
