//
//  UIImageView.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 23/7/23.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Combine

extension LayoutDraft where View: UIImageView {
    
    @inlinable public func image(_ image: UIImage?) -> LayoutDraft<View> {
        underlyingView.image = image
        return self
    }
    @inlinable public func image<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIImage?, P.Failure == Never {
        self.subcriber.image(publisher)
    }
    @inlinable public func highlightedImage(_ highlightedImage: UIImage?) -> LayoutDraft<View> {
        underlyingView.highlightedImage = highlightedImage
        return self
    }
    @inlinable public func highlightedImage<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIImage?, P.Failure == Never {
        self.subcriber.highlightedImage(publisher)
    }
    @inlinable public func isUserInteractionEnabled(_ isUserInteractionEnabled: Bool) -> LayoutDraft<View> {
        underlyingView.isUserInteractionEnabled = isUserInteractionEnabled
        return self
    }
    @inlinable public func isUserInteractionEnabled<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isUserInteractionEnabled(publisher)
    }
    @inlinable public func isHighlighted(_ isHighlighted: Bool) -> LayoutDraft<View> {
        underlyingView.isHighlighted = isHighlighted
        return self
    }
    @inlinable public func isHighlighted<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isHighlighted(publisher)
    }    
    @inlinable public func animationImages(_ animationImages: [UIImage]?) -> LayoutDraft<View> {
        underlyingView.animationImages = animationImages
        return self
    }
    @inlinable public func animationImages<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == [UIImage]?, P.Failure == Never {
        self.subcriber.animationImages(publisher)
    }
    @inlinable public func highlightedAnimationImages(_ highlightedAnimationImages: [UIImage]?) -> LayoutDraft<View> {
        underlyingView.highlightedAnimationImages = highlightedAnimationImages
        return self
    }
    @inlinable public func highlightedAnimationImages<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == [UIImage]?, P.Failure == Never {
        self.subcriber.highlightedAnimationImages(publisher)
    }
    @inlinable public func animationDuration(_ animationDuration: TimeInterval) -> LayoutDraft<View> {
        underlyingView.animationDuration = animationDuration
        return self
    }
    @inlinable public func animationDuration<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == TimeInterval, P.Failure == Never {
        self.subcriber.animationDuration(publisher)
    }
    @inlinable public func animationRepeatCount(_ animationRepeatCount: Int) -> LayoutDraft<View> {
        underlyingView.animationRepeatCount = animationRepeatCount
        return self
    }
    @inlinable public func animationRepeatCount<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Int, P.Failure == Never {
        self.subcriber.animationRepeatCount(publisher)
    }
}
#endif
