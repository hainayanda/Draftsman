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
