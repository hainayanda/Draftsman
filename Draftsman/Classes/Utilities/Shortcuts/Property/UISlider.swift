//
//  UISlider.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 23/7/23.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Combine

extension LayoutDraft where View: UISlider {
    
    @inlinable public func value(_ value: Float) -> LayoutDraft<View> {
        underlyingView.value = value
        return self
    }
    @inlinable public func value<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Float, P.Failure == Never {
        self.subcriber.value(publisher)
    }
    @inlinable public func minimumValue(_ minimumValue: Float) -> LayoutDraft<View> {
        underlyingView.minimumValue = minimumValue
        return self
    }
    @inlinable public func minimumValue<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Float, P.Failure == Never {
        self.subcriber.minimumValue(publisher)
    }
    @inlinable public func maximumValue(_ maximumValue: Float) -> LayoutDraft<View> {
        underlyingView.maximumValue = maximumValue
        return self
    }
    @inlinable public func maximumValue<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Float, P.Failure == Never {
        self.subcriber.maximumValue(publisher)
    }
    @inlinable public func minimumValueImage(_ minimumValueImage: UIImage?) -> LayoutDraft<View> {
        underlyingView.minimumValueImage = minimumValueImage
        return self
    }
    @inlinable public func minimumValueImage<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIImage?, P.Failure == Never {
        self.subcriber.minimumValueImage(publisher)
    }
    @inlinable public func maximumValueImage(_ maximumValueImage: UIImage?) -> LayoutDraft<View> {
        underlyingView.maximumValueImage = maximumValueImage
        return self
    }
    @inlinable public func maximumValueImage<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIImage?, P.Failure == Never {
        self.subcriber.maximumValueImage(publisher)
    }
    @inlinable public func isContinuous(_ isContinuous: Bool) -> LayoutDraft<View> {
        underlyingView.isContinuous = isContinuous
        return self
    }
    @inlinable public func isContinuous<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isContinuous(publisher)
    }
    @inlinable public func minimumTrackTintColor(_ minimumTrackTintColor: UIColor?) -> LayoutDraft<View> {
        underlyingView.minimumTrackTintColor = minimumTrackTintColor
        return self
    }
    @inlinable public func minimumTrackTintColor<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIColor?, P.Failure == Never {
        self.subcriber.minimumTrackTintColor(publisher)
    }
    @inlinable public func maximumTrackTintColor(_ maximumTrackTintColor: UIColor?) -> LayoutDraft<View> {
        underlyingView.maximumTrackTintColor = maximumTrackTintColor
        return self
    }
    @inlinable public func maximumTrackTintColor<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIColor?, P.Failure == Never {
        self.subcriber.maximumTrackTintColor(publisher)
    }
    @inlinable public func thumbTintColor(_ thumbTintColor: UIColor?) -> LayoutDraft<View> {
        underlyingView.thumbTintColor = thumbTintColor
        return self
    }
    @inlinable public func thumbTintColor<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIColor?, P.Failure == Never {
        self.subcriber.thumbTintColor(publisher)
    }    
}
#endif
