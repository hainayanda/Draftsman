//
//  DimensionAnchor.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 19/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: DimensionAnchor

public class DimensionAnchor<Root: LayoutAnchor> {
    typealias Layout = Root.Layout
    let root: Root
    var layout: Layout { root.layoutExtractable }
    var keyPath: KeyPath<LayoutWithAnchors, NSLayoutDimension> {
        fatalError("keyPath should be overridden")
    }
    var anchor: NSLayoutDimension {
        layout[keyPath: keyPath]
    }
    
    init(root: Root) {
        self.root = root
    }
}

// MARK: Constraint Relation

extension DimensionAnchor where Root.Layout: UIView, Root: ViewPlanBuilder {
    
    // MARK: Constraint Relation with Other Anchor
    
    public func equal(to otherAnchor: NSLayoutDimension) -> DimensionAnchorRelation<Root> {
        create(.equal, to: otherAnchor)
    }
    
    public func moreThan(to otherAnchor: NSLayoutDimension) -> DimensionAnchorRelation<Root> {
        create(.greaterThanOrEqual, to: otherAnchor)
    }
    
    public func lessThan(to otherAnchor: NSLayoutDimension) -> DimensionAnchorRelation<Root> {
        create(.lessThanOrEqual, to: otherAnchor)
    }
    
    func create(_ relation: NSLayoutConstraint.Relation, to otherAnchor: NSLayoutDimension)  -> DimensionAnchorRelation<Root> {
        .init(
            root: root,
            firstAnchor: anchor.extractable,
            secondAnchor: otherAnchor.extractable,
            relation: relation
        )
    }
    
    // MARK: Constraint Relation with Other NSAnchor
    
    public func equal<OtherRoot: LayoutAnchor, Other: DimensionAnchor<OtherRoot>>(to otherAnchor: Other) -> DimensionAnchorRelation<Root> {
        equal(to: otherAnchor.anchor)
    }
    
    public func moreThan<OtherRoot: LayoutAnchor, Other: DimensionAnchor<OtherRoot>>(to otherAnchor: Other) -> DimensionAnchorRelation<Root> {
        moreThan(to: otherAnchor.anchor)
    }
    
    public func lessThan<OtherRoot: LayoutAnchor, Other: DimensionAnchor<OtherRoot>>(to otherAnchor: Other) -> DimensionAnchorRelation<Root> {
        lessThan(to: otherAnchor.anchor)
    }
    
    // MARK: Constraint Relation with CGFloat
    
    public func equal(to dimension: CGFloat) -> DimensionAnchorConstant<Root> {
        create(.equal, to: dimension)
    }
    
    public func moreThan(to dimension: CGFloat) -> DimensionAnchorConstant<Root> {
        create(.greaterThanOrEqual, to: dimension)
    }
    
    public func lessThan(to dimension: CGFloat) -> DimensionAnchorConstant<Root> {
        create(.lessThanOrEqual, to: dimension)
    }
    
    func create(_ relation: NSLayoutConstraint.Relation, to dimension: CGFloat) -> DimensionAnchorConstant<Root> {
        .init(
            root: root,
            anchor: anchor.extractable,
            relation: relation,
            constant: dimension
        )
    }
    
    // MARK: Constraint Relation with LayoutWithAnchors
    
    public func equal(to layout: LayoutWithAnchors) -> DimensionAnchorRelation<Root> {
        create(.equal, to: layout)
    }
    
    public func moreThan(to layout: LayoutWithAnchors) -> DimensionAnchorRelation<Root> {
        create(.greaterThanOrEqual, to: layout)
    }
    
    public func lessThan(to layout: LayoutWithAnchors) -> DimensionAnchorRelation<Root> {
        create(.lessThanOrEqual, to: layout)
    }
    
    func create(_ relation: NSLayoutConstraint.Relation, to layout: LayoutWithAnchors) -> DimensionAnchorRelation<Root> {
        .init(
            root: root,
            firstAnchor: anchor.extractable,
            secondAnchor: layout[keyPath: keyPath].extractable,
            relation: relation
        )
    }
    
    // MARK: Constraint Relation with AnonymousLayout
    
    public func equal(with anonymous: AnonymousLayout) -> DimensionAnchorRelation<Root> {
        create(.equal, with: anonymous)
    }
    
    public func moreThan(with anonymous: AnonymousLayout) -> DimensionAnchorRelation<Root> {
        create(.greaterThanOrEqual, with: anonymous)
    }
    
    public func lessThan(with anonymous: AnonymousLayout) -> DimensionAnchorRelation<Root> {
        create(.lessThanOrEqual, with: anonymous)
    }
    
    func create(_ relation: NSLayoutConstraint.Relation, with anonymous: AnonymousLayout) -> DimensionAnchorRelation<Root> {
        .init(
            root: root,
            firstAnchor: anchor.extractable,
            secondAnchor: AnonymousAnchorExtractable(keyPath: keyPath, layout: anonymous),
            relation: relation
        )
    }
    
    // MARK: Constraint Relation with DimensionAnonymousAnchor
    
    public func equal(with anonymousAnchor: DimensionAnonymousAnchor) -> DimensionAnchorRelation<Root> {
        create(.equal, with: anonymousAnchor)
    }
    
    public func moreThan(with anonymousAnchor: DimensionAnonymousAnchor) -> DimensionAnchorRelation<Root> {
        create(.greaterThanOrEqual, with: anonymousAnchor)
    }
    
    public func lessThan(with anonymousAnchor: DimensionAnonymousAnchor) -> DimensionAnchorRelation<Root> {
        create(.lessThanOrEqual, with: anonymousAnchor)
    }
    
    func create(_ relation: NSLayoutConstraint.Relation, with anonymousAnchor: DimensionAnonymousAnchor) -> DimensionAnchorRelation<Root> {
        let anonymous = anonymousAnchor.anonymousLayout
        let keyPath = anonymousAnchor.keypath
        return .init(
            root: root,
            firstAnchor: anchor.extractable,
            secondAnchor: AnonymousAnchorExtractable(keyPath: keyPath, layout: anonymous),
            relation: relation
        )
    }
}
#endif
