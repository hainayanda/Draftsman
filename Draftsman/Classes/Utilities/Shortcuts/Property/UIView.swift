//
//  UIView.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 23/7/23.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Combine

extension LayoutDraft where View: UIView {
    
    @inlinable public func isUserInteractionEnabled(_ isUserInteractionEnabled: Bool) -> LayoutDraft<View> {
        underlyingView.isUserInteractionEnabled = isUserInteractionEnabled
        return self
    }
    @inlinable public func isUserInteractionEnabled<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isUserInteractionEnabled(publisher)
    }
    @inlinable public func tag(_ tag: Int) -> LayoutDraft<View> {
        underlyingView.tag = tag
        return self
    }
    @inlinable public func tag<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Int, P.Failure == Never {
        self.subcriber.tag(publisher)
    }
    @available(iOS 14.0, *)
    @inlinable public func focusGroupIdentifier(_ focusGroupIdentifier: String?) -> LayoutDraft<View> {
        underlyingView.focusGroupIdentifier = focusGroupIdentifier
        return self
    }
    @available(iOS 14.0, *)
    @inlinable public func focusGroupIdentifier<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == String?, P.Failure == Never {
        self.subcriber.focusGroupIdentifier(publisher)
    }
    @inlinable public func frame(_ frame: CGRect) -> LayoutDraft<View> {
        underlyingView.frame = frame
        return self
    }
    @inlinable public func frame<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == CGRect, P.Failure == Never {
        self.subcriber.frame(publisher)
    }
    @inlinable public func bounds(_ bounds: CGRect) -> LayoutDraft<View> {
        underlyingView.bounds = bounds
        return self
    }
    @inlinable public func bounds<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == CGRect, P.Failure == Never {
        self.subcriber.bounds(publisher)
    }
    @inlinable public func center(_ center: CGPoint) -> LayoutDraft<View> {
        underlyingView.center = center
        return self
    }
    @inlinable public func center<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == CGPoint, P.Failure == Never {
        self.subcriber.center(publisher)
    }
    @inlinable public func contentScaleFactor(_ contentScaleFactor: CGFloat) -> LayoutDraft<View> {
        underlyingView.contentScaleFactor = contentScaleFactor
        return self
    }
    @inlinable public func contentScaleFactor<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == CGFloat, P.Failure == Never {
        self.subcriber.contentScaleFactor(publisher)
    }
    @inlinable public func isMultipleTouchEnabled(_ isMultipleTouchEnabled: Bool) -> LayoutDraft<View> {
        underlyingView.isMultipleTouchEnabled = isMultipleTouchEnabled
        return self
    }
    @inlinable public func isMultipleTouchEnabled<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isMultipleTouchEnabled(publisher)
    }
    @inlinable public func isExclusiveTouch(_ isExclusiveTouch: Bool) -> LayoutDraft<View> {
        underlyingView.isExclusiveTouch = isExclusiveTouch
        return self
    }
    @inlinable public func isExclusiveTouch<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isExclusiveTouch(publisher)
    }
    @inlinable public func autoresizesSubviews(_ autoresizesSubviews: Bool) -> LayoutDraft<View> {
        underlyingView.autoresizesSubviews = autoresizesSubviews
        return self
    }
    @inlinable public func autoresizesSubviews<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.autoresizesSubviews(publisher)
    }
    @inlinable public func layoutMargins(_ layoutMargins: UIEdgeInsets) -> LayoutDraft<View> {
        underlyingView.layoutMargins = layoutMargins
        return self
    }
    @inlinable public func layoutMargins<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIEdgeInsets, P.Failure == Never {
        self.subcriber.layoutMargins(publisher)
    }
    @inlinable public func directionalLayoutMargins(_ directionalLayoutMargins: NSDirectionalEdgeInsets) -> LayoutDraft<View> {
        underlyingView.directionalLayoutMargins = directionalLayoutMargins
        return self
    }
    @inlinable public func directionalLayoutMargins<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == NSDirectionalEdgeInsets, P.Failure == Never {
        self.subcriber.directionalLayoutMargins(publisher)
    }
    @inlinable public func preservesSuperviewLayoutMargins(_ preservesSuperviewLayoutMargins: Bool) -> LayoutDraft<View> {
        underlyingView.preservesSuperviewLayoutMargins = preservesSuperviewLayoutMargins
        return self
    }
    @inlinable public func preservesSuperviewLayoutMargins<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.preservesSuperviewLayoutMargins(publisher)
    }
    @inlinable public func insetsLayoutMarginsFromSafeArea(_ insetsLayoutMarginsFromSafeArea: Bool) -> LayoutDraft<View> {
        underlyingView.insetsLayoutMarginsFromSafeArea = insetsLayoutMarginsFromSafeArea
        return self
    }
    @inlinable public func insetsLayoutMarginsFromSafeArea<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.insetsLayoutMarginsFromSafeArea(publisher)
    }
    @inlinable public func clipsToBounds(_ clipsToBounds: Bool) -> LayoutDraft<View> {
        underlyingView.clipsToBounds = clipsToBounds
        return self
    }
    @inlinable public func clipsToBounds<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.clipsToBounds(publisher)
    }
    @inlinable public func backgroundColor(_ backgroundColor: UIColor?) -> LayoutDraft<View> {
        underlyingView.backgroundColor = backgroundColor
        return self
    }
    @inlinable public func backgroundColor<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIColor?, P.Failure == Never {
        self.subcriber.backgroundColor(publisher)
    }
    @inlinable public func alpha(_ alpha: CGFloat) -> LayoutDraft<View> {
        underlyingView.alpha = alpha
        return self
    }
    @inlinable public func alpha<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == CGFloat, P.Failure == Never {
        self.subcriber.alpha(publisher)
    }
    @inlinable public func isOpaque(_ isOpaque: Bool) -> LayoutDraft<View> {
        underlyingView.isOpaque = isOpaque
        return self
    }
    @inlinable public func isOpaque<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isOpaque(publisher)
    }
    @inlinable public func clearsContextBeforeDrawing(_ clearsContextBeforeDrawing: Bool) -> LayoutDraft<View> {
        underlyingView.clearsContextBeforeDrawing = clearsContextBeforeDrawing
        return self
    }
    @inlinable public func clearsContextBeforeDrawing<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.clearsContextBeforeDrawing(publisher)
    }
    @inlinable public func isHidden(_ isHidden: Bool) -> LayoutDraft<View> {
        underlyingView.isHidden = isHidden
        return self
    }
    @inlinable public func isHidden<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isHidden(publisher)
    }
    @inlinable public func mask(_ mask: UIView?) -> LayoutDraft<View> {
        underlyingView.mask = mask
        return self
    }
    @inlinable public func mask<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIView?, P.Failure == Never {
        self.subcriber.mask(publisher)
    }
    @inlinable public func tintColor(_ tintColor: UIColor?) -> LayoutDraft<View> {
        underlyingView.tintColor = tintColor
        return self
    }
    @inlinable public func tintColor<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIColor?, P.Failure == Never {
        self.subcriber.tintColor(publisher)
    }
    // swiftlint:disable:next identifier_name
    @inlinable public func translatesAutoresizingMaskIntoConstraints(_ translatesAutoresizingMaskIntoConstraints: Bool) -> LayoutDraft<View> {
        underlyingView.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        return self
    }
    @inlinable public func translatesAutoresizingMaskIntoConstraints<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.translatesAutoresizingMaskIntoConstraints(publisher)
    }
    @inlinable public func restorationIdentifier(_ restorationIdentifier: String?) -> LayoutDraft<View> {
        underlyingView.restorationIdentifier = restorationIdentifier
        return self
    }
    @inlinable public func restorationIdentifier<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == String?, P.Failure == Never {
        self.subcriber.restorationIdentifier(publisher)
    }
    @inlinable public func contentMode(_ contentMode: UIView.ContentMode) -> LayoutDraft<View> {
        underlyingView.contentMode = contentMode
        return self
    }
    @inlinable public func contentMode<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIView.ContentMode, P.Failure == Never {
        self.subcriber.contentMode(publisher)
    }
}
#endif
