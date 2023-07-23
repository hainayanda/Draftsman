//
//  UIButton.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 23/7/23.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Combine

extension LayoutDraft where View: UIButton {
    
    @inlinable public func contentEdgeInsets(_ contentEdgeInsets: UIEdgeInsets) -> LayoutDraft<View> {
        underlyingView.contentEdgeInsets = contentEdgeInsets
        return self
    }
    @inlinable public func contentEdgeInsets<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIEdgeInsets, P.Failure == Never {
        self.subcriber.contentEdgeInsets(publisher)
    }
    @inlinable public func titleEdgeInsets(_ titleEdgeInsets: UIEdgeInsets) -> LayoutDraft<View> {
        underlyingView.titleEdgeInsets = titleEdgeInsets
        return self
    }
    @inlinable public func titleEdgeInsets<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIEdgeInsets, P.Failure == Never {
        self.subcriber.titleEdgeInsets(publisher)
    }
    @inlinable public func reversesTitleShadowWhenHighlighted(_ reversesTitleShadowWhenHighlighted: Bool) -> LayoutDraft<View> {
        underlyingView.reversesTitleShadowWhenHighlighted = reversesTitleShadowWhenHighlighted
        return self
    }
    @inlinable public func reversesTitleShadowWhenHighlighted<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.reversesTitleShadowWhenHighlighted(publisher)
    }
    @inlinable public func imageEdgeInsets(_ imageEdgeInsets: UIEdgeInsets) -> LayoutDraft<View> {
        underlyingView.imageEdgeInsets = imageEdgeInsets
        return self
    }
    @inlinable public func imageEdgeInsets<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIEdgeInsets, P.Failure == Never {
        self.subcriber.imageEdgeInsets(publisher)
    }
    @inlinable public func adjustsImageWhenHighlighted(_ adjustsImageWhenHighlighted: Bool) -> LayoutDraft<View> {
        underlyingView.adjustsImageWhenHighlighted = adjustsImageWhenHighlighted
        return self
    }
    @inlinable public func adjustsImageWhenHighlighted<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.adjustsImageWhenHighlighted(publisher)
    }
    @inlinable public func adjustsImageWhenDisabled(_ adjustsImageWhenDisabled: Bool) -> LayoutDraft<View> {
        underlyingView.adjustsImageWhenDisabled = adjustsImageWhenDisabled
        return self
    }
    @inlinable public func adjustsImageWhenDisabled<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.adjustsImageWhenDisabled(publisher)
    }
    @inlinable public func showsTouchWhenHighlighted(_ showsTouchWhenHighlighted: Bool) -> LayoutDraft<View> {
        underlyingView.showsTouchWhenHighlighted = showsTouchWhenHighlighted
        return self
    }
    @inlinable public func showsTouchWhenHighlighted<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.showsTouchWhenHighlighted(publisher)
    }
    @available(iOS 13.4, *)
    @inlinable public func isPointerInteractionEnabled(_ isPointerInteractionEnabled: Bool) -> LayoutDraft<View> {
        underlyingView.isPointerInteractionEnabled = isPointerInteractionEnabled
        return self
    }
    @available(iOS 13.4, *)
    @inlinable public func isPointerInteractionEnabled<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isPointerInteractionEnabled(publisher)
    }
}
#endif
