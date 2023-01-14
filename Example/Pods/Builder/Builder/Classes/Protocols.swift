//
//  Protocols.swift
//  Builder
//
//  Created by Nayanda Haberty on 16/08/21.
//

import Foundation

public protocol Buildable { }

public protocol Initializable: Buildable {
    init()
}

extension Buildable {
    public var bld: Builder<Self> { builder(self) }
}
