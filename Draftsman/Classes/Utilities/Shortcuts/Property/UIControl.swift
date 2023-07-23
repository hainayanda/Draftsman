//
//  UIControl.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 23/7/23.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Combine

extension LayoutDraft where View: UIControl {
    
    @inlinable public func isEnabled(_ isEnabled: Bool) -> LayoutDraft<View> {
        underlyingView.isEnabled = isEnabled
        return self
    }
    @inlinable public func isEnabled<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isEnabled(publisher)
    }
    @inlinable public func isSelected(_ isSelected: Bool) -> LayoutDraft<View> {
        underlyingView.isSelected = isSelected
        return self
    }
    @inlinable public func isSelected<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isSelected(publisher)
    }
    @inlinable public func isHighlighted(_ isHighlighted: Bool) -> LayoutDraft<View> {
        underlyingView.isHighlighted = isHighlighted
        return self
    }
    @inlinable public func isHighlighted<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isHighlighted(publisher)
    }
    @inlinable public func contentVerticalAlignment(_ contentVerticalAlignment: UIControl.ContentVerticalAlignment) -> LayoutDraft<View> {
        underlyingView.contentVerticalAlignment = contentVerticalAlignment
        return self
    }
    @inlinable public func contentVerticalAlignment<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIControl.ContentVerticalAlignment, P.Failure == Never {
        self.subcriber.contentVerticalAlignment(publisher)
    }
    @inlinable public func contentHorizontalAlignment(_ contentHorizontalAlignment: UIControl.ContentHorizontalAlignment) -> LayoutDraft<View> {
        underlyingView.contentHorizontalAlignment = contentHorizontalAlignment
        return self
    }
    @inlinable public func contentHorizontalAlignment<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIControl.ContentHorizontalAlignment, P.Failure == Never {
        self.subcriber.contentHorizontalAlignment(publisher)
    }
    @available(iOS 14.0, *)
    @inlinable public func showsMenuAsPrimaryAction(_ showsMenuAsPrimaryAction: Bool) -> LayoutDraft<View> {
        underlyingView.showsMenuAsPrimaryAction = showsMenuAsPrimaryAction
        return self
    }
    @available(iOS 14.0, *)
    @inlinable public func showsMenuAsPrimaryAction<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.showsMenuAsPrimaryAction(publisher)
    }}
#endif
