//
//  TypingField.swift
//  Draftsman_Example
//
//  Created by Nayanda Haberty on 08/07/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import Draftsman
import Builder

class TypingField: FragmentView {
    
    lazy var textField: UITextField = builder(UITextField())
        .placeholder("Type here")
        .build()
    
    lazy var button: UIButton = builder(UIButton())
        .cornerRadius(8)
        .backgroundColor(.orange)
        .build()
    
    @LayoutPlan
    override var viewPlan: ViewPlan {
        textField.plan
            .at(.fullLeft, .equalTo(8), to: .safeArea)
            .right(.equalTo(8), to: button.leftAnchor)
            .height(.equalTo(30))
        button.plan
            .at(.fullRight, .equalTo(8), to: .safeArea)
            .width(.equalTo(64))
            .height(.equalTo(30))
    }
    
    override func fragmentWillLayoutForTheFirstTime() {
        button.contentEdgeInsets = UIEdgeInsets(horizontal: 8)
        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.25
    }
}
