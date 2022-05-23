//
//  PairAnchor.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 19/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: PairAnchor

public class PairAnchor<Root: LayoutAnchor, Anchor: LayoutAxisAnchor> {
    typealias Layout = Root.Layout
    let root: Root
    var layout: Layout { root.layoutExtractable }
    var keyPaths: KeyPaths {
        fatalError("keyPaths should be overridden")
    }
    var firstAnchor: Anchor {
        layout[keyPath: keyPaths.first]
    }
    var secondAnchor: Anchor {
        layout[keyPath: keyPaths.second]
    }
    
    init(root: Root) {
        self.root = root
    }
}

extension PairAnchor {
    struct KeyPaths {
        let first: KeyPath<LayoutWithAnchors, Anchor>
        let second: KeyPath<LayoutWithAnchors, Anchor>
    }
}

// MARK: Constraint Relation

extension PairAnchor where Root.Layout: UIView, Root: ViewPlanBuilder {
    
    // MARK: Constraint Relation with Other Anchor
    
    public func equal<OtherRoot: LayoutAnchor, Other: PairAnchor<OtherRoot, Anchor>>(to otherAnchor: Other) -> PairAnchorRelation<Root, Anchor> {
        create(.equal, to: otherAnchor)
    }
    
    public func moreThan<OtherRoot: LayoutAnchor, Other: PairAnchor<OtherRoot, Anchor>>(to otherAnchor: Other) -> PairAnchorRelation<Root, Anchor> {
        create(.greaterThanOrEqual, to: otherAnchor)
    }
    
    public func lessThan<OtherRoot: LayoutAnchor, Other: PairAnchor<OtherRoot, Anchor>>(to otherAnchor: Other) -> PairAnchorRelation<Root, Anchor> {
        create(.lessThanOrEqual, to: otherAnchor)
    }
    
    func create<OtherRoot: LayoutAnchor, Other: PairAnchor<OtherRoot, Anchor>>(_ relation: NSLayoutConstraint.Relation, to otherAnchor: Other) -> PairAnchorRelation<Root, Anchor> {
        .init(
            root: root,
            firstPair: .init(
                firstAnchor: firstAnchor.extractable,
                secondAnchor: otherAnchor.firstAnchor.extractable,
                offsetSign: .positive
            ),
            secondPair: .init(
                firstAnchor: secondAnchor.extractable,
                secondAnchor: otherAnchor.secondAnchor.extractable,
                offsetSign: .negative
            ),
            relation: relation
        )
    }
    
    // MARK: Constraint Relation with LayoutWithAnchors
    
    public func equal(to layout: LayoutWithAnchors) -> PairAnchorRelation<Root, Anchor> {
        create(.equal, to: layout)
    }
    
    public func moreThan(to layout: LayoutWithAnchors) -> PairAnchorRelation<Root, Anchor> {
        create(.greaterThanOrEqual, to: layout)
    }
    
    public func lessThan(to layout: LayoutWithAnchors) -> PairAnchorRelation<Root, Anchor> {
        create(.lessThanOrEqual, to: layout)
    }
    
    func create(_ relation: NSLayoutConstraint.Relation, to layout: LayoutWithAnchors) -> PairAnchorRelation<Root, Anchor> {
        .init(
            root: root,
            firstPair: .init(
                firstAnchor: firstAnchor.extractable,
                secondAnchor: layout[keyPath: keyPaths.first].extractable,
                offsetSign: .positive
            ),
            secondPair: .init(
                firstAnchor: secondAnchor.extractable,
                secondAnchor: layout[keyPath: keyPaths.second].extractable,
                offsetSign: .negative
            ),
            relation: relation
        )
    }
    
    // MARK: Constraint Relation with AnonymousLayout
    
    public func equal(with anonymous: AnonymousLayout) -> PairAnchorRelation<Root, Anchor> {
        create(.equal, to: anonymous)
    }
    
    public func moreThan(with anonymous: AnonymousLayout) -> PairAnchorRelation<Root, Anchor> {
        create(.greaterThanOrEqual, to: anonymous)
    }
    
    public func lessThan(with anonymous: AnonymousLayout) -> PairAnchorRelation<Root, Anchor> {
        create(.lessThanOrEqual, to: anonymous)
    }
    
    public func create(_ relation: NSLayoutConstraint.Relation, to anonymous: AnonymousLayout) -> PairAnchorRelation<Root, Anchor> {
        .init(
            root: root,
            firstPair: .init(
                firstAnchor: firstAnchor.extractable,
                secondAnchor: AnonymousAnchorExtractable(keyPath: keyPaths.first, layout: anonymous),
                offsetSign: .positive
            ),
            secondPair: .init(
                firstAnchor: secondAnchor.extractable,
                secondAnchor: AnonymousAnchorExtractable(keyPath: keyPaths.second, layout: anonymous),
                offsetSign: .negative
            ),
            relation: relation
        )
    }
}
#endif
