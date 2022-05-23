//
//  Trio.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 19/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: AllButTopAnchor

public final class AllButTopAnchor<Root: LayoutAnchor>: TriAnchor<Root, NSLayoutYAxisAnchor, NSLayoutXAxisAnchor> {
    override var uniKeyPath: KeyPath<LayoutWithAnchors, NSLayoutYAxisAnchor> {
        \.bottomAnchor
    }
    
    override var type: TriAnchorType {
        .allButTop
    }
    
    override var biKeyPaths: BiKeyPaths {
        .init(firstAnchor: \.leftAnchor, secondAnchor: \.rightAnchor)
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
    // MARK: Extended Anchors
    
    public var top: AllEdgesAnchor<Root> {
        .init(root: root)
    }
}

// MARK: AllButLeftAnchor

public final class AllButLeftAnchor<Root: LayoutAnchor>: TriAnchor<Root, NSLayoutXAxisAnchor, NSLayoutYAxisAnchor> {
    override var uniKeyPath: KeyPath<LayoutWithAnchors, NSLayoutXAxisAnchor> {
        \.rightAnchor
    }
    
    override var type: TriAnchorType {
        .allButLeft
    }
    
    override var biKeyPaths: BiKeyPaths {
        .init(firstAnchor: \.topAnchor, secondAnchor: \.bottomAnchor)
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
    // MARK: Extended Anchors
    
    public var left: AllEdgesAnchor<Root> {
        .init(root: root)
    }
}

// MARK: AllButBottomAnchor

public final class AllButBottomAnchor<Root: LayoutAnchor>: TriAnchor<Root, NSLayoutYAxisAnchor, NSLayoutXAxisAnchor> {
    override var uniKeyPath: KeyPath<LayoutWithAnchors, NSLayoutYAxisAnchor> {
        \.topAnchor
    }
    
    override var type: TriAnchorType {
        .allButBottom
    }
    
    override var biKeyPaths: BiKeyPaths {
        .init(firstAnchor: \.leftAnchor, secondAnchor: \.rightAnchor)
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
    // MARK: Extended Anchors
    
    public var bottom: AllEdgesAnchor<Root> {
        .init(root: root)
    }
}

// MARK: AllButRightAnchor

public final class AllButRightAnchor<Root: LayoutAnchor>: TriAnchor<Root, NSLayoutXAxisAnchor, NSLayoutYAxisAnchor> {
    override var uniKeyPath: KeyPath<LayoutWithAnchors, NSLayoutXAxisAnchor> {
        \.leftAnchor
    }
    
    override var type: TriAnchorType {
        .allButRight
    }
    
    override var biKeyPaths: BiKeyPaths {
        .init(firstAnchor: \.topAnchor, secondAnchor: \.bottomAnchor)
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
    // MARK: Extended Anchors
    
    public var right: AllEdgesAnchor<Root> {
        .init(root: root)
    }
}

// MARK: AllLocalizedButTopAnchor

public final class AllLocalizedButTopAnchor<Root: LayoutAnchor>: TriAnchor<Root, NSLayoutYAxisAnchor, NSLayoutXAxisAnchor> {
    override var uniKeyPath: KeyPath<LayoutWithAnchors, NSLayoutYAxisAnchor> {
        \.bottomAnchor
    }
    
    override var type: TriAnchorType {
        .allButTop
    }
    
    override var biKeyPaths: BiKeyPaths {
        .init(firstAnchor: \.leadingAnchor, secondAnchor: \.trailingAnchor)
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
    // MARK: Extended Anchors
    
    public var top: AllLocalizedEdgesAnchor<Root> {
        .init(root: root)
    }
}

// MARK: AllButLeadingAnchor

public final class AllButLeadingAnchor<Root: LayoutAnchor>: TriAnchor<Root, NSLayoutXAxisAnchor, NSLayoutYAxisAnchor> {
    override var uniKeyPath: KeyPath<LayoutWithAnchors, NSLayoutXAxisAnchor> {
        \.trailingAnchor
    }
    
    override var type: TriAnchorType {
        .allButLeft
    }
    
    override var biKeyPaths: BiKeyPaths {
        .init(firstAnchor: \.topAnchor, secondAnchor: \.bottomAnchor)
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
    // MARK: Extended Anchors
    
    public var leading: AllLocalizedEdgesAnchor<Root> {
        .init(root: root)
    }
}

// MARK: AllLocalizedButBottomAnchor

public final class AllLocalizedButBottomAnchor<Root: LayoutAnchor>: TriAnchor<Root, NSLayoutYAxisAnchor, NSLayoutXAxisAnchor> {
    override var uniKeyPath: KeyPath<LayoutWithAnchors, NSLayoutYAxisAnchor> {
        \.topAnchor
    }
    
    override var type: TriAnchorType {
        .allButBottom
    }
    
    override var biKeyPaths: BiKeyPaths {
        .init(firstAnchor: \.leadingAnchor, secondAnchor: \.trailingAnchor)
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
    // MARK: Extended Anchors
    
    public var bottom: AllLocalizedEdgesAnchor<Root> {
        .init(root: root)
    }
}

// MARK: AllButTrailingAnchor

public final class AllButTrailingAnchor<Root: LayoutAnchor>: TriAnchor<Root, NSLayoutXAxisAnchor, NSLayoutYAxisAnchor> {
    override var uniKeyPath: KeyPath<LayoutWithAnchors, NSLayoutXAxisAnchor> {
        \.trailingAnchor
    }
    
    override var type: TriAnchorType {
        .allButRight
    }
    
    override var biKeyPaths: BiKeyPaths {
        .init(firstAnchor: \.topAnchor, secondAnchor: \.bottomAnchor)
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
    // MARK: Extended Anchors
    
    public var trailing: AllLocalizedEdgesAnchor<Root> {
        .init(root: root)
    }
}

#endif
