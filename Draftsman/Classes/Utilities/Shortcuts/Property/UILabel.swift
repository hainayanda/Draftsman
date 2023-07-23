//
//  UILabel.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 23/7/23.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Combine

extension LayoutDraft where View: UILabel {
    
    @inlinable public func text(_ text: String?) -> LayoutDraft<View> {
        underlyingView.text = text
        return self
    }
    @inlinable public func text<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == String?, P.Failure == Never {
        self.subcriber.text(publisher)
    }
    @inlinable public func font(_ font: UIFont?) -> LayoutDraft<View> {
        underlyingView.font = font
        return self
    }
    @inlinable public func font<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIFont?, P.Failure == Never {
        self.subcriber.font(publisher)
    }
    @inlinable public func textAlignment(_ textAlignment: NSTextAlignment) -> LayoutDraft<View> {
        underlyingView.textAlignment = textAlignment
        return self
    }
    @inlinable public func textAlignment<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == NSTextAlignment, P.Failure == Never {
        self.subcriber.textAlignment(publisher)
    }
    @inlinable public func textColor(_ textColor: UIColor?) -> LayoutDraft<View> {
        underlyingView.textColor = textColor
        return self
    }
    @inlinable public func textColor<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIColor?, P.Failure == Never {
        self.subcriber.textColor(publisher)
    }
    @inlinable public func shadowColor(_ shadowColor: UIColor?) -> LayoutDraft<View> {
        underlyingView.shadowColor = shadowColor
        return self
    }
    @inlinable public func shadowColor<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIColor?, P.Failure == Never {
        self.subcriber.shadowColor(publisher)
    }
    @inlinable public func shadowOffset(_ shadowOffset: CGSize) -> LayoutDraft<View> {
        underlyingView.shadowOffset = shadowOffset
        return self
    }
    @inlinable public func shadowOffset<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == CGSize, P.Failure == Never {
        self.subcriber.shadowOffset(publisher)
    }
    @inlinable public func attributedText(_ attributedText: NSAttributedString?) -> LayoutDraft<View> {
        underlyingView.attributedText = attributedText
        return self
    }
    @inlinable public func attributedText<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == NSAttributedString?, P.Failure == Never {
        self.subcriber.attributedText(publisher)
    }
    @inlinable public func highlightedTextColor(_ highlightedTextColor: UIColor?) -> LayoutDraft<View> {
        underlyingView.highlightedTextColor = highlightedTextColor
        return self
    }
    @inlinable public func highlightedTextColor<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIColor?, P.Failure == Never {
        self.subcriber.highlightedTextColor(publisher)
    }
    @inlinable public func isHighlighted(_ isHighlighted: Bool) -> LayoutDraft<View> {
        underlyingView.isHighlighted = isHighlighted
        return self
    }
    @inlinable public func isHighlighted<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isHighlighted(publisher)
    }
    @inlinable public func isUserInteractionEnabled(_ isUserInteractionEnabled: Bool) -> LayoutDraft<View> {
        underlyingView.isUserInteractionEnabled = isUserInteractionEnabled
        return self
    }
    @inlinable public func isUserInteractionEnabled<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isUserInteractionEnabled(publisher)
    }
    @inlinable public func isEnabled(_ isEnabled: Bool) -> LayoutDraft<View> {
        underlyingView.isEnabled = isEnabled
        return self
    }
    @inlinable public func isEnabled<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isEnabled(publisher)
    }
    @inlinable public func numberOfLines(_ numberOfLines: Int) -> LayoutDraft<View> {
        underlyingView.numberOfLines = numberOfLines
        return self
    }
    @inlinable public func numberOfLines<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Int, P.Failure == Never {
        self.subcriber.numberOfLines(publisher)
    }
    @inlinable public func adjustsFontSizeToFitWidth(_ adjustsFontSizeToFitWidth: Bool) -> LayoutDraft<View> {
        underlyingView.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        return self
    }
    @inlinable public func adjustsFontSizeToFitWidth<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.adjustsFontSizeToFitWidth(publisher)
    }
    @inlinable public func minimumScaleFactor(_ minimumScaleFactor: CGFloat) -> LayoutDraft<View> {
        underlyingView.minimumScaleFactor = minimumScaleFactor
        return self
    }
    @inlinable public func minimumScaleFactor<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == CGFloat, P.Failure == Never {
        self.subcriber.minimumScaleFactor(publisher)
    }
    @inlinable public func allowsDefaultTighteningForTruncation(_ allowsDefaultTighteningForTruncation: Bool) -> LayoutDraft<View> {
        underlyingView.allowsDefaultTighteningForTruncation = allowsDefaultTighteningForTruncation
        return self
    }
    @inlinable public func allowsDefaultTighteningForTruncation<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.allowsDefaultTighteningForTruncation(publisher)
    }
    @inlinable public func preferredMaxLayoutWidth(_ preferredMaxLayoutWidth: CGFloat) -> LayoutDraft<View> {
        underlyingView.preferredMaxLayoutWidth = preferredMaxLayoutWidth
        return self
    }
    @inlinable public func preferredMaxLayoutWidth<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == CGFloat, P.Failure == Never {
        self.subcriber.preferredMaxLayoutWidth(publisher)
    }
    @inlinable public func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> LayoutDraft<View> {
        underlyingView.lineBreakMode = lineBreakMode
        return self
    }
    @inlinable public func lineBreakMode<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == NSLineBreakMode, P.Failure == Never {
        self.subcriber.lineBreakMode(publisher)
    }
}
#endif
