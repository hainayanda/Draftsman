//
//  UIStepper.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 23/7/23.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Combine

extension LayoutDraft where View: UIStepper {
    
    @inlinable public func isContinuous(_ isContinuous: Bool) -> LayoutDraft<View> {
        underlyingView.isContinuous = isContinuous
        return self
    }
    @inlinable public func isContinuous<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isContinuous(publisher)
    }
    @inlinable public func autorepeat(_ autorepeat: Bool) -> LayoutDraft<View> {
        underlyingView.autorepeat = autorepeat
        return self
    }
    @inlinable public func autorepeat<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.autorepeat(publisher)
    }
    @inlinable public func wraps(_ wraps: Bool) -> LayoutDraft<View> {
        underlyingView.wraps = wraps
        return self
    }
    @inlinable public func wraps<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.wraps(publisher)
    }
    @inlinable public func value(_ value: Double) -> LayoutDraft<View> {
        underlyingView.value = value
        return self
    }
    @inlinable public func value<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Double, P.Failure == Never {
        self.subcriber.value(publisher)
    }
    @inlinable public func minimumValue(_ minimumValue: Double) -> LayoutDraft<View> {
        underlyingView.minimumValue = minimumValue
        return self
    }
    @inlinable public func minimumValue<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Double, P.Failure == Never {
        self.subcriber.minimumValue(publisher)
    }
    @inlinable public func maximumValue(_ maximumValue: Double) -> LayoutDraft<View> {
        underlyingView.maximumValue = maximumValue
        return self
    }
    @inlinable public func maximumValue<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Double, P.Failure == Never {
        self.subcriber.maximumValue(publisher)
    }
    @inlinable public func stepValue(_ stepValue: Double) -> LayoutDraft<View> {
        underlyingView.stepValue = stepValue
        return self
    }
    @inlinable public func stepValue<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Double, P.Failure == Never {
        self.subcriber.stepValue(publisher)
    }
}
#endif
