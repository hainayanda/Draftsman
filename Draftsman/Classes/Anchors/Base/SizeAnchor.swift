//
//  SizeAnchor.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 19/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: SizeAnchor

public class SizeAnchor<Root: LayoutAnchor> {
    typealias Layout = Root.Layout
    let root: Root
    var layout: Layout { root.layoutExtractable }
    var widthKeyPath: KeyPath<LayoutWithAnchors, NSLayoutDimension> {
        \.widthAnchor
    }
    var heightKeyPath: KeyPath<LayoutWithAnchors, NSLayoutDimension> {
        \.heightAnchor
    }
    var widthAnchor: NSLayoutDimension {
        layout[keyPath: widthKeyPath]
    }
    var heightAnchor: NSLayoutDimension {
        layout[keyPath: heightKeyPath]
    }
    
    init(root: Root) {
        self.root = root
    }
}

// MARK: Constraint Relation

extension SizeAnchor where Root.Layout: UIView, Root: ViewPlanBuilder {
    
    // MARK: Constraint Relation with Other Anchor
    
    public func equal<OtherRoot: LayoutAnchor, Other: SizeAnchor<OtherRoot>>(to otherAnchor: Other) -> SizeAnchorRelation<Root> {
        create(.equal, to: otherAnchor)
    }
    
    public func moreThan<OtherRoot: LayoutAnchor, Other: SizeAnchor<OtherRoot>>(to otherAnchor: Other) -> SizeAnchorRelation<Root> {
        create(.greaterThanOrEqual, to: otherAnchor)
    }
    
    public func lessThan<OtherRoot: LayoutAnchor, Other: SizeAnchor<OtherRoot>>(to otherAnchor: Other) -> SizeAnchorRelation<Root> {
        create(.lessThanOrEqual, to: otherAnchor)
    }
    
    func create<OtherRoot: LayoutAnchor, Other: SizeAnchor<OtherRoot>>(_ relation: NSLayoutConstraint.Relation, to otherAnchor: Other) -> SizeAnchorRelation<Root> {
        .init(
            root: root,
            biWidthAnchor: .init(
                firstAnchor: widthAnchor.extractable,
                secondAnchor: otherAnchor.widthAnchor.extractable
            ),
            biHeightAnchor: .init(
                firstAnchor: heightAnchor.extractable,
                secondAnchor: otherAnchor.heightAnchor.extractable
            ),
            relation: relation
        )
    }
    
    // MARK: Constraint Relation with CGFloat
    
    public func equal(with size: CGSize) -> SizeAnchorConstant<Root> {
        create(.equal, with: size)
    }
    
    public func moreThan(with size: CGSize) -> SizeAnchorConstant<Root> {
        create(.greaterThanOrEqual, with: size)
    }
    
    public func lessThan(with size: CGSize) -> SizeAnchorConstant<Root> {
        create(.lessThanOrEqual, with: size)
    }
    
    func create(_ relation: NSLayoutConstraint.Relation, with size: CGSize) -> SizeAnchorConstant<Root> {
        .init(
            root: root,
            widthAnchor: widthAnchor,
            heightAnchor: heightAnchor,
            relation: relation,
            constant: size
        )
    }
    
    // MARK: Constraint Relation with LayoutWithAnchors
    
    public func equal(to layout: LayoutWithAnchors) -> SizeAnchorRelation<Root> {
        create(.equal, to: layout)
    }
    
    public func moreThan(to layout: LayoutWithAnchors) -> SizeAnchorRelation<Root> {
        create(.greaterThanOrEqual, to: layout)
    }
    
    public func lessThan(to layout: LayoutWithAnchors) -> SizeAnchorRelation<Root> {
        create(.lessThanOrEqual, to: layout)
    }
    
    func create(_ relation: NSLayoutConstraint.Relation, to layout: LayoutWithAnchors) -> SizeAnchorRelation<Root> {
        .init(
            root: root,
            biWidthAnchor: .init(
                firstAnchor: widthAnchor.extractable,
                secondAnchor: layout.widthAnchor.extractable
            ),
            biHeightAnchor: .init(
                firstAnchor: heightAnchor.extractable,
                secondAnchor: layout.heightAnchor.extractable
            ),
            relation: relation
        )
    }
    
    // MARK: Constraint Relation with AnonymousLayout
    
    public func equal(with anonymous: AnonymousLayout) -> SizeAnchorRelation<Root> {
        create(.equal, with: anonymous)
    }
    
    public func moreThan(with anonymous: AnonymousLayout) -> SizeAnchorRelation<Root> {
        create(.greaterThanOrEqual, with: anonymous)
    }
    
    public func lessThan(with anonymous: AnonymousLayout) -> SizeAnchorRelation<Root> {
        create(.lessThanOrEqual, with: anonymous)
    }
    
    func create(_ relation: NSLayoutConstraint.Relation, with anonymous: AnonymousLayout) -> SizeAnchorRelation<Root> {
        .init(
            root: root,
            biWidthAnchor: .init(
                firstAnchor: widthAnchor.extractable,
                secondAnchor: AnonymousAnchorExtractable(keyPath: \.widthAnchor, layout: anonymous)
            ),
            biHeightAnchor: .init(
                firstAnchor: heightAnchor.extractable,
                secondAnchor: AnonymousAnchorExtractable(keyPath: \.heightAnchor, layout: anonymous)
            ),
            relation: relation
        )
    }
}
#endif
