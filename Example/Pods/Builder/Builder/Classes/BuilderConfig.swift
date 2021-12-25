//
//  BuilderConfig.swift
//  Builder
//
//  Created by Nayanda Haberty on 03/09/21.
//

import Foundation

public enum BuilderConfigErrorHandler {
    case fatalErrorOnAssigningLet
    case debugPrintOnAssigningLet
    case manual((String) -> Void)
}

public class BuilderConfig {
    public static let shared: BuilderConfig = .init()
    
    public var errorHandling: BuilderConfigErrorHandler = .debugPrintOnAssigningLet
}

func errorHappens(_ message: String) {
    switch BuilderConfig.shared.errorHandling {
    case .debugPrintOnAssigningLet:
        debugPrint(message)
    case .fatalErrorOnAssigningLet:
        fatalError(message)
    case .manual(let handler):
        handler(message)
    }
}
