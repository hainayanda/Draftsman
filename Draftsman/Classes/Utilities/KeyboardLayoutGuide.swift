//
//  KeyboardLayoutGuide.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 06/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension UIView {
    
    var keyboardLayoutGuide: KeyboardLayoutGuide {
        for guide in layoutGuides {
            if let keyboardGuide = guide as? KeyboardLayoutGuide {
                return keyboardGuide
            }
        }
        let keyboardGuide = KeyboardLayoutGuide()
        addLayoutGuide(keyboardGuide)
        keyboardGuide.updateGuideConstraints()
        return keyboardGuide
    }
}

public class KeyboardLayoutGuide: UILayoutGuide {
    
    var window: UIWindow? {
        UIApplication.shared.keyWindow
    }
    
    var defaultKeyboardRect: CGRect {
        let screenRect = UIScreen.main.bounds
        return CGRect(
            x: .zero,
            y: screenRect.height,
            width: screenRect.width,
            height: .zero
        )
    }
    
    var defaultKeyboardRectInWindow: CGRect {
        let windowRect = window?.bounds ?? .zero
        return CGRect(
            x: .zero,
            y: windowRect.height,
            width: windowRect.width,
            height: .zero
        )
    }
    
    var defaultKeyboardRectInView: CGRect {
        let viewRect = owningView?.bounds ?? .zero
        return CGRect(
            x: .zero,
            y: viewRect.height,
            width: viewRect.width,
            height: .zero
        )
    }
    
    lazy var keyboardRect: CGRect = defaultKeyboardRect {
        didSet {
            updateGuideConstraints()
        }
    }
    
    var keyboardRectInWindow: CGRect {
        guard let window = window else { return defaultKeyboardRectInWindow }
        let intersection = keyboardRect.intersection(window.frame)
        guard !intersection.isNull else { return defaultKeyboardRectInWindow }
        return intersection
    }
    
    var keyboardRectInView: CGRect {
        guard let window = window,
              let view = owningView else { return defaultKeyboardRectInView }
        let rectInView = window.convert(keyboardRectInWindow, to: view)
        let intersection = rectInView.intersection(view.bounds)
        guard !intersection.isNull else { return defaultKeyboardRectInView }
        return intersection
    }
    
    var keyboardEdgeInsetsInView: UIEdgeInsets {
        guard let view = owningView else { return .zero }
        return view.frame.insets(of: keyboardRectInView)
    }
    
    override init() {
        super.init()
        didInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        didInit()
    }
    
    func didInit() {
        identifier = "draftsman_keyboard_layout_guide"
        observeKeyboard()
        
    }
    
    func observeKeyboard() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardFrameChanged(notification:)),
            name: UIView.keyboardWillChangeFrameNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardFrameChanged(notification:)),
            name: UIView.keyboardDidChangeFrameNotification,
            object: nil
        )
    }
    
    var keyboardTopConstraint: NSLayoutConstraint?
    
    var edgesConstraints: [NSLayoutConstraint] = []
    
    func updateGuideConstraints() {
        guard let view = owningView else { return }
        let insets = keyboardEdgeInsetsInView
        if edgesConstraints.count != 4 {
            createEdgeConstraints(for: view, with: insets)
        } else {
            edgesConstraints[0].constant = insets.left
            edgesConstraints[1].constant = insets.top
            edgesConstraints[2].constant = -insets.right
            edgesConstraints[3].constant = -insets.bottom
        }
        view.layoutIfNeeded()
    }
    
    func createEdgeConstraints(for view: UIView, with insets: UIEdgeInsets) {
        edgesConstraints = [
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left),
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom)
        ]
        for constraint in edgesConstraints {
            constraint.priority = .required
            constraint.isActive = true
        }
    }
    
    @objc func keyboardFrameChanged(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
                ?? userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else {
            keyboardRect = defaultKeyboardRect
            return
        }
        guard keyboardValue.cgRectValue.intersects(UIScreen.main.bounds) else {
            keyboardRect = defaultKeyboardRect
            return
        }
        let rect = keyboardValue.cgRectValue.intersection(UIScreen.main.bounds)
        guard !rect.isNull else {
            keyboardRect = defaultKeyboardRect
            return
        }
        keyboardRect = rect
    }
}
#endif
