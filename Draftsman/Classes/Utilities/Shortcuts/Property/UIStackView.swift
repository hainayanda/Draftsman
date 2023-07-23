//
//  UIStackView.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 23/7/23.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Combine

extension LayoutDraft where View: UIStackView {
    
    @inlinable public func spacing(_ spacing: CGFloat) -> LayoutDraft<View> {
        underlyingView.spacing = spacing
        return self
    }
    @inlinable public func spacing<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == CGFloat, P.Failure == Never {
        self.subcriber.spacing(publisher)
    }
    @inlinable public func isBaselineRelativeArrangement(_ isBaselineRelativeArrangement: Bool) -> LayoutDraft<View> {
        underlyingView.isBaselineRelativeArrangement = isBaselineRelativeArrangement
        return self
    }
    @inlinable public func isBaselineRelativeArrangement<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isBaselineRelativeArrangement(publisher)
    }
    @inlinable public func isLayoutMarginsRelativeArrangement(_ isLayoutMarginsRelativeArrangement: Bool) -> LayoutDraft<View> {
        underlyingView.isLayoutMarginsRelativeArrangement = isLayoutMarginsRelativeArrangement
        return self
    }
    @inlinable public func isLayoutMarginsRelativeArrangement<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isLayoutMarginsRelativeArrangement(publisher)
    }
}
#endif
