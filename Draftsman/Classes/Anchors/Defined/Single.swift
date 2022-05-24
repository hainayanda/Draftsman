//
//  Single.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 19/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: TopAnchor

public final class TopAnchor<Root: LayoutAnchor>: SingleAnchor<Root, NSLayoutYAxisAnchor> {
    override var keyPath: KeyPath<LayoutWithAnchors, NSLayoutYAxisAnchor> {
        \.topAnchor
    }
    
    override var offsetSign: AnchorOffsetSign {
        .positive
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
    // MARK: Extended Anchors
    
    public var left: TopLeftAnchor<Root> {
        .init(root: root)
    }
    
    public var bottom: VerticalAnchor<Root> {
        .init(root: root)
    }
    
    public var right: TopRightAnchor<Root> {
        .init(root: root)
    }
    
    public var leading: TopLeadingAnchor<Root> {
        .init(root: root)
    }
    
    public var trailing: TopTrailingAnchor<Root> {
        .init(root: root)
    }
    
    public var horizontal: AllButBottomAnchor<Root> {
        .init(root: root)
    }
    
    public var localizedHorizontal: AllLocalizedButBottomAnchor<Root> {
        .init(root: root)
    }
    
}

// MARK: LeftAnchor

public final class LeftAnchor<Root: LayoutAnchor>: SingleAnchor<Root, NSLayoutXAxisAnchor> {
    override var keyPath: KeyPath<LayoutWithAnchors, NSLayoutXAxisAnchor> {
        \.leftAnchor
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
    override var offsetSign: AnchorOffsetSign {
        .positive
    }
    
    // MARK: Extended Anchors
    
    public var top: TopLeftAnchor<Root> {
        .init(root: root)
    }
    
    public var bottom: BottomLeftAnchor<Root> {
        .init(root: root)
    }
    
    public var right: HorizontalAnchor<Root> {
        .init(root: root)
    }
    
    public var vertical: AllButRightAnchor<Root> {
        .init(root: root)
    }
}

// MARK: BottomAnchor

public final class BottomAnchor<Root: LayoutAnchor>: SingleAnchor<Root, NSLayoutYAxisAnchor> {
    override var keyPath: KeyPath<LayoutWithAnchors, NSLayoutYAxisAnchor> {
        \.bottomAnchor
    }
    
    override var offsetSign: AnchorOffsetSign {
        .negative
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
    // MARK: Extended Anchors
    
    public var top: VerticalAnchor<Root> {
        .init(root: root)
    }
    
    public var left: BottomLeftAnchor<Root> {
        .init(root: root)
    }
    
    public var right: BottomRightAnchor<Root> {
        .init(root: root)
    }
    
    public var leading: BottomLeadingAnchor<Root> {
        .init(root: root)
    }
    
    public var trailing: BottomTrailingAnchor<Root> {
        .init(root: root)
    }
    
    public var horizontal: AllButTopAnchor<Root> {
        .init(root: root)
    }
    
    public var localizedHorizontal: AllLocalizedButTopAnchor<Root> {
        .init(root: root)
    }
}

// MARK: RightAnchor

public final class RightAnchor<Root: LayoutAnchor>: SingleAnchor<Root, NSLayoutXAxisAnchor> {
    override var keyPath: KeyPath<LayoutWithAnchors, NSLayoutXAxisAnchor> {
        \.rightAnchor
    }
    
    override var offsetSign: AnchorOffsetSign {
        .negative
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
    // MARK: Extended Anchors
    
    public var top: TopRightAnchor<Root> {
        .init(root: root)
    }
    
    public var left: HorizontalAnchor<Root> {
        .init(root: root)
    }
    
    public var bottom: BottomRightAnchor<Root> {
        .init(root: root)
    }
    
    public var vertical: AllButLeftAnchor<Root> {
        .init(root: root)
    }
}

// MARK: LeadingAnchor

public final class LeadingAnchor<Root: LayoutAnchor>: SingleAnchor<Root, NSLayoutXAxisAnchor> {
    override var keyPath: KeyPath<LayoutWithAnchors, NSLayoutXAxisAnchor> {
        \.leadingAnchor
    }
    
    override var offsetSign: AnchorOffsetSign {
        .positive
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
    // MARK: Extended Anchors
    
    public var top: TopLeadingAnchor<Root> {
        .init(root: root)
    }
    
    public var bottom: BottomLeadingAnchor<Root> {
        .init(root: root)
    }
    
    public var trailing: LocalizedHorizontalAnchor<Root> {
        .init(root: root)
    }
    
    public var vertical: AllButTrailingAnchor<Root> {
        .init(root: root)
    }
}

// MARK: TrailingAnchor

public final class TrailingAnchor<Root: LayoutAnchor>: SingleAnchor<Root, NSLayoutXAxisAnchor> {
    override var keyPath: KeyPath<LayoutWithAnchors, NSLayoutXAxisAnchor> {
        \.trailingAnchor
    }
    
    override var offsetSign: AnchorOffsetSign {
        .negative
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
    // MARK: Extended Anchors
    
    public var top: TopTrailingAnchor<Root> {
        .init(root: root)
    }
    
    public var bottom: BottomTrailingAnchor<Root> {
        .init(root: root)
    }
    
    public var leading: LocalizedHorizontalAnchor<Root> {
        .init(root: root)
    }
    
    public var vertical: AllButLeadingAnchor<Root> {
        .init(root: root)
    }
}

// MARK: CenterXAnchor

public final class CenterXAnchor<Root: LayoutAnchor>: SingleAnchor<Root, NSLayoutXAxisAnchor> {
    override var keyPath: KeyPath<LayoutWithAnchors, NSLayoutXAxisAnchor> {
        \.centerXAnchor
    }
    
    override var offsetSign: AnchorOffsetSign {
        .positive
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
    // MARK: Extended Anchors
    
    public var centerY: CenterAnchor<Root> {
        .init(root: root)
    }
}

// MARK: CenterYAnchor

public final class CenterYAnchor<Root: LayoutAnchor>: SingleAnchor<Root, NSLayoutYAxisAnchor> {
    override var keyPath: KeyPath<LayoutWithAnchors, NSLayoutYAxisAnchor> {
        \.centerYAnchor
    }
    
    override var offsetSign: AnchorOffsetSign {
        .positive
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
    // MARK: Extended Anchors
    
    public var centerX: CenterAnchor<Root> {
        .init(root: root)
    }
}
#endif
