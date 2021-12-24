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

class FieldViewController: UIViewController, Planned {
    
    lazy var typingLabel: UILabel = builder(UILabel(text: "will be replaced"))
        .textAlignment(.center)
        .font(.boldSystemFont(ofSize: 28))
        .numberOfLines(0)
        .build()
    
    lazy var typingField: TypingField = .init()
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        UIView().plan
            .center(.equal, to: .parent, priority: .defaultLow)
            .horizontal(.equalTo(16), to: .safeArea)
            .bottom(.moreThanTo(8), to: typingField.topAnchor)
            .insert {
                UIImageView(image: UIImage(named: "image_test")).plan
                    .builder.contentMode(.scaleAspectFill)
                    .clipsToBounds(true)
                    .plan.at(.fullTop, .equalTo(12), to: .parent)
                    .height(.equalTo(.width(of: .myself)), multiplyBy: 0.75)
                typingLabel.plan
                    .at(.fullBottom, .equalTo(12), to: .parent)
                    .top(.equalTo(8), to: .bottom(of: .previous))
            }
        typingField.plan
            .horizontal(.equal, to: .parent)
            .bottom(.equal, to: .top(of: .keyboard), priority: .required)
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
            typingField.button.setTitle("Show", for: .normal)
            typingField.textField.resignFirstResponder()
        } else {
            typingField.button.setTitle("Hide", for: .normal)
            typingField.textField.becomeFirstResponder()
        }
    }
}

extension FieldViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let replacedText = NSString(string: currentText).replacingCharacters(in: range, with: string)
        typingLabel.text = replacedText
        return true
    }
}
