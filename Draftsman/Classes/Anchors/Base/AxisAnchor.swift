//
//  AxisAnchor.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 19/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: AxisAnchor

public class AxisAnchor<Root: LayoutAnchor> {
    typealias Layout = Root.Layout
    let root: Root
    var layout: Layout { root.layoutExtractable }
    var keyPaths: KeyPaths {
        fatalError("keyPaths should be overridden")
    }
    var xOffsetSign: AnchorOffsetSign {
        fatalError("offsetSign should be overridden")
    }
    var yOffsetSign: AnchorOffsetSign {
        fatalError("offsetSign should be overridden")
    }
    var xAnchor: NSLayoutXAxisAnchor {
        layout[keyPath: keyPaths.xAnchor]
    }
    var yAnchor: NSLayoutYAxisAnchor {
        layout[keyPath: keyPaths.yAnchor]
    }
    
    init(root: Root) {
        self.root = root
    }
}

extension AxisAnchor {
    struct KeyPaths {
        let xAnchor: KeyPath<LayoutWithAnchors, NSLayoutXAxisAnchor>
        let yAnchor: KeyPath<LayoutWithAnchors, NSLayoutYAxisAnchor>
    }
}

// MARK: Constraint Relation

extension AxisAnchor where Root.Layout: UIView, Root: ViewPlanBuilder {
    
    // MARK: Constraint Relation with Other Anchor
    
    public func equal<OtherRoot: LayoutAnchor, Other: AxisAnchor<OtherRoot>>(to otherAnchor: Other) -> AxisAnchorRelation<Root> {
        create(.equal, to: otherAnchor)
    }
    
    public func moreThan<OtherRoot: LayoutAnchor, Other: AxisAnchor<OtherRoot>>(to otherAnchor: Other) -> AxisAnchorRelation<Root> {
        create(.greaterThanOrEqual, to: otherAnchor)
    }
    
    public func lessThan<OtherRoot: LayoutAnchor, Other: AxisAnchor<OtherRoot>>(to otherAnchor: Other) -> AxisAnchorRelation<Root> {
        create(.lessThanOrEqual, to: otherAnchor)
    }
    
    func create<OtherRoot: LayoutAnchor, Other: AxisAnchor<OtherRoot>>(_ relation: NSLayoutConstraint.Relation, to otherAnchor: Other) -> AxisAnchorRelation<Root> {
        .init(
            root: root,
            xPair: .init(
                firstAnchor: xAnchor.extractable,
                secondAnchor: otherAnchor.xAnchor.extractable,
                offsetSign: xOffsetSign
            ),
            yPair: .init(
                firstAnchor: yAnchor.extractable,
                secondAnchor: otherAnchor.yAnchor.extractable,
                offsetSign: yOffsetSign
            ),
            relation: relation
        )
    }
    
    // MARK: Constraint Relation with LayoutWithAnchors
    
    public func equal(to layout: LayoutWithAnchors) -> AxisAnchorRelation<Root> {
        create(.equal, to: layout)
    }
    
    public func moreThan(to layout: LayoutWithAnchors) -> AxisAnchorRelation<Root> {
        create(.greaterThanOrEqual, to: layout)
    }
    
    public func lessThan(to layout: LayoutWithAnchors) -> AxisAnchorRelation<Root> {
        create(.lessThanOrEqual, to: layout)
    }
    
    func create(_ relation: NSLayoutConstraint.Relation, to layout: LayoutWithAnchors) -> AxisAnchorRelation<Root> {
        .init(
            root: root,
            xPair: .init(
                firstAnchor: xAnchor.extractable,
                secondAnchor: layout[keyPath: keyPaths.xAnchor].extractable,
                offsetSign: xOffsetSign
            ),
            yPair: .init(
                firstAnchor: yAnchor.extractable,
                secondAnchor: layout[keyPath: keyPaths.yAnchor].extractable,
                offsetSign: yOffsetSign
            ),
            relation: relation
        )
    }
    
    // MARK: Constraint Relation with AnonymousLayout
    
    public func equal(with anonymous: AnonymousLayout) -> AxisAnchorRelation<Root> {
        create(.equal, to: anonymous)
    }
    
    public func moreThan(with anonymous: AnonymousLayout) -> AxisAnchorRelation<Root> {
        create(.greaterThanOrEqual, to: anonymous)
    }
    
    public func lessThan(with anonymous: AnonymousLayout) -> AxisAnchorRelation<Root> {
        create(.lessThanOrEqual, to: anonymous)
    }
    
    func create(_ relation: NSLayoutConstraint.Relation, to anonymous: AnonymousLayout) -> AxisAnchorRelation<Root> {
        .init(
            root: root,
            xPair: .init(
                firstAnchor: xAnchor.extractable,
                secondAnchor: AnonymousAnchorExtractable(keyPath: keyPaths.xAnchor, layout: anonymous),
                offsetSign: xOffsetSign
            ),
            yPair: .init(
                firstAnchor: yAnchor.extractable,
                secondAnchor: AnonymousAnchorExtractable(keyPath: keyPaths.yAnchor, layout: anonymous),
                offsetSign: yOffsetSign
            ),
            relation: relation
        )
    }
    
    // MARK: Constraint Relation with XYAnonymousAnchor
    
    public func equal(with anonymousAnchor: XYAnonymousAnchor) -> AxisAnchorRelation<Root> {
        create(.equal, to: anonymousAnchor)
    }
    
    public func moreThan(with anonymousAnchor: XYAnonymousAnchor) -> AxisAnchorRelation<Root> {
        create(.greaterThanOrEqual, to: anonymousAnchor)
    }
    
    public func lessThan(with anonymousAnchor: XYAnonymousAnchor) -> AxisAnchorRelation<Root> {
        create(.lessThanOrEqual, to: anonymousAnchor)
    }
    
    func create(_ relation: NSLayoutConstraint.Relation, to anonymousAnchor: XYAnonymousAnchor) -> AxisAnchorRelation<Root> {
        let anonymous = anonymousAnchor.anonymousLayout
        let xKeyPath = anonymousAnchor.xKeyPath
        let yKeyPath = anonymousAnchor.yKeyPath
        return .init(
            root: root,
            xPair: .init(
                firstAnchor: xAnchor.extractable,
                secondAnchor: AnonymousAnchorExtractable(keyPath: xKeyPath, layout: anonymous),
                offsetSign: xOffsetSign
            ),
            yPair: .init(
                firstAnchor: yAnchor.extractable,
                secondAnchor: AnonymousAnchorExtractable(keyPath: yKeyPath, layout: anonymous),
                offsetSign: yOffsetSign
            ),
            relation: relation
        )
    }
}
#endif
