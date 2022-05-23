//
//  SingleAnchor.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 23/04/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: SingleAnchor

public class SingleAnchor<Root: LayoutAnchor, Anchor: LayoutAxisAnchor> {
    typealias Layout = Root.Layout
    let root: Root
    var layout: Layout { root.layoutExtractable }
    var offsetSign: AnchorOffsetSign {
        fatalError("offsetSign should be overridden")
    }
    var keyPath: KeyPath<LayoutWithAnchors, Anchor> {
        fatalError("keyPath should be overridden")
    }
    var anchor: Anchor {
        layout[keyPath: keyPath]
    }
    
    init(root: Root) {
        self.root = root
    }
}

// MARK: Constraint Relation

extension SingleAnchor where Root.Layout: UIView, Root: ViewPlanBuilder {
    
    // MARK: Constraint Relation with Other Anchor
    
    public func equal(to otherAnchor: Anchor) -> SingleAnchorRelation<Root, Anchor> {
        .init(
            root: root,
            firstAnchor: anchor.extractable,
            secondAnchor: otherAnchor.extractable,
            relation: .equal,
            offsetSign: offsetSign
        )
    }
    
    public func moreThan(to otherAnchor: Anchor) -> SingleAnchorRelation<Root, Anchor> {
        .init(
            root: root,
            firstAnchor: anchor.extractable,
            secondAnchor: otherAnchor.extractable,
            relation: .greaterThanOrEqual,
            offsetSign: offsetSign
        )
    }
    
    public func lessThan(to otherAnchor: Anchor) -> SingleAnchorRelation<Root, Anchor> {
        .init(
            root: root,
            firstAnchor: anchor.extractable,
            secondAnchor: otherAnchor.extractable,
            relation: .lessThanOrEqual,
            offsetSign: offsetSign
        )
    }
    
    // MARK: Constraint Relation with Other NSAnchor
    
    public func equal<OtherRoot: LayoutAnchor, Other: SingleAnchor<OtherRoot, Anchor>>(to otherAnchor: Other) -> SingleAnchorRelation<Root, Anchor> {
        equal(to: otherAnchor.anchor)
    }
    
    public func moreThan<OtherRoot, Other: SingleAnchor<OtherRoot, Anchor>>(to otherAnchor: Other) -> SingleAnchorRelation<Root, Anchor> {
        moreThan(to: otherAnchor.anchor)
    }
    
    public func lessThan<OtherRoot, Other: SingleAnchor<OtherRoot, Anchor>>(to otherAnchor: Other) -> SingleAnchorRelation<Root, Anchor> {
        lessThan(to: otherAnchor.anchor)
    }
    
    // MARK: Constraint Relation with LayoutWithAnchors
    
    public func equal(to layout: LayoutWithAnchors) -> SingleAnchorRelation<Root, Anchor> {
        create(.equal, to: layout)
    }
    
    public func moreThan(to layout: LayoutWithAnchors) -> SingleAnchorRelation<Root, Anchor> {
        create(.greaterThanOrEqual, to: layout)
    }
    
    public func lessThan(to layout: LayoutWithAnchors) -> SingleAnchorRelation<Root, Anchor> {
        create(.lessThanOrEqual, to: layout)
    }
    
    func create(_ relation: NSLayoutConstraint.Relation, to layout: LayoutWithAnchors) -> SingleAnchorRelation<Root, Anchor> {
        .init(
            root: root,
            firstAnchor: anchor.extractable,
            secondAnchor: layout[keyPath: keyPath].extractable,
            relation: relation,
            offsetSign: offsetSign
        )
    }
    
    // MARK: Constraint Relation with AnonymousLayout
    
    public func equal(with anonymous: AnonymousLayout) -> SingleAnchorRelation<Root, Anchor> {
        create(.equal, to: anonymous)
    }
    
    public func moreThan(with anonymous: AnonymousLayout) -> SingleAnchorRelation<Root, Anchor> {
        create(.greaterThanOrEqual, to: anonymous)
    }
    
    public func lessThan(with anonymous: AnonymousLayout) -> SingleAnchorRelation<Root, Anchor> {
        create(.lessThanOrEqual, to: anonymous)
    }
    
    func create(_ relation: NSLayoutConstraint.Relation, to anonymous: AnonymousLayout) -> SingleAnchorRelation<Root, Anchor> {
        .init(
            root: root,
            firstAnchor: anchor.extractable,
            secondAnchor: AnonymousAnchorExtractable(keyPath: keyPath, layout: anonymous),
            relation: relation,
            offsetSign: offsetSign
        )
    }
}

// MARK: Constraint Relation with XAnonymousAnchor

extension SingleAnchor where Root.Layout: UIView, Root: ViewPlanBuilder, Anchor == NSLayoutXAxisAnchor {
    
    public func equal(with anonymousAnchor: XAnonymousAnchor) -> SingleAnchorRelation<Root, Anchor> {
        create(.equal, to: anonymousAnchor)
    }
    
    public func moreThan(with anonymousAnchor: XAnonymousAnchor) -> SingleAnchorRelation<Root, Anchor> {
        create(.greaterThanOrEqual, to: anonymousAnchor)
    }
    
    public func lessThan(with anonymousAnchor: XAnonymousAnchor) -> SingleAnchorRelation<Root, Anchor> {
        create(.lessThanOrEqual, to: anonymousAnchor)
    }
    
    func create(_ relation: NSLayoutConstraint.Relation, to anonymousAnchor: XAnonymousAnchor) -> SingleAnchorRelation<Root, Anchor> {
        let keyPath = anonymousAnchor.keypath
        let anonymous = anonymousAnchor.anonymousLayout
        return .init(
            root: root,
            firstAnchor: anchor.extractable,
            secondAnchor: AnonymousAnchorExtractable(keyPath: keyPath, layout: anonymous),
            relation: relation,
            offsetSign: offsetSign
        )
    }
}

// MARK: Constraint Relation with YAnonymousAnchor

extension SingleAnchor where Root.Layout: UIView, Root: ViewPlanBuilder, Anchor == NSLayoutYAxisAnchor {
    
    public func equal(with anonymousAnchor: YAnonymousAnchor) -> SingleAnchorRelation<Root, Anchor> {
        create(.equal, to: anonymousAnchor)
    }
    
    public func moreThan(with anonymousAnchor: YAnonymousAnchor) -> SingleAnchorRelation<Root, Anchor> {
        create(.greaterThanOrEqual, to: anonymousAnchor)
    }
    
    public func lessThan(with anonymousAnchor: YAnonymousAnchor) -> SingleAnchorRelation<Root, Anchor> {
        create(.lessThanOrEqual, to: anonymousAnchor)
    }
    
    func create(_ relation: NSLayoutConstraint.Relation, to anonymousAnchor: YAnonymousAnchor) -> SingleAnchorRelation<Root, Anchor> {
        let keyPath = anonymousAnchor.keypath
        let anonymous = anonymousAnchor.anonymousLayout
        return .init(
            root: root,
            firstAnchor: anchor.extractable,
            secondAnchor: AnonymousAnchorExtractable(keyPath: keyPath, layout: anonymous),
            relation: relation,
            offsetSign: offsetSign
        )
    }
}
#endif
