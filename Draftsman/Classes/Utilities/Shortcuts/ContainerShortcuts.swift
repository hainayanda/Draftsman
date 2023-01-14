//
//  ContainerShortcuts.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 12/1/23.
//

import Foundation
#if canImport(UIKit)
import UIKit

public final class Margined: LayoutDraft<UIView> {
    
    public init<MarginedView: UIView>(by margins: UIEdgeInsets, _ marginedDraft: () -> LayoutDraft<MarginedView>) {
        let container = UIView()
        container.backgroundColor = .clear
        super.init(view: container)
        insert {
            marginedDraft().fillParent().offsetted(using: margins)
        }
    }
    
    public init<MarginedView: UIView>(by margins: UIEdgeInsets, _ marginedRecoverable: () -> ConstraintBuilderRootRecoverable<LayoutDraft<MarginedView>>) {
        let container = UIView()
        container.backgroundColor = .clear
        super.init(view: container)
        insert {
            marginedRecoverable().fillParent().offsetted(using: margins)
        }
    }
}

extension Margined {
    
    public convenience init<MarginedView: UIView>(by margins: UIEdgeInsets, _ marginedView: () -> MarginedView) {
        self.init(by: margins) { marginedView().drf }
    }
    
    public convenience init<MarginedView: UIView>(by margin: CGFloat, _ marginedView: () -> MarginedView) {
        self.init(by: UIEdgeInsets(insets: margin), marginedView)
    }
    
    public convenience init<MarginedView: UIView>(by margin: CGFloat, _ marginedDraft: () -> LayoutDraft<MarginedView>) {
        self.init(by: UIEdgeInsets(insets: margin), marginedDraft)
    }
    
    public convenience init<MarginedView: UIView>(by margin: CGFloat, _ marginedRecoverable: () -> ConstraintBuilderRootRecoverable<LayoutDraft<MarginedView>>) {
        self.init(by: UIEdgeInsets(insets: margin), marginedRecoverable)
    }
}
#endif
