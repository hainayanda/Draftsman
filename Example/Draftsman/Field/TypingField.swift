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

class TypingField: UIDraftedView {
    
    lazy var textField: UITextField = builder(UITextField())
        .placeholder("Type here")
        .build()
    
    lazy var button: UIButton = builder(UIButton())
        .layer.cornerRadius(8)
        .backgroundColor(.orange)
        .build()
    
    @LayoutDraft
    var viewDraft: ViewDraft {
        textField.drf
            .left.vertical.equal(with: .safeArea).offset(by: 8)
            .right.equal(to: button.leftAnchor).offset(by: 8)
            .height.equal(to: 30)
        button.drf
            .right.vertical.equal(with: .safeArea).offset(by: 8)
            .width.equal(to: 64)
            .height.equal(to: 30)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyDraft()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyDraft()
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
