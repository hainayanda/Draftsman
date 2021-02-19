//
//  DraftsmanError.swift
//  Draftsman
//
//  Created by Nayanda Haberty (ID) on 27/08/20.
//

import Foundation
#if canImport(UIKit)
import UIKit

public struct DraftsmanError: LocalizedError {
    
    /// Description of error
    public let errorDescription: String?
    
    /// Reason of failure
    public let failureReason: String?
    
    init(errorDescription: String, failureReason: String? = nil) {
        self.errorDescription = errorDescription
        self.failureReason = failureReason
    }
}

extension DraftsmanError {
    static func whenFitting<Fitted, ToFit>(_ toFitType: ToFit.Type, into type: Fitted.Type, failureReason: String? = nil) -> DraftsmanError {
        .init(
            errorDescription: "Draftsman Error: Error when fitting \(String(describing: toFitType)) into \(type)",
            failureReason: failureReason
        )
    }
    
    static func whenCreateConstraints<Constrained>(of type: Constrained.Type, failureReason: String? = nil) -> DraftsmanError {
        .init(
            errorDescription: "Draftsman Error: Error when creating constraint of \(String(describing: type))",
            failureReason: failureReason
        )
    }
}
#endif
