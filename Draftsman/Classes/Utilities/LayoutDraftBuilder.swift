//
//  LayoutDraftBuilder.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 24/12/21.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Builder

public extension LayoutDraft {
    var builder: LayoutDraftBuilder<View> {
        LayoutDraftBuilder<View>(self)
    }
}

@dynamicMemberLookup
public final class LayoutDraftBuilder<View: UIView>: Maker {
    public var underlyingObject: View {
        get { draft.underlyingView }
        set { draft.underlyingView = newValue }
    }
    let draft: LayoutDraft<View>
    public var drf: LayoutDraft<View> { draft }
    
    init(_ draft: LayoutDraft<View>) {
        self.draft = draft
    }
    
    public subscript<Property>(
        dynamicMember keyPath: KeyPath<Object, Property>) -> PropertyAssigner<Object, Property, LayoutDraftBuilder<Object>> {
            propertyAssigner(for: keyPath)
        }
}

extension LayoutDraftBuilder: PlanComponent {
    public var insertablePlans: [ViewDraft] {
        draft.insertablePlans
    }
    
}
#endif
