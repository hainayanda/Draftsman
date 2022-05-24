//
//  Quad.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 19/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: AllEdgesAnchor

public final class AllEdgesAnchor<Root: LayoutAnchor>: QuadAnchor<Root> {
    
    override var biXKeyPaths: BiKeyPaths<NSLayoutXAxisAnchor> {
        .init(firstAnchor: \.leftAnchor, secondAnchor: \.rightAnchor)
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
}

// MARK: AllLocalizedEdgesAnchor

public final class AllLocalizedEdgesAnchor<Root: LayoutAnchor>: QuadAnchor<Root> {
    
    override var biXKeyPaths: BiKeyPaths<NSLayoutXAxisAnchor> {
        .init(firstAnchor: \.leadingAnchor, secondAnchor: \.trailingAnchor)
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
}
#endif
