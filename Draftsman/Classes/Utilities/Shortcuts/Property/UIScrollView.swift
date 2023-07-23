//
//  UIScrollView.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 23/7/23.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Combine

extension LayoutDraft where View: UIScrollView {
    
    @inlinable public func contentOffset(_ contentOffset: CGPoint) -> LayoutDraft<View> {
        underlyingView.contentOffset = contentOffset
        return self
    }
    @inlinable public func contentOffset<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == CGPoint, P.Failure == Never {
        self.subcriber.contentOffset(publisher)
    }
    @inlinable public func contentSize(_ contentSize: CGSize) -> LayoutDraft<View> {
        underlyingView.contentSize = contentSize
        return self
    }
    @inlinable public func contentSize<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == CGSize, P.Failure == Never {
        self.subcriber.contentSize(publisher)
    }
    @inlinable public func contentInset(_ contentInset: UIEdgeInsets) -> LayoutDraft<View> {
        underlyingView.contentInset = contentInset
        return self
    }
    @inlinable public func contentInset<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIEdgeInsets, P.Failure == Never {
        self.subcriber.contentInset(publisher)
    }
    @inlinable public func delegate(_ delegate: UIScrollViewDelegate?) -> LayoutDraft<View> {
        underlyingView.delegate = delegate
        return self
    }
    @inlinable public func delegate<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIScrollViewDelegate?, P.Failure == Never {
        self.subcriber.delegate(publisher)
    }
    @inlinable public func isDirectionalLockEnabled(_ isDirectionalLockEnabled: Bool) -> LayoutDraft<View> {
        underlyingView.isDirectionalLockEnabled = isDirectionalLockEnabled
        return self
    }
    @inlinable public func isDirectionalLockEnabled<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isDirectionalLockEnabled(publisher)
    }
    @inlinable public func bounces(_ bounces: Bool) -> LayoutDraft<View> {
        underlyingView.bounces = bounces
        return self
    }
    @inlinable public func bounces<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.bounces(publisher)
    }
    @inlinable public func alwaysBounceVertical(_ alwaysBounceVertical: Bool) -> LayoutDraft<View> {
        underlyingView.alwaysBounceVertical = alwaysBounceVertical
        return self
    }
    @inlinable public func alwaysBounceVertical<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.alwaysBounceVertical(publisher)
    }
    @inlinable public func alwaysBounceHorizontal(_ alwaysBounceHorizontal: Bool) -> LayoutDraft<View> {
        underlyingView.alwaysBounceHorizontal = alwaysBounceHorizontal
        return self
    }
    @inlinable public func alwaysBounceHorizontal<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.alwaysBounceHorizontal(publisher)
    }
    @inlinable public func isPagingEnabled(_ isPagingEnabled: Bool) -> LayoutDraft<View> {
        underlyingView.isPagingEnabled = isPagingEnabled
        return self
    }
    @inlinable public func isPagingEnabled<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isPagingEnabled(publisher)
    }
    @inlinable public func isScrollEnabled(_ isScrollEnabled: Bool) -> LayoutDraft<View> {
        underlyingView.isScrollEnabled = isScrollEnabled
        return self
    }
    @inlinable public func isScrollEnabled<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isScrollEnabled(publisher)
    }
    @inlinable public func showsVerticalScrollIndicator(_ showsVerticalScrollIndicator: Bool) -> LayoutDraft<View> {
        underlyingView.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        return self
    }
    @inlinable public func showsVerticalScrollIndicator<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.showsVerticalScrollIndicator(publisher)
    }
    @inlinable public func showsHorizontalScrollIndicator(_ showsHorizontalScrollIndicator: Bool) -> LayoutDraft<View> {
        underlyingView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
        return self
    }
    @inlinable public func showsHorizontalScrollIndicator<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.showsHorizontalScrollIndicator(publisher)
    }
    @inlinable public func verticalScrollIndicatorInsets(_ verticalScrollIndicatorInsets: UIEdgeInsets) -> LayoutDraft<View> {
        underlyingView.verticalScrollIndicatorInsets = verticalScrollIndicatorInsets
        return self
    }
    @inlinable public func verticalScrollIndicatorInsets<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIEdgeInsets, P.Failure == Never {
        self.subcriber.verticalScrollIndicatorInsets(publisher)
    }
    @inlinable public func horizontalScrollIndicatorInsets(_ horizontalScrollIndicatorInsets: UIEdgeInsets) -> LayoutDraft<View> {
        underlyingView.horizontalScrollIndicatorInsets = horizontalScrollIndicatorInsets
        return self
    }
    @inlinable public func horizontalScrollIndicatorInsets<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIEdgeInsets, P.Failure == Never {
        self.subcriber.horizontalScrollIndicatorInsets(publisher)
    }
    @inlinable public func scrollIndicatorInsets(_ scrollIndicatorInsets: UIEdgeInsets) -> LayoutDraft<View> {
        underlyingView.scrollIndicatorInsets = scrollIndicatorInsets
        return self
    }
    @inlinable public func scrollIndicatorInsets<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIEdgeInsets, P.Failure == Never {
        self.subcriber.scrollIndicatorInsets(publisher)
    }
    @inlinable public func delaysContentTouches(_ delaysContentTouches: Bool) -> LayoutDraft<View> {
        underlyingView.delaysContentTouches = delaysContentTouches
        return self
    }
    @inlinable public func delaysContentTouches<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.delaysContentTouches(publisher)
    }
    @inlinable public func canCancelContentTouches(_ canCancelContentTouches: Bool) -> LayoutDraft<View> {
        underlyingView.canCancelContentTouches = canCancelContentTouches
        return self
    }
    @inlinable public func canCancelContentTouches<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.canCancelContentTouches(publisher)
    }
    @inlinable public func minimumZoomScale(_ minimumZoomScale: CGFloat) -> LayoutDraft<View> {
        underlyingView.minimumZoomScale = minimumZoomScale
        return self
    }
    @inlinable public func minimumZoomScale<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == CGFloat, P.Failure == Never {
        self.subcriber.minimumZoomScale(publisher)
    }
    @inlinable public func maximumZoomScale(_ maximumZoomScale: CGFloat) -> LayoutDraft<View> {
        underlyingView.maximumZoomScale = maximumZoomScale
        return self
    }
    @inlinable public func maximumZoomScale<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == CGFloat, P.Failure == Never {
        self.subcriber.maximumZoomScale(publisher)
    }
    @inlinable public func zoomScale(_ zoomScale: CGFloat) -> LayoutDraft<View> {
        underlyingView.zoomScale = zoomScale
        return self
    }
    @inlinable public func zoomScale<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == CGFloat, P.Failure == Never {
        self.subcriber.zoomScale(publisher)
    }
    @inlinable public func bouncesZoom(_ bouncesZoom: Bool) -> LayoutDraft<View> {
        underlyingView.bouncesZoom = bouncesZoom
        return self
    }
    @inlinable public func bouncesZoom<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.bouncesZoom(publisher)
    }
    @inlinable public func scrollsToTop(_ scrollsToTop: Bool) -> LayoutDraft<View> {
        underlyingView.scrollsToTop = scrollsToTop
        return self
    }
    @inlinable public func scrollsToTop<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.scrollsToTop(publisher)
    }
    @inlinable public func refreshControl(_ refreshControl: UIRefreshControl?) -> LayoutDraft<View> {
        underlyingView.refreshControl = refreshControl
        return self
    }
    @inlinable public func refreshControl<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIRefreshControl?, P.Failure == Never {
        self.subcriber.refreshControl(publisher)
    }
}
#endif
