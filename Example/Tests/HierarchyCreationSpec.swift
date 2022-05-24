//
//  HierarchyCreationSpec.swift
//  Draftsman_Tests
//
//  Created by Nayanda Haberty on 24/05/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Draftsman
import Quick
import Nimble

class HierarchyCreationSpec: QuickSpec {
    override func spec() {
        var stackView: UIStackView!
        var subview: UIView!
        var arrangedSubview: UIView!
        beforeEach {
            stackView = UIStackView()
            subview = UIView()
            arrangedSubview = UIView()
        }
        it("should add subview") {
            let constraints = stackView.drf.insert {
                subview
            }.insertStacked {
                arrangedSubview
            }.build()
            expect(stackView.subviews.count).to(equal(2))
            expect(stackView.arrangedSubviews.count).to(equal(1))
            expect(stackView.subviews.contains { $0 == subview }).to(beTrue())
            expect(stackView.arrangedSubviews.contains { $0 == arrangedSubview }).to(beTrue())
            expect(constraints.count).to(equal(0))
            expect(subview.superview).to(equal(stackView))
            expect(arrangedSubview.superview).to(equal(stackView))
        }
        
    }
}
