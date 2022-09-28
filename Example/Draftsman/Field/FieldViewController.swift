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
    
    lazy var baseView: UIView = UIView()
    lazy var imageView: UIImageView = UIImageView(image: UIImage(named: "image_test"))
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        baseView.drf
            .centerY.lessThan(with: .parent)
            .horizontal.equal(with: .safeArea).offset(by: 16)
            .bottom.moreThan(to: typingField.drf.top).offset(by: 8)
            .insert {
                imageView.drf.builder
                    .contentMode(.scaleAspectFill)
                    .clipsToBounds(true).drf
                    .top.horizontal.equal(with: .parent).offset(by: 12)
                    .height.equal(with: .width(of: .mySelf)).multiplied(by: 0.75)
                typingLabel.drf
                    .bottom.horizontal.equal(with: .parent).offset(by: 12)
                    .top.equal(with: .bottom(of: .previous)).offset(by: 8)
            }
        typingField.drf
            .horizontal.equal(with: .parent)
            .bottom.equal(with: .top(of: .keyboard)).priority(.required)
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
