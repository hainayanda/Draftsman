//
//  HierarchyCreationSpec.swift
//  Draftsman_Tests
//
//  Created by Nayanda Haberty on 24/05/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Draftsman
import Quick
import Nimble

class HierarchyCreationSpec: QuickSpec {
    override func spec() {
        var stackView: UIStackView!
        var subviews: [UIView]!
        var arrangedSubviews: [UIView]!
        beforeEach {
            stackView = UIStackView()
            subviews = .generate()
            arrangedSubviews = .generate()
        }
        it("should add subview") {
            let constraints = stackView.drf.insert {
                for subview in subviews {
                    subview
                }
            }.insertStacked {
                for arrangedSubview in arrangedSubviews {
                    arrangedSubview
                }
            }.build()
            expect(stackView.subviews.count).to(equal(subviews.count + arrangedSubviews.count))
            expect(stackView.arrangedSubviews.count).to(equal(arrangedSubviews.count))
            for subview in subviews {
                expect(stackView.subviews.contains { $0 == subview }).to(beTrue())
                expect(subview.superview).to(equal(stackView))
            }
            for arrangedSubview in arrangedSubviews {
                expect(stackView.arrangedSubviews.contains { $0 == arrangedSubview }).to(beTrue())
                expect(arrangedSubview.superview).to(equal(stackView))
            }
            expect(constraints.count).to(equal(0))
        }
        
    }
}

extension Array where Element == UIView {
    static func generate() -> [UIView] {
        var array: [UIView] = []
        let count = Int.random(in: 5..<50)
        for _ in 0...count {
            array.append(UIView())
        }
        return array
    }
}
#endif
