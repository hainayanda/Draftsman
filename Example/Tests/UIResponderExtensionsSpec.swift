//
//  UIResponderExtensionsSpec.swift
//  Gizmo_Tests
//
//  Created by Nayanda Haberty on 29/07/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Quick
import Nimble
import Draftsman

class UIResponderExtensionsSpec: QuickSpec {
    
    override func spec() {
        let targetViewController: UIViewController = UIViewController()
        let targetView: UIView = (1 ..< Int.random(in: 2..<10)).reduce(targetViewController.view) { partialResult, _ in
            let newView = UIView()
            partialResult.addSubview(newView)
            return newView
        }
        it("should get next viewController from view") {
            expect(targetView.responderViewController).to(equal(targetViewController))
        }
        it("should get next viewController from view") {
            expect(targetViewController.responderViewController).to(equal(targetViewController))
        }
    }
}
#endif
