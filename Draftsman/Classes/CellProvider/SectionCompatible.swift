//
//  SectionCompatible.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 21/7/23.
//

import Foundation

public protocol SectionCompatible {
    associatedtype Identifier: Hashable
    associatedtype Item: Hashable
    var identifier: Identifier { get }
    var items: [Item] { get }
}

public struct Sectioned<Identifier: Hashable, Item: Hashable>: SectionCompatible {
    public let identifier: Identifier
    public let items: [Item]
    
    public init<S: Sequence>(_ identifier: Identifier, items: S) where S.Element == Item {
        self.identifier = identifier
        self.items = Array(items)
    }
}
