//
//  QuadAnchor.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 19/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: QuadAnchor

public class QuadAnchor<Root: LayoutAnchor> {
    typealias Layout = Root.Layout
    let root: Root
    var layout: Layout { root.layoutExtractable }
    var biXKeyPaths: BiKeyPaths<NSLayoutXAxisAnchor> {
        fatalError("biXKeyPaths should be overridden")
    }
    var biYKeyPaths: BiKeyPaths<NSLayoutYAxisAnchor> {
        .init(firstAnchor: \.topAnchor, secondAnchor: \.bottomAnchor)
    }
    var firstBiXAnchor: NSLayoutXAxisAnchor {
        layout[keyPath: biXKeyPaths.firstAnchor]
    }
    var secondBiXAnchor: NSLayoutXAxisAnchor {
        layout[keyPath: biXKeyPaths.secondAnchor]
    }
    var firstBiYAnchor: NSLayoutYAxisAnchor {
        layout[keyPath: biYKeyPaths.firstAnchor]
    }
    var secondBiYAnchor: NSLayoutYAxisAnchor {
        layout[keyPath: biYKeyPaths.secondAnchor]
    }
    
    init(root: Root) {
        self.root = root
    }
}

extension QuadAnchor {
    struct BiKeyPaths<Anchor: LayoutAxisAnchor> {
        let firstAnchor: KeyPath<LayoutWithAnchors, Anchor>
        let secondAnchor: KeyPath<LayoutWithAnchors, Anchor>
    }
}

// MARK: Constraint Relation

extension QuadAnchor where Root.Layout: UIView, Root: ViewPlanBuilder {
    
    // MARK: Constraint Relation with Other Anchor
    
    public func equal<OtherRoot: LayoutAnchor, Other: QuadAnchor<OtherRoot>>(to otherAnchor: Other) -> QuadAnchorRelation<Root> {
        create(.equal, to: otherAnchor)
    }
    
    public func moreThan<OtherRoot: LayoutAnchor, Other: QuadAnchor<OtherRoot>>(to otherAnchor: Other) -> QuadAnchorRelation<Root> {
        create(.greaterThanOrEqual, to: otherAnchor)
    }
    
    public func lessThan<OtherRoot: LayoutAnchor, Other: QuadAnchor<OtherRoot>>(to otherAnchor: Other) -> QuadAnchorRelation<Root> {
        create(.lessThanOrEqual, to: otherAnchor)
    }
    
    func create<OtherRoot: LayoutAnchor, Other: QuadAnchor<OtherRoot>>(_ relation: NSLayoutConstraint.Relation, to otherAnchor: Other) -> QuadAnchorRelation<Root> {
        .init(
            root: root,
            firstBiXPair: .init(
                firstAnchor: firstBiXAnchor.extractable,
                secondAnchor: otherAnchor.firstBiXAnchor.extractable,
                offsetSign: .positive
            ),
            secondBiXPair: .init(
                firstAnchor: secondBiXAnchor.extractable,
                secondAnchor: otherAnchor.secondBiXAnchor.extractable,
                offsetSign: .negative
            ),
            firstBiYPair: .init(
                firstAnchor: firstBiYAnchor.extractable,
                secondAnchor: otherAnchor.firstBiYAnchor.extractable,
                offsetSign: .positive
            ),
            secondBiYPair: .init(
                firstAnchor: secondBiYAnchor.extractable,
                secondAnchor: otherAnchor.secondBiYAnchor.extractable,
                offsetSign: .negative
            ),
            relation: relation
        )
    }
    
    // MARK: Constraint Relation with LayoutWithAnchors
    
    public func equal(to layout: LayoutWithAnchors) -> QuadAnchorRelation<Root> {
        create(.equal, to: layout)
    }
    
    public func moreThan(to layout: LayoutWithAnchors) -> QuadAnchorRelation<Root> {
        create(.greaterThanOrEqual, to: layout)
    }
    
    public func lessThan(to layout: LayoutWithAnchors) -> QuadAnchorRelation<Root> {
        create(.lessThanOrEqual, to: layout)
    }
    
    func create(_ relation: NSLayoutConstraint.Relation, to layout: LayoutWithAnchors) -> QuadAnchorRelation<Root> {
        .init(
            root: root,
            firstBiXPair: .init(
                firstAnchor: firstBiXAnchor.extractable,
                secondAnchor: layout[keyPath: biXKeyPaths.firstAnchor].extractable,
                offsetSign: .positive
            ),
            secondBiXPair: .init(
                firstAnchor: secondBiXAnchor.extractable,
                secondAnchor: layout[keyPath: biXKeyPaths.secondAnchor].extractable,
                offsetSign: .negative
            ),
            firstBiYPair: .init(
                firstAnchor: firstBiYAnchor.extractable,
                secondAnchor: layout[keyPath: biYKeyPaths.firstAnchor].extractable,
                offsetSign: .positive
            ),
            secondBiYPair: .init(
                firstAnchor: secondBiYAnchor.extractable,
                secondAnchor: layout[keyPath: biYKeyPaths.secondAnchor].extractable,
                offsetSign: .negative
            ),
            relation: relation
        )
    }
    
    // MARK: Constraint Relation with AnonymousLayout
    
    public func equal(with anonymous: AnonymousLayout) -> QuadAnchorRelation<Root> {
        create(.equal, to: anonymous)
    }
    
    public func moreThan(with anonymous: AnonymousLayout) -> QuadAnchorRelation<Root> {
        create(.greaterThanOrEqual, to: anonymous)
    }
    
    public func lessThan(with anonymous: AnonymousLayout) -> QuadAnchorRelation<Root> {
        create(.lessThanOrEqual, to: anonymous)
    }
    
    func create(_ relation: NSLayoutConstraint.Relation, to anonymous: AnonymousLayout) -> QuadAnchorRelation<Root> {
        .init(
            root: root,
            firstBiXPair: .init(
                firstAnchor: firstBiXAnchor.extractable,
                secondAnchor: AnonymousAnchorExtractable(keyPath: biXKeyPaths.firstAnchor, layout: anonymous),
                offsetSign: .positive
            ),
            secondBiXPair: .init(
                firstAnchor: secondBiXAnchor.extractable,
                secondAnchor: AnonymousAnchorExtractable(keyPath: biXKeyPaths.secondAnchor, layout: anonymous),
                offsetSign: .negative
            ),
            firstBiYPair: .init(
                firstAnchor: firstBiYAnchor.extractable,
                secondAnchor: AnonymousAnchorExtractable(keyPath: biYKeyPaths.firstAnchor, layout: anonymous),
                offsetSign: .positive
            ),
            secondBiYPair: .init(
                firstAnchor: secondBiYAnchor.extractable,
                secondAnchor: AnonymousAnchorExtractable(keyPath: biYKeyPaths.secondAnchor, layout: anonymous),
                offsetSign: .negative
            ),
            relation: relation
        )
    }
}
#endif
