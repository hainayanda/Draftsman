//
//  Axis.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 19/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: TopLeftAnchor

public final class TopLeftAnchor<Root: LayoutAnchor>: AxisAnchor<Root> {
    override var keyPaths: KeyPaths {
        .init(xAnchor: \.leftAnchor, yAnchor: \.topAnchor)
    }
    
    override var xOffsetSign: AnchorOffsetSign {
        .positive
    }
    
    override var yOffsetSign: AnchorOffsetSign {
        .positive
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
    // MARK: Extended Anchors
    
    public var bottom: AllButRightAnchor<Root> {
        .init(root: root)
    }
    
    public var right: AllButBottomAnchor<Root> {
        .init(root: root)
    }
}

// MARK: TopRightAnchor

public final class TopRightAnchor<Root: LayoutAnchor>: AxisAnchor<Root> {
    override var keyPaths: KeyPaths {
        .init(xAnchor: \.rightAnchor, yAnchor: \.topAnchor)
    }
    
    override var xOffsetSign: AnchorOffsetSign {
        .negative
    }
    
    override var yOffsetSign: AnchorOffsetSign {
        .positive
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
    // MARK: Extended Anchors
    
    public var left: AllButBottomAnchor<Root> {
        .init(root: root)
    }
    
    public var bottom: AllButLeftAnchor<Root> {
        .init(root: root)
    }
}

// MARK: TopLeadingAnchor

public final class TopLeadingAnchor<Root: LayoutAnchor>: AxisAnchor<Root> {
    override var keyPaths: KeyPaths {
        .init(xAnchor: \.leadingAnchor, yAnchor: \.topAnchor)
    }
    
    override var xOffsetSign: AnchorOffsetSign {
        .positive
    }
    
    override var yOffsetSign: AnchorOffsetSign {
        .positive
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
    // MARK: Extended Anchors
    
    public var bottom: AllButTrailingAnchor<Root> {
        .init(root: root)
    }
    
    public var trailing: AllLocalizedButBottomAnchor<Root> {
        .init(root: root)
    }
}

// MARK: TopTrailingAnchor

public final class TopTrailingAnchor<Root: LayoutAnchor>: AxisAnchor<Root> {
    override var keyPaths: KeyPaths {
        .init(xAnchor: \.trailingAnchor, yAnchor: \.topAnchor)
    }
    
    override var xOffsetSign: AnchorOffsetSign {
        .negative
    }
    
    override var yOffsetSign: AnchorOffsetSign {
        .positive
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
    // MARK: Extended Anchors
    
    public var leading: AllLocalizedButBottomAnchor<Root> {
        .init(root: root)
    }
    
    public var bottom: AllButLeadingAnchor<Root> {
        .init(root: root)
    }
}

// MARK: BottomLeftAnchor

public final class BottomLeftAnchor<Root: LayoutAnchor>: AxisAnchor<Root> {
    override var keyPaths: KeyPaths {
        .init(xAnchor: \.leftAnchor, yAnchor: \.bottomAnchor)
    }
    
    override var xOffsetSign: AnchorOffsetSign {
        .positive
    }
    
    override var yOffsetSign: AnchorOffsetSign {
        .negative
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
    // MARK: Extended Anchors
    
    public var top: AllButRightAnchor<Root> {
        .init(root: root)
    }
    
    public var right: AllButTopAnchor<Root> {
        .init(root: root)
    }
}

// MARK: BottomRightAnchor

public final class BottomRightAnchor<Root: LayoutAnchor>: AxisAnchor<Root> {
    override var keyPaths: KeyPaths {
        .init(xAnchor: \.rightAnchor, yAnchor: \.bottomAnchor)
    }
    
    override var xOffsetSign: AnchorOffsetSign {
        .negative
    }
    
    override var yOffsetSign: AnchorOffsetSign {
        .negative
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
    // MARK: Extended Anchors
    
    public var top: AllButLeftAnchor<Root> {
        .init(root: root)
    }
    
    public var left: AllButTopAnchor<Root> {
        .init(root: root)
    }
}

// MARK: BottomLeadingAnchor

public final class BottomLeadingAnchor<Root: LayoutAnchor>: AxisAnchor<Root> {
    override var keyPaths: KeyPaths {
        .init(xAnchor: \.leadingAnchor, yAnchor: \.bottomAnchor)
    }
    
    override var xOffsetSign: AnchorOffsetSign {
        .positive
    }
    
    override var yOffsetSign: AnchorOffsetSign {
        .negative
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
    // MARK: Extended Anchors
    
    public var top: AllButTrailingAnchor<Root> {
        .init(root: root)
    }
    
    public var trailing: AllLocalizedButTopAnchor<Root> {
        .init(root: root)
    }
}

// MARK: BottomTrailingAnchor

public final class BottomTrailingAnchor<Root: LayoutAnchor>: AxisAnchor<Root> {
    override var keyPaths: KeyPaths {
        .init(xAnchor: \.trailingAnchor, yAnchor: \.bottomAnchor)
    }
    
    override var xOffsetSign: AnchorOffsetSign {
        .negative
    }
    
    override var yOffsetSign: AnchorOffsetSign {
        .negative
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
    // MARK: Extended Anchors
    
    public var top: AllButLeadingAnchor<Root> {
        .init(root: root)
    }
    
    public var leading: AllLocalizedButTopAnchor<Root> {
        .init(root: root)
    }
}

// MARK: CenterAnchor

public final class CenterAnchor<Root: LayoutAnchor>: AxisAnchor<Root> {
    override var keyPaths: KeyPaths {
        .init(xAnchor: \.centerXAnchor, yAnchor: \.centerYAnchor)
    }
    
    override var xOffsetSign: AnchorOffsetSign {
        .positive
    }
    
    override var yOffsetSign: AnchorOffsetSign {
        .positive
    }
    
    override init(root: Root) {
        super.init(root: root)
    }
    
}
#endif
