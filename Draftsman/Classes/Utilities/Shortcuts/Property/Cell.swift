//
//  Cell.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 23/7/23.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Combine

extension LayoutDraft where View: UITableViewCell {
    
    @available(iOS 14.0, *)
    @inlinable public func automaticallyUpdatesContentConfiguration(_ automaticallyUpdatesContentConfiguration: Bool) -> LayoutDraft<View> {
        underlyingView.automaticallyUpdatesContentConfiguration = automaticallyUpdatesContentConfiguration
        return self
    }
    @available(iOS 14.0, *)
    @inlinable public func automaticallyUpdatesContentConfiguration<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.automaticallyUpdatesContentConfiguration(publisher)
    }
    @available(iOS 14.0, *)
    // swiftlint:disable:next identifier_name
    @inlinable public func automaticallyUpdatesBackgroundConfiguration(_ automaticallyUpdatesBackgroundConfiguration: Bool) -> LayoutDraft<View> {
        underlyingView.automaticallyUpdatesBackgroundConfiguration = automaticallyUpdatesBackgroundConfiguration
        return self
    }
    @available(iOS 14.0, *)
    @inlinable public func automaticallyUpdatesBackgroundConfiguration<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.automaticallyUpdatesBackgroundConfiguration(publisher)
    }
    @inlinable public func backgroundView(_ backgroundView: UIView?) -> LayoutDraft<View> {
        underlyingView.backgroundView = backgroundView
        return self
    }
    @inlinable public func backgroundView<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIView?, P.Failure == Never {
        self.subcriber.backgroundView(publisher)
    }
    @inlinable public func selectedBackgroundView(_ selectedBackgroundView: UIView?) -> LayoutDraft<View> {
        underlyingView.selectedBackgroundView = selectedBackgroundView
        return self
    }
    @inlinable public func selectedBackgroundView<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIView?, P.Failure == Never {
        self.subcriber.selectedBackgroundView(publisher)
    }
    @inlinable public func multipleSelectionBackgroundView(_ multipleSelectionBackgroundView: UIView?) -> LayoutDraft<View> {
        underlyingView.multipleSelectionBackgroundView = multipleSelectionBackgroundView
        return self
    }
    @inlinable public func multipleSelectionBackgroundView<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIView?, P.Failure == Never {
        self.subcriber.multipleSelectionBackgroundView(publisher)
    }
    @inlinable public func isSelected(_ isSelected: Bool) -> LayoutDraft<View> {
        underlyingView.isSelected = isSelected
        return self
    }
    @inlinable public func isSelected<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isSelected(publisher)
    }
    @inlinable public func isHighlighted(_ isHighlighted: Bool) -> LayoutDraft<View> {
        underlyingView.isHighlighted = isHighlighted
        return self
    }
    @inlinable public func isHighlighted<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isHighlighted(publisher)
    }
    @inlinable public func showsReorderControl(_ showsReorderControl: Bool) -> LayoutDraft<View> {
        underlyingView.showsReorderControl = showsReorderControl
        return self
    }
    @inlinable public func showsReorderControl<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.showsReorderControl(publisher)
    }
    @inlinable public func shouldIndentWhileEditing(_ shouldIndentWhileEditing: Bool) -> LayoutDraft<View> {
        underlyingView.shouldIndentWhileEditing = shouldIndentWhileEditing
        return self
    }
    @inlinable public func shouldIndentWhileEditing<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.shouldIndentWhileEditing(publisher)
    }
    @inlinable public func accessoryView(_ accessoryView: UIView?) -> LayoutDraft<View> {
        underlyingView.accessoryView = accessoryView
        return self
    }
    @inlinable public func accessoryView<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIView?, P.Failure == Never {
        self.subcriber.accessoryView(publisher)
    }
    @inlinable public func editingAccessoryView(_ editingAccessoryView: UIView?) -> LayoutDraft<View> {
        underlyingView.editingAccessoryView = editingAccessoryView
        return self
    }
    @inlinable public func editingAccessoryView<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIView?, P.Failure == Never {
        self.subcriber.editingAccessoryView(publisher)
    }
    @inlinable public func indentationLevel(_ indentationLevel: Int) -> LayoutDraft<View> {
        underlyingView.indentationLevel = indentationLevel
        return self
    }
    @inlinable public func indentationLevel<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Int, P.Failure == Never {
        self.subcriber.indentationLevel(publisher)
    }
    @inlinable public func indentationWidth(_ indentationWidth: CGFloat) -> LayoutDraft<View> {
        underlyingView.indentationWidth = indentationWidth
        return self
    }
    @inlinable public func indentationWidth<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == CGFloat, P.Failure == Never {
        self.subcriber.indentationWidth(publisher)
    }
    @inlinable public func isEditing(_ isEditing: Bool) -> LayoutDraft<View> {
        underlyingView.isEditing = isEditing
        return self
    }
    @inlinable public func isEditing<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isEditing(publisher)
    }
    @inlinable public func userInteractionEnabledWhileDragging(_ userInteractionEnabledWhileDragging: Bool) -> LayoutDraft<View> {
        underlyingView.userInteractionEnabledWhileDragging = userInteractionEnabledWhileDragging
        return self
    }
    @inlinable public func userInteractionEnabledWhileDragging<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.userInteractionEnabledWhileDragging(publisher)
    }}

// MARK: UICollectionViewCell

extension LayoutDraft where View: UICollectionViewCell {
    
    @available(iOS 14.0, *)
    @inlinable public func automaticallyUpdatesContentConfiguration(_ automaticallyUpdatesContentConfiguration: Bool) -> LayoutDraft<View> {
        underlyingView.automaticallyUpdatesContentConfiguration = automaticallyUpdatesContentConfiguration
        return self
    }
    @available(iOS 14.0, *)
    @inlinable public func automaticallyUpdatesContentConfiguration<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.automaticallyUpdatesContentConfiguration(publisher)
    }
    @inlinable public func isSelected(_ isSelected: Bool) -> LayoutDraft<View> {
        underlyingView.isSelected = isSelected
        return self
    }
    @inlinable public func isSelected<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isSelected(publisher)
    }
    @inlinable public func isHighlighted(_ isHighlighted: Bool) -> LayoutDraft<View> {
        underlyingView.isHighlighted = isHighlighted
        return self
    }
    @inlinable public func isHighlighted<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isHighlighted(publisher)
    }
    @available(iOS 14.0, *)
    // swiftlint:disable:next identifier_name
    @inlinable public func automaticallyUpdatesBackgroundConfiguration(_ automaticallyUpdatesBackgroundConfiguration: Bool) -> LayoutDraft<View> {
        underlyingView.automaticallyUpdatesBackgroundConfiguration = automaticallyUpdatesBackgroundConfiguration
        return self
    }
    @available(iOS 14.0, *)
    @inlinable public func automaticallyUpdatesBackgroundConfiguration<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.automaticallyUpdatesBackgroundConfiguration(publisher)
    }
    @inlinable public func backgroundView(_ backgroundView: UIView?) -> LayoutDraft<View> {
        underlyingView.backgroundView = backgroundView
        return self
    }
    @inlinable public func backgroundView<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIView?, P.Failure == Never {
        self.subcriber.backgroundView(publisher)
    }
    @inlinable public func selectedBackgroundView(_ selectedBackgroundView: UIView?) -> LayoutDraft<View> {
        underlyingView.selectedBackgroundView = selectedBackgroundView
        return self
    }
    @inlinable public func selectedBackgroundView<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIView?, P.Failure == Never {
        self.subcriber.selectedBackgroundView(publisher)
    }
}
#endif
