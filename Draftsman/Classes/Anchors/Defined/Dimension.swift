//
//  Dimension.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 20/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: HeightAnchor

public final class HeightAnchor<Root: LayoutAnchor>: DimensionAnchor<Root> {
    override var keyPath: KeyPath<LayoutWithAnchors, NSLayoutDimension> {
        \.heightAnchor
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
    // MARK: Extended Anchors
    
    public var width: SizeAnchor<Root> {
        .init(root: root)
    }
}

// MARK: WidthAnchor

public final class WidthAnchor<Root: LayoutAnchor>: DimensionAnchor<Root> {
    override var keyPath: KeyPath<LayoutWithAnchors, NSLayoutDimension> {
        \.widthAnchor
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
    // MARK: Extended Anchors
    
    public var height: SizeAnchor<Root> {
        .init(root: root)
    }
}
#endif
