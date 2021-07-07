//
//  ViewController.swift
//  Draftsman
//
//  Created by 24823437 on 02/19/2021.
//  Copyright (c) 2021 24823437. All rights reserved.
//

import UIKit
import Draftsman

class ViewController: UIViewController, Planned {
    
    lazy var textView: UITextView = builder(UITextView.self)
        .backgroundColor(.lightGray)
        .build()
    
    lazy var buttonOnTopKeyboard: UIButton = builder(UIButton.self)
        .backgroundColor(.blue)
        .build()
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        UIView().plan
            .at(.fullTop, .equalTo(16), to: .safeArea)
            .bottom(.equalTo(16), to: buttonOnTopKeyboard.topAnchor)
            .insert {
                textView.plan
                    .center(.equal, to: .parent)
                    .horizontal(.equal, to: .parent)
                    .height(.equalTo(.parent), multiplyBy: 0.5)
            }
        buttonOnTopKeyboard.plan
            .horizontal(.equal, to: .parent)
            .bottom(.moreThan, to: .safeArea, priority: .required)
            .bottom(.equal, to: .top(of: .keyboard))
            .height(.equalTo(45))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyPlan()
        buttonOnTopKeyboard.setTitle("Button on top keyboard", for: .normal)
        buttonOnTopKeyboard.addTarget(self, action: #selector(didTap(_:)), for: .touchUpInside)
    }
    
    @objc func didTap(_ sender: Any) {
        if textView.isFirstResponder {
            textView.resignFirstResponder()
        } else {
            textView.becomeFirstResponder()
        }
    }

}

