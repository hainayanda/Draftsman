//
//  LayoutAnchor.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 20/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

public protocol LayoutAnchor {
    associatedtype Layout: LayoutWithAnchors
    var layoutExtractable: Layout { get }
}

// MARK: Standard Anchor

extension LayoutAnchor {
    public var top: TopAnchor<Self> {
        .init(root: self)
    }
    public var left: LeftAnchor<Self> {
        .init(root: self)
    }
    public var bottom: BottomAnchor<Self> {
        .init(root: self)
    }
    public var right: RightAnchor<Self> {
        .init(root: self)
    }
    public var leading: LeadingAnchor<Self> {
        .init(root: self)
    }
    public var trailing: TrailingAnchor<Self> {
        .init(root: self)
    }
    public var centerX: CenterXAnchor<Self> {
        .init(root: self)
    }
    public var centerY: CenterYAnchor<Self> {
        .init(root: self)
    }
    public var height: HeightAnchor<Self> {
        .init(root: self)
    }
    public var width: WidthAnchor<Self> {
        .init(root: self)
    }
}

// MARK: Shortcut Anchors

extension LayoutAnchor {
    @inlinable public var horizontal: HorizontalAnchor<Self> {
        left.right
    }
    @inlinable public var vertical: VerticalAnchor<Self> {
        top.bottom
    }
    @inlinable public var localizedHorizontal: LocalizedHorizontalAnchor<Self> {
        leading.trailing
    }
    @inlinable public var edges: AllEdgesAnchor<Self> {
        horizontal.vertical
    }
    @inlinable public var localizedEdges: AllLocalizedEdgesAnchor<Self> {
        localizedHorizontal.vertical
    }
    @inlinable public var center: CenterAnchor<Self> {
        centerX.centerY
    }
    @inlinable public var size: SizeAnchor<Self> {
        height.width
    }
}

extension LayoutDraft: LayoutAnchor {
    public typealias Layout = View
    @inlinable public var layoutExtractable: Layout { underlyingView }
}

public class LayoutGuide: LayoutAnchor {
    public typealias Layout = UILayoutGuide
    
    public var layoutExtractable: UILayoutGuide
    public lazy var context: PlanContext = .init(view: layoutExtractable.owningView ?? UIView())
    
    @inlinable init(guide: UILayoutGuide) {
        self.layoutExtractable = guide
    }
}

extension UILayoutGuide {
    @inlinable public var drf: LayoutGuide {
        .init(guide: self)
    }
}
#endif
