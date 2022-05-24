//
//  AnchorExtractable.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 20/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

class AnchorExtractable<Anchor> {
    func anchor(from context: PlanContext) -> Anchor {
        fatalError("anchor(from:) should be overridden")
    }
}

class PlainAnchorExtractable<Anchor>: AnchorExtractable<Anchor> {
    let anchor: Anchor
    
    init(anchor: Anchor) {
        self.anchor = anchor
    }
    
    override func anchor(from context: PlanContext) -> Anchor {
        anchor
    }
}

class LayoutAnchorExtractable<Anchor>: AnchorExtractable<Anchor> {
    let keyPath: KeyPath<LayoutWithAnchors, Anchor>
    let layout: LayoutWithAnchors
    
    init(keyPath: KeyPath<LayoutWithAnchors, Anchor>, layout: LayoutWithAnchors) {
        self.keyPath = keyPath
        self.layout = layout
    }
    
    override func anchor(from context: PlanContext) -> Anchor {
        layout[keyPath: keyPath]
    }
}

class AnonymousAnchorExtractable<Anchor>: AnchorExtractable<Anchor> {
    let keyPath: KeyPath<LayoutWithAnchors, Anchor>
    let layout: AnonymousLayout
    
    init(keyPath: KeyPath<LayoutWithAnchors, Anchor>, layout: AnonymousLayout) {
        self.keyPath = keyPath
        self.layout = layout
    }
    
    override func anchor(from context: PlanContext) -> Anchor {
        context.layout(of: layout)[keyPath: keyPath]
    }
}

@dynamicMemberLookup
struct LayoutAnchorExtractor {
    let root: LayoutWithAnchors
    
    subscript<Anchor>(dynamicMember keyPath: KeyPath<LayoutWithAnchors, Anchor>) -> AnchorExtractable<Anchor> {
        return LayoutAnchorExtractable(keyPath: keyPath, layout: root)
    }
}

@dynamicMemberLookup
struct AnonymousAnchorExtractor {
    let root: AnonymousLayout
    
    subscript<Anchor>(dynamicMember keyPath: KeyPath<LayoutWithAnchors, Anchor>) -> AnchorExtractable<Anchor> {
        return AnonymousAnchorExtractable(keyPath: keyPath, layout: root)
    }
}

extension LayoutWithAnchors {
    var exctractable: LayoutAnchorExtractor {
        .init(root: self)
    }
}

extension AnonymousLayout {
    var exctractable: AnonymousAnchorExtractor {
        .init(root: self)
    }
}

extension LayoutAxisAnchor {
    var extractable: AnchorExtractable<Self> {
        PlainAnchorExtractable(anchor: self)
    }
}

extension NSLayoutDimension {
    var extractable: AnchorExtractable<NSLayoutDimension> {
        PlainAnchorExtractable(anchor: self)
    }
}
#endif
