//
//  ViewController.swift
//  Draftsman
//
//  Created by 24823437 on 02/19/2021.
//  Copyright (c) 2021 24823437. All rights reserved.
//

import UIKit
import Draftsman

class ViewController: UIViewController {
    
    var textView: UITextView = builder(UITextView.self)
        .backgroundColor(.lightGray)
        .build()
    
    var buttonOnTopKeyboard: UIButton = builder(UIButton.self)
        .backgroundColor(.blue)
        .build()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonOnTopKeyboard.setTitle("Button on top keyboard", for: .normal)
        planContent {
            $0.fit(textView)
                .at(.fullTop, .equalTo(16), to: .safeArea)
                .bottom(.equalTo(16), to: buttonOnTopKeyboard.topAnchor)
            $0.fit(buttonOnTopKeyboard)
                .horizontal(.equal, to: .parent)
                .bottom(.moreThan, to: .safeArea, priority: .required)
                .bottom(.equal, to: .top(of: .keyboard))
                .height(.equalTo(45))
        }
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

