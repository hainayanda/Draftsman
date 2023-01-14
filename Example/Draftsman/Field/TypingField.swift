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

class TypingField: UIPlannedView {
    
    lazy var textField: UITextField = UITextField(placeholder: "Type here")
    
    lazy var button: UIButton = builder(UIButton())
        .layer.cornerRadius(8)
        .backgroundColor(.orange)
        .build()
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        HStacked(margins: UIEdgeInsets(insets: 8)) {
            textField.drf
                .height.equal(to: 30)
            button.drf
                .sized(CGSize(width: 64, height: 30))
        }
        .fillParent()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyPlan()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyPlan()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.contentEdgeInsets = UIEdgeInsets(horizontal: 8)
        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.25
    }
}
