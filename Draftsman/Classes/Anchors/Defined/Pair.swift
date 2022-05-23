//
//  Pair.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 19/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: VerticalAnchor

public final class VerticalAnchor<Root: LayoutAnchor>: PairAnchor<Root, NSLayoutYAxisAnchor> {
    override var keyPaths: KeyPaths {
        .init(first: \.topAnchor, second: \.bottomAnchor)
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
    // MARK: Extended Anchors
    
    public var left: AllButRightAnchor<Root> {
        .init(root: root)
    }
    
    public var right: AllButLeftAnchor<Root> {
        .init(root: root)
    }
    
    public var leading: AllButTrailingAnchor<Root> {
        .init(root: root)
    }
    
    public var trailing: AllButLeadingAnchor<Root> {
        .init(root: root)
    }
    
    public var horizontal: AllEdgesAnchor<Root> {
        .init(root: root)
    }
    
    public var localizedHorizontal: AllLocalizedEdgesAnchor<Root> {
        .init(root: root)
    }
}

// MARK: HorizontalAnchor

public final class HorizontalAnchor<Root: LayoutAnchor>: PairAnchor<Root, NSLayoutXAxisAnchor> {
    override var keyPaths: KeyPaths {
        .init(first: \.leftAnchor, second: \.rightAnchor)
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
    // MARK: Extended Anchors
    
    public var top: AllButBottomAnchor<Root> {
        .init(root: root)
    }
    
    public var bottom: AllButTopAnchor<Root> {
        .init(root: root)
    }
    
    public var vertical: AllEdgesAnchor<Root> {
        .init(root: root)
    }
}

// MARK: LocalizedHorizontalAnchor

public final class LocalizedHorizontalAnchor<Root: LayoutAnchor>: PairAnchor<Root, NSLayoutXAxisAnchor> {
    override var keyPaths: KeyPaths {
        .init(first: \.leadingAnchor, second: \.trailingAnchor)
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
    // MARK: Extended Anchors
    
    public var top: AllLocalizedButBottomAnchor<Root> {
        .init(root: root)
    }
    
    public var bottom: AllLocalizedButTopAnchor<Root> {
        .init(root: root)
    }
    
    public var vertical: AllLocalizedEdgesAnchor<Root> {
        .init(root: root)
    }
}
#endif
