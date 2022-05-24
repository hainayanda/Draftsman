//
//  TriEgdesAnchor.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 19/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: TriAnchor

enum TriAnchorType {
    case allButRight
    case allButTop
    case allButLeft
    case allButBottom
}

public class TriAnchor<Root: LayoutAnchor, UniAnchor: LayoutAxisAnchor, BiAnchor: LayoutAxisAnchor> {
    typealias Layout = Root.Layout
    let root: Root
    var type: TriAnchorType {
        fatalError("type should be overridden")
    }
    var layout: Layout { root.layoutExtractable }
    var uniOffsetSign: AnchorOffsetSign {
        switch type {
        case .allButRight, .allButBottom:
            return .positive
        case .allButTop, .allButLeft:
            return .negative
        }
    }
    var uniKeyPath: KeyPath<LayoutWithAnchors, UniAnchor> {
        fatalError("uniKeyPath should be overridden")
    }
    var biKeyPaths: BiKeyPaths {
        fatalError("biKeyPaths should be overridden")
    }
    var uniAnchor: UniAnchor {
        layout[keyPath: uniKeyPath]
    }
    var firstBiAnchor: BiAnchor {
        layout[keyPath: biKeyPaths.firstAnchor]
    }
    var secondBiAnchor: BiAnchor {
        layout[keyPath: biKeyPaths.secondAnchor]
    }
    
    init(root: Root) {
        self.root = root
    }
}

extension TriAnchor {
    struct BiKeyPaths {
        let firstAnchor: KeyPath<LayoutWithAnchors, BiAnchor>
        let secondAnchor: KeyPath<LayoutWithAnchors, BiAnchor>
    }
}

// MARK: Constraint Relation

extension TriAnchor where Root.Layout: UIView, Root: ViewPlanBuilder {
    
    // MARK: Constraint Relation with Other Anchor
    
    public func equal<OtherRoot: LayoutAnchor, Other: TriAnchor<OtherRoot, UniAnchor, BiAnchor>>(to otherAnchor: Other) -> TriAnchorRelation<Root, UniAnchor, BiAnchor> {
        create(.equal, to: otherAnchor)
    }
    
    public func moreThan<OtherRoot: LayoutAnchor, Other: TriAnchor<OtherRoot, UniAnchor, BiAnchor>>(to otherAnchor: Other) -> TriAnchorRelation<Root, UniAnchor, BiAnchor> {
        create(.greaterThanOrEqual, to: otherAnchor)
    }
    
    public func lessThan<OtherRoot: LayoutAnchor, Other: TriAnchor<OtherRoot, UniAnchor, BiAnchor>>(to otherAnchor: Other) -> TriAnchorRelation<Root, UniAnchor, BiAnchor> {
        create(.lessThanOrEqual, to: otherAnchor)
    }
    
    func create<OtherRoot: LayoutAnchor, Other: TriAnchor<OtherRoot, UniAnchor, BiAnchor>>(_ relation: NSLayoutConstraint.Relation, to otherAnchor: Other) -> TriAnchorRelation<Root, UniAnchor, BiAnchor> {
        .init(
            root: root,
            type: type,
            uniPair: .init(
                firstAnchor: uniAnchor.extractable,
                secondAnchor: otherAnchor.uniAnchor.extractable,
                offsetSign: uniOffsetSign
            ),
            firstBiPair: .init(
                firstAnchor: firstBiAnchor.extractable,
                secondAnchor: otherAnchor.firstBiAnchor.extractable,
                offsetSign: .positive
            ),
            secondBiPair: .init(
                firstAnchor: secondBiAnchor.extractable,
                secondAnchor: otherAnchor.secondBiAnchor.extractable,
                offsetSign: .negative
            ),
            relation: relation
        )
    }
    
    // MARK: Constraint Relation with Other Layout
    
    public func equal(to layout: LayoutWithAnchors) -> TriAnchorRelation<Root, UniAnchor, BiAnchor> {
        create(.equal, to: layout)
    }
    
    public func moreThan(to layout: LayoutWithAnchors) -> TriAnchorRelation<Root, UniAnchor, BiAnchor> {
        create(.greaterThanOrEqual, to: layout)
    }
    
    public func lessThan(to layout: LayoutWithAnchors) -> TriAnchorRelation<Root, UniAnchor, BiAnchor> {
        create(.lessThanOrEqual, to: layout)
    }
    
    func create(_ relation: NSLayoutConstraint.Relation, to layout: LayoutWithAnchors) -> TriAnchorRelation<Root, UniAnchor, BiAnchor> {
        .init(
            root: root,
            type: type,
            uniPair: .init(
                firstAnchor: uniAnchor.extractable,
                secondAnchor: layout[keyPath: uniKeyPath].extractable,
                offsetSign: uniOffsetSign
            ),
            firstBiPair: .init(
                firstAnchor: firstBiAnchor.extractable,
                secondAnchor: layout[keyPath: biKeyPaths.firstAnchor].extractable,
                offsetSign: .positive
            ),
            secondBiPair: .init(
                firstAnchor: secondBiAnchor.extractable,
                secondAnchor: layout[keyPath: biKeyPaths.firstAnchor].extractable,
                offsetSign: .negative
            ),
            relation: relation
        )
    }
    
    // MARK: Constraint Relation with AnonymousLayout
    
    public func equal(with anonymous: AnonymousLayout) -> TriAnchorRelation<Root, UniAnchor, BiAnchor> {
        create(.equal, to: anonymous)
    }
    
    public func moreThan(with anonymous: AnonymousLayout) -> TriAnchorRelation<Root, UniAnchor, BiAnchor> {
        create(.greaterThanOrEqual, to: anonymous)
    }
    
    public func lessThan(with anonymous: AnonymousLayout) -> TriAnchorRelation<Root, UniAnchor, BiAnchor> {
        create(.lessThanOrEqual, to: anonymous)
    }
    
    func create(_ relation: NSLayoutConstraint.Relation, to anonymous: AnonymousLayout) -> TriAnchorRelation<Root, UniAnchor, BiAnchor> {
        .init(
            root: root,
            type: type,
            uniPair: .init(
                firstAnchor: uniAnchor.extractable,
                secondAnchor: AnonymousAnchorExtractable(keyPath: uniKeyPath, layout: anonymous),
                offsetSign: uniOffsetSign
            ),
            firstBiPair: .init(
                firstAnchor: firstBiAnchor.extractable,
                secondAnchor: AnonymousAnchorExtractable(keyPath: biKeyPaths.firstAnchor, layout: anonymous),
                offsetSign: .positive
            ),
            secondBiPair: .init(
                firstAnchor: secondBiAnchor.extractable,
                secondAnchor: AnonymousAnchorExtractable(keyPath: biKeyPaths.secondAnchor, layout: anonymous),
                offsetSign: .negative
            ),
            relation: relation
        )
    }
}
#endif
