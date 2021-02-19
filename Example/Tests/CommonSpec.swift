//
//  CommonSpec.swift
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

class CommonSpec: QuickSpec {
    override func spec() {
        describe("string") {
            it("should convert camel case to snake case") {
                let camelCase = "thisIsCamelCase"
                expect(camelCase.camelCaseToSnakeCase()).to(equal("this_is_camel_case"))
            }
        }
    }
}
#endif
