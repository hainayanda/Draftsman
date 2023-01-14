//
//  FieldViewController.swift
//  Draftsman_Example
//
//  Created by Nayanda Haberty on 08/07/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import Draftsman
import Builder

class FieldViewController: UIPlannedController {
    
    lazy var typingLabel: UILabel = builder(UILabel(text: "will be replaced"))
        .textAlignment(.center)
        .font(.boldSystemFont(ofSize: 28))
        .numberOfLines(0)
        .build()
    
    lazy var typingField: TypingField = .init()
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        VStacked(margins: UIEdgeInsets(insets: 12), spacing: 8) {
            UIImageView(image: UIImage(named: "image_test")).drf
                .height.equal(with: .width(of: .mySelf)).multiplied(by: 0.75)
                .builder.contentMode(.scaleAspectFill)
                .clipsToBounds(true)
            typingLabel
        }
        .centerY.lessThan(with: .parent)
        .matchSafeAreaH().offset(by: 16)
        .bottom.moreThan(to: typingField.drf.top).offset(by: 8)
        
        typingField.drf
            .matchParentH()
            .onTopOfKeyboard().priority(.required)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Keyboard View"
        view.backgroundColor = .white
        typingField.textField.delegate = self
        typingField.button.setTitle("Show", for: .normal)
        typingField.button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        applyPlan()
    }
    
    @objc func didTapButton(_ sender: Any) {
        if typingField.textField.isFirstResponder {
            typingField.textField.resignFirstResponder()
        } else {
            typingField.textField.becomeFirstResponder()
        }
    }
}

extension FieldViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        typingField.button.setTitle("Hide", for: .normal)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        typingField.button.setTitle("Show", for: .normal)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let replacedText = NSString(string: currentText).replacingCharacters(in: range, with: string)
        typingLabel.text = replacedText
        return true
    }
}
