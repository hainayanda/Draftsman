//
//  UISwitch.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 23/7/23.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Combine

extension LayoutDraft where View: UISwitch {
    
    @inlinable public func onTintColor(_ onTintColor: UIColor?) -> LayoutDraft<View> {
        underlyingView.onTintColor = onTintColor
        return self
    }
    @inlinable public func onTintColor<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIColor?, P.Failure == Never {
        self.subcriber.onTintColor(publisher)
    }
    @inlinable public func thumbTintColor(_ thumbTintColor: UIColor?) -> LayoutDraft<View> {
        underlyingView.thumbTintColor = thumbTintColor
        return self
    }
    @inlinable public func thumbTintColor<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIColor?, P.Failure == Never {
        self.subcriber.thumbTintColor(publisher)
    }
    @inlinable public func onImage(_ onImage: UIImage?) -> LayoutDraft<View> {
        underlyingView.onImage = onImage
        return self
    }
    @inlinable public func onImage<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIImage?, P.Failure == Never {
        self.subcriber.onImage(publisher)
    }
    @inlinable public func offImage(_ offImage: UIImage?) -> LayoutDraft<View> {
        underlyingView.offImage = offImage
        return self
    }
    @inlinable public func offImage<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIImage?, P.Failure == Never {
        self.subcriber.offImage(publisher)
    }
    @inlinable public func isOn(_ isOn: Bool) -> LayoutDraft<View> {
        underlyingView.isOn = isOn
        return self
    }
    @inlinable public func isOn<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isOn(publisher)
    }
}
#endif
