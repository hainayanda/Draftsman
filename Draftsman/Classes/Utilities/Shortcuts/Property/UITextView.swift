//
//  UITextView.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 23/7/23.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Combine

extension LayoutDraft where View: UITextView {
    
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
    @inlinable public func textColor(_ textColor: UIColor?) -> LayoutDraft<View> {
        underlyingView.textColor = textColor
        return self
    }
    @inlinable public func textColor<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIColor?, P.Failure == Never {
        self.subcriber.textColor(publisher)
    }
    @inlinable public func textAlignment(_ textAlignment: NSTextAlignment) -> LayoutDraft<View> {
        underlyingView.textAlignment = textAlignment
        return self
    }
    @inlinable public func textAlignment<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == NSTextAlignment, P.Failure == Never {
        self.subcriber.textAlignment(publisher)
    }
    @inlinable public func selectedRange(_ selectedRange: NSRange) -> LayoutDraft<View> {
        underlyingView.selectedRange = selectedRange
        return self
    }
    @inlinable public func selectedRange<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == NSRange, P.Failure == Never {
        self.subcriber.selectedRange(publisher)
    }
    @inlinable public func isEditable(_ isEditable: Bool) -> LayoutDraft<View> {
        underlyingView.isEditable = isEditable
        return self
    }
    @inlinable public func isEditable<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isEditable(publisher)
    }
    @inlinable public func isSelectable(_ isSelectable: Bool) -> LayoutDraft<View> {
        underlyingView.isSelectable = isSelectable
        return self
    }
    @inlinable public func isSelectable<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isSelectable(publisher)
    }
    @inlinable public func allowsEditingTextAttributes(_ allowsEditingTextAttributes: Bool) -> LayoutDraft<View> {
        underlyingView.allowsEditingTextAttributes = allowsEditingTextAttributes
        return self
    }
    @inlinable public func allowsEditingTextAttributes<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.allowsEditingTextAttributes(publisher)
    }
    @inlinable public func attributedText(_ attributedText: NSAttributedString) -> LayoutDraft<View> {
        underlyingView.attributedText = attributedText
        return self
    }
    @inlinable public func attributedText<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == NSAttributedString, P.Failure == Never {
        self.subcriber.attributedText(publisher)
    }
    @inlinable public func inputView(_ inputView: UIView?) -> LayoutDraft<View> {
        underlyingView.inputView = inputView
        return self
    }
    @inlinable public func inputView<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIView?, P.Failure == Never {
        self.subcriber.inputView(publisher)
    }
    @inlinable public func inputAccessoryView(_ inputAccessoryView: UIView?) -> LayoutDraft<View> {
        underlyingView.inputAccessoryView = inputAccessoryView
        return self
    }
    @inlinable public func inputAccessoryView<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIView?, P.Failure == Never {
        self.subcriber.inputAccessoryView(publisher)
    }
    @inlinable public func clearsOnInsertion(_ clearsOnInsertion: Bool) -> LayoutDraft<View> {
        underlyingView.clearsOnInsertion = clearsOnInsertion
        return self
    }
    @inlinable public func clearsOnInsertion<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.clearsOnInsertion(publisher)
    }
    @inlinable public func textContainerInset(_ textContainerInset: UIEdgeInsets) -> LayoutDraft<View> {
        underlyingView.textContainerInset = textContainerInset
        return self
    }
    @inlinable public func textContainerInset<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIEdgeInsets, P.Failure == Never {
        self.subcriber.textContainerInset(publisher)
    }
    @available(iOS 13.0, *)
    @inlinable public func usesStandardTextScaling(_ usesStandardTextScaling: Bool) -> LayoutDraft<View> {
        underlyingView.usesStandardTextScaling = usesStandardTextScaling
        return self
    }
    @inlinable public func usesStandardTextScaling<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.usesStandardTextScaling(publisher)
    }}

extension LayoutDraft where View: UITextField {
    
    // MARK: Two Way Relay
    
    @inlinable public func text(_ text: String?) -> LayoutDraft<View> {
        underlyingView.text = text
        return self
    }
    @inlinable public func text<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == String?, P.Failure == Never {
        self.subcriber.text(publisher)
    }
    @inlinable public func attributedText(_ attributedText: NSAttributedString?) -> LayoutDraft<View> {
        underlyingView.attributedText = attributedText
        return self
    }
    @inlinable public func attributedText<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == NSAttributedString?, P.Failure == Never {
        self.subcriber.attributedText(publisher)
    }
    @inlinable public func textColor(_ textColor: UIColor?) -> LayoutDraft<View> {
        underlyingView.textColor = textColor
        return self
    }
    @inlinable public func textColor<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIColor?, P.Failure == Never {
        self.subcriber.textColor(publisher)
    }
    @inlinable public func font(_ font: UIFont?) -> LayoutDraft<View> {
        underlyingView.font = font
        return self
    }
    @inlinable public func font<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIFont?, P.Failure == Never {
        self.subcriber.font(publisher)
    }
    @inlinable public func placeholder(_ placeholder: String?) -> LayoutDraft<View> {
        underlyingView.placeholder = placeholder
        return self
    }
    @inlinable public func placeholder<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == String?, P.Failure == Never {
        self.subcriber.placeholder(publisher)
    }
    @inlinable public func adjustsFontSizeToFitWidth(_ adjustsFontSizeToFitWidth: Bool) -> LayoutDraft<View> {
        underlyingView.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        return self
    }
    @inlinable public func adjustsFontSizeToFitWidth<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.adjustsFontSizeToFitWidth(publisher)
    }
    @inlinable public func delegate(_ delegate: UITextFieldDelegate?) -> LayoutDraft<View> {
        underlyingView.delegate = delegate
        return self
    }
    @inlinable public func delegate<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UITextFieldDelegate?, P.Failure == Never {
        self.subcriber.delegate(publisher)
    }
    @inlinable public func disabledBackground(_ disabledBackground: UIImage?) -> LayoutDraft<View> {
        underlyingView.disabledBackground = disabledBackground
        return self
    }
    @inlinable public func disabledBackground<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIImage?, P.Failure == Never {
        self.subcriber.disabledBackground(publisher)
    }
    @inlinable public func allowsEditingTextAttributes(_ allowsEditingTextAttributes: Bool) -> LayoutDraft<View> {
        underlyingView.allowsEditingTextAttributes = allowsEditingTextAttributes
        return self
    }
    @inlinable public func allowsEditingTextAttributes<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.allowsEditingTextAttributes(publisher)
    }
    @inlinable public func leftView(_ leftView: UIView?) -> LayoutDraft<View> {
        underlyingView.leftView = leftView
        return self
    }
    @inlinable public func leftView<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIView?, P.Failure == Never {
        self.subcriber.leftView(publisher)
    }
    @inlinable public func rightView(_ rightView: UIView?) -> LayoutDraft<View> {
        underlyingView.rightView = rightView
        return self
    }
    @inlinable public func rightView<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIView?, P.Failure == Never {
        self.subcriber.rightView(publisher)
    }
    @inlinable public func rightViewMode(_ rightViewMode: UITextField.ViewMode) -> LayoutDraft<View> {
        underlyingView.rightViewMode = rightViewMode
        return self
    }
    @inlinable public func rightViewMode<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UITextField.ViewMode, P.Failure == Never {
        self.subcriber.rightViewMode(publisher)
    }
    @inlinable public func inputView(_ inputView: UIView?) -> LayoutDraft<View> {
        underlyingView.inputView = inputView
        return self
    }
    @inlinable public func inputView<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIView?, P.Failure == Never {
        self.subcriber.inputView(publisher)
    }
    @inlinable public func inputAccessoryView(_ inputAccessoryView: UIView?) -> LayoutDraft<View> {
        underlyingView.inputAccessoryView = inputAccessoryView
        return self
    }
    @inlinable public func inputAccessoryView<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIView?, P.Failure == Never {
        self.subcriber.inputAccessoryView(publisher)
    }
    @inlinable public func clearsOnInsertion(_ clearsOnInsertion: Bool) -> LayoutDraft<View> {
        underlyingView.clearsOnInsertion = clearsOnInsertion
        return self
    }
    @inlinable public func clearsOnInsertion<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.clearsOnInsertion(publisher)
    }}

extension LayoutDraft where View: UISearchBar {
    
    // MARK: Two Way Relay

    @inlinable public func delegate(_ delegate: UISearchBarDelegate?) -> LayoutDraft<View> {
        underlyingView.delegate = delegate
        return self
    }
    @inlinable public func delegate<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UISearchBarDelegate?, P.Failure == Never {
        self.subcriber.delegate(publisher)
    }
    @inlinable public func text(_ text: String?) -> LayoutDraft<View> {
        underlyingView.text = text
        return self
    }
    @inlinable public func text<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == String?, P.Failure == Never {
        self.subcriber.text(publisher)
    }
    @inlinable public func prompt(_ prompt: String?) -> LayoutDraft<View> {
        underlyingView.prompt = prompt
        return self
    }
    @inlinable public func prompt<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == String?, P.Failure == Never {
        self.subcriber.prompt(publisher)
    }
    @inlinable public func placeholder(_ placeholder: String?) -> LayoutDraft<View> {
        underlyingView.placeholder = placeholder
        return self
    }
    @inlinable public func placeholder<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == String?, P.Failure == Never {
        self.subcriber.placeholder(publisher)
    }
    @inlinable public func showsBookmarkButton(_ showsBookmarkButton: Bool) -> LayoutDraft<View> {
        underlyingView.showsBookmarkButton = showsBookmarkButton
        return self
    }
    @inlinable public func showsBookmarkButton<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.showsBookmarkButton(publisher)
    }
    @inlinable public func showsCancelButton(_ showsCancelButton: Bool) -> LayoutDraft<View> {
        underlyingView.showsCancelButton = showsCancelButton
        return self
    }
    @inlinable public func showsCancelButton<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.showsCancelButton(publisher)
    }
    @inlinable public func showsSearchResultsButton(_ showsSearchResultsButton: Bool) -> LayoutDraft<View> {
        underlyingView.showsSearchResultsButton = showsSearchResultsButton
        return self
    }
    @inlinable public func showsSearchResultsButton<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.showsSearchResultsButton(publisher)
    }
    @inlinable public func isSearchResultsButtonSelected(_ isSearchResultsButtonSelected: Bool) -> LayoutDraft<View> {
        underlyingView.isSearchResultsButtonSelected = isSearchResultsButtonSelected
        return self
    }
    @inlinable public func isSearchResultsButtonSelected<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isSearchResultsButtonSelected(publisher)
    }
    @inlinable public func barTintColor(_ barTintColor: UIColor?) -> LayoutDraft<View> {
        underlyingView.barTintColor = barTintColor
        return self
    }
    @inlinable public func barTintColor<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIColor?, P.Failure == Never {
        self.subcriber.barTintColor(publisher)
    }
    @inlinable public func isTranslucent(_ isTranslucent: Bool) -> LayoutDraft<View> {
        underlyingView.isTranslucent = isTranslucent
        return self
    }
    @inlinable public func isTranslucent<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isTranslucent(publisher)
    }
    @inlinable public func inputAccessoryView(_ inputAccessoryView: UIView?) -> LayoutDraft<View> {
        underlyingView.inputAccessoryView = inputAccessoryView
        return self
    }
    @inlinable public func inputAccessoryView<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIView?, P.Failure == Never {
        self.subcriber.inputAccessoryView(publisher)
    }
    @inlinable public func backgroundImage(_ backgroundImage: UIImage?) -> LayoutDraft<View> {
        underlyingView.backgroundImage = backgroundImage
        return self
    }
    @inlinable public func backgroundImage<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIImage?, P.Failure == Never {
        self.subcriber.backgroundImage(publisher)
    }
    @inlinable public func searchFieldBackgroundPositionAdjustment(_ searchFieldBackgroundPositionAdjustment: UIOffset) -> LayoutDraft<View> {
        underlyingView.searchFieldBackgroundPositionAdjustment = searchFieldBackgroundPositionAdjustment
        return self
    }
    @inlinable public func searchFieldBackgroundPositionAdjustment<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIOffset, P.Failure == Never {
        self.subcriber.searchFieldBackgroundPositionAdjustment(publisher)
    }
    @inlinable public func searchTextPositionAdjustment(_ searchTextPositionAdjustment: UIOffset) -> LayoutDraft<View> {
        underlyingView.searchTextPositionAdjustment = searchTextPositionAdjustment
        return self
    }
    @inlinable public func searchTextPositionAdjustment<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIOffset, P.Failure == Never {
        self.subcriber.searchTextPositionAdjustment(publisher)
    }
}
#endif
