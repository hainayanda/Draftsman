//
//  UIKitExtensionSpec.swift
//  Draftsman_Tests
//
//  Created by Nayanda Haberty (ID) on 03/09/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Quick
import Nimble
@testable import Draftsman

class UIKitExtensionSpec: QuickSpec {
    override func spec() {
        describe("TextCompatible") {
            context("label") {
                var label: UILabel!
                beforeEach {
                    label = .init()
                }
                it("should assign String") {
                    let text: String = .randomString()
                    label.textCompat = text
                    expect(label.textCompat?.text).to(equal(text))
                }
                it("should assign NSAttributedString") {
                    let text: NSAttributedString = NSAttributedString(string: .randomString())
                    label.textCompat = text
                    expect(label.textCompat?.attributedText).to(equal(text))
                }
            }
            context("text view") {
                var textView: UITextView!
                beforeEach {
                    textView = .init()
                }
                it("should assign String") {
                    let text: String = .randomString()
                    textView.textCompat = text
                    expect(textView.textCompat?.text).to(equal(text))
                }
                it("should assign NSAttributedString") {
                    let text: NSAttributedString = NSAttributedString(string: .randomString())
                    textView.textCompat = text
                    expect(textView.textCompat?.text).to(equal(text.string))
                }
            }
            context("text field") {
                var textField: UITextField!
                beforeEach {
                    textField = .init()
                }
                it("should assign String") {
                    let text: String = .randomString()
                    textField.textCompat = text
                    expect(textField.textCompat?.text).to(equal(text))
                }
                it("should assign NSAttributedString") {
                    let text: NSAttributedString = NSAttributedString(string: .randomString())
                    textField.textCompat = text
                    expect(textField.textCompat?.text).to(equal(text.string))
                }
                it("should assign String to placeholder") {
                    let text: String = .randomString()
                    textField.placeholderCompat = text
                    expect(textField.placeholderCompat?.text).to(equal(text))
                }
                it("should assign NSAttributedString to placeholder") {
                    let text: NSAttributedString = NSAttributedString(string: .randomString())
                    textField.placeholderCompat = text
                    expect(textField.placeholderCompat?.attributedText).to(equal(text))
                }
            }
        }
        describe("ImageCompatible") {
            var imageView: UIImageView!
            beforeEach {
                imageView = .init()
            }
            it("should assign image") {
                let image = UIImage()
                image.accessibilityIdentifier = .randomString()
                imageView.imageCompat = image
                expect((imageView.imageCompat as? UIImage)?.accessibilityIdentifier).to(equal(image.accessibilityIdentifier))
            }
            it("should assign animation") {
                let animation = UIImageView.Animation(
                    images: [],
                    duration: .random(in: 1..<10),
                    animating: .random(),
                    repeatCount: .random(in: 0..<10)
                )
                imageView.imageCompat = animation
                expect(imageView.imageCompat as? UIImageView.Animation).to(equal(animation))
            }
        }
        describe("UIButton") {
            var button: UIButton!
            beforeEach {
                button = .init()
            }
            it("should run closure on clicked") {
                var closureRun: Bool = false
                button.whenDidTapped { btn in
                    expect(btn).to(equal(button))
                    closureRun = true
                }
                button.testAction(for: .touchUpInside)
                expect(closureRun).to(beTrue())
            }
        }
        describe("UIButton") {
            var button: UIButton!
            beforeEach {
                button = .init()
            }
            it("should run closure on clicked") {
                var closureRun: Bool = false
                button.whenDidTapped { btn in
                    expect(btn).to(equal(button))
                    closureRun = true
                }
                button.testAction(for: .touchUpInside)
                expect(closureRun).to(beTrue())
            }
        }
        describe("UIControl") {
            var control: UIControl!
            beforeEach {
                control = .init()
            }
            it("should run closure on event") {
                var closureRun: Bool = false
                for event in UIControl.AssociatedKey.eventKeys.keys {
                    control.whenDidTriggered(by: event, then: { ctrl in
                        expect(ctrl).to(equal(control))
                        closureRun = true
                    })
                    control.testAction(for: event)
                    expect(closureRun).to(beTrue())
                    closureRun = false
                }
            }
        }
    }
}

extension UIControl {
    func testAction(for event: UIControl.Event) {
        let targets = self.allTargets
        for target in targets {
            guard let actions = self.actions(forTarget: target, forControlEvent: event) else {
                continue
            }
            for action in actions {
                (target as NSObject).perform(Selector(action), with: self)
            }
        }
    }
}
#endif
