//
//  UITableView.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 23/7/23.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Combine

extension LayoutDraft where View: UITableView {
    
    @inlinable public func dataSource(_ dataSource: UITableViewDataSource?) -> LayoutDraft<View> {
        underlyingView.dataSource = dataSource
        return self
    }
    @inlinable public func dataSource<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UITableViewDataSource?, P.Failure == Never {
        self.subcriber.dataSource(publisher)
    }
    @inlinable public func delegate(_ delegate: UITableViewDelegate?) -> LayoutDraft<View> {
        underlyingView.delegate = delegate
        return self
    }
    @inlinable public func delegate<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UITableViewDelegate?, P.Failure == Never {
        self.subcriber.delegate(publisher)
    }
    @inlinable public func prefetchDataSource(_ prefetchDataSource: UITableViewDataSourcePrefetching?) -> LayoutDraft<View> {
        underlyingView.prefetchDataSource = prefetchDataSource
        return self
    }
    @inlinable public func prefetchDataSource<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UITableViewDataSourcePrefetching?, P.Failure == Never {
        self.subcriber.prefetchDataSource(publisher)
    }
    @inlinable public func dragDelegate(_ dragDelegate: UITableViewDragDelegate?) -> LayoutDraft<View> {
        underlyingView.dragDelegate = dragDelegate
        return self
    }
    @inlinable public func dragDelegate<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UITableViewDragDelegate?, P.Failure == Never {
        self.subcriber.dragDelegate(publisher)
    }
    @inlinable public func dropDelegate(_ dropDelegate: UITableViewDropDelegate?) -> LayoutDraft<View> {
        underlyingView.dropDelegate = dropDelegate
        return self
    }
    @inlinable public func dropDelegate<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UITableViewDropDelegate?, P.Failure == Never {
        self.subcriber.dropDelegate(publisher)
    }
    @inlinable public func rowHeight(_ rowHeight: CGFloat) -> LayoutDraft<View> {
        underlyingView.rowHeight = rowHeight
        return self
    }
    @inlinable public func rowHeight<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == CGFloat, P.Failure == Never {
        self.subcriber.rowHeight(publisher)
    }
    @inlinable public func sectionHeaderHeight(_ sectionHeaderHeight: CGFloat) -> LayoutDraft<View> {
        underlyingView.sectionHeaderHeight = sectionHeaderHeight
        return self
    }
    @inlinable public func sectionHeaderHeight<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == CGFloat, P.Failure == Never {
        self.subcriber.sectionHeaderHeight(publisher)
    }
    @inlinable public func sectionFooterHeight(_ sectionFooterHeight: CGFloat) -> LayoutDraft<View> {
        underlyingView.sectionFooterHeight = sectionFooterHeight
        return self
    }
    @inlinable public func sectionFooterHeight<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == CGFloat, P.Failure == Never {
        self.subcriber.sectionFooterHeight(publisher)
    }
    @inlinable public func estimatedRowHeight(_ estimatedRowHeight: CGFloat) -> LayoutDraft<View> {
        underlyingView.estimatedRowHeight = estimatedRowHeight
        return self
    }
    @inlinable public func estimatedRowHeight<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == CGFloat, P.Failure == Never {
        self.subcriber.estimatedRowHeight(publisher)
    }
    @inlinable public func estimatedSectionHeaderHeight(_ estimatedSectionHeaderHeight: CGFloat) -> LayoutDraft<View> {
        underlyingView.estimatedSectionHeaderHeight = estimatedSectionHeaderHeight
        return self
    }
    @inlinable public func estimatedSectionHeaderHeight<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == CGFloat, P.Failure == Never {
        self.subcriber.estimatedSectionHeaderHeight(publisher)
    }
    @inlinable public func estimatedSectionFooterHeight(_ estimatedSectionFooterHeight: CGFloat) -> LayoutDraft<View> {
        underlyingView.estimatedSectionFooterHeight = estimatedSectionFooterHeight
        return self
    }
    @inlinable public func estimatedSectionFooterHeight<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == CGFloat, P.Failure == Never {
        self.subcriber.estimatedSectionFooterHeight(publisher)
    }
    @inlinable public func separatorInset(_ separatorInset: UIEdgeInsets) -> LayoutDraft<View> {
        underlyingView.separatorInset = separatorInset
        return self
    }
    @inlinable public func separatorInset<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIEdgeInsets, P.Failure == Never {
        self.subcriber.separatorInset(publisher)
    }
    @inlinable public func backgroundView(_ backgroundView: UIView?) -> LayoutDraft<View> {
        underlyingView.backgroundView = backgroundView
        return self
    }
    @inlinable public func backgroundView<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIView?, P.Failure == Never {
        self.subcriber.backgroundView(publisher)
    }
    @inlinable public func isEditing(_ isEditing: Bool) -> LayoutDraft<View> {
        underlyingView.isEditing = isEditing
        return self
    }
    @inlinable public func isEditing<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isEditing(publisher)
    }
    @inlinable public func allowsSelection(_ allowsSelection: Bool) -> LayoutDraft<View> {
        underlyingView.allowsSelection = allowsSelection
        return self
    }
    @inlinable public func allowsSelection<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.allowsSelection(publisher)
    }
    @inlinable public func allowsMultipleSelection(_ allowsMultipleSelection: Bool) -> LayoutDraft<View> {
        underlyingView.allowsMultipleSelection = allowsMultipleSelection
        return self
    }
    @inlinable public func allowsMultipleSelection<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.allowsMultipleSelection(publisher)
    }
    @inlinable public func sectionIndexMinimumDisplayRowCount(_ sectionIndexMinimumDisplayRowCount: Int) -> LayoutDraft<View> {
        underlyingView.sectionIndexMinimumDisplayRowCount = sectionIndexMinimumDisplayRowCount
        return self
    }
    @inlinable public func sectionIndexMinimumDisplayRowCount<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Int, P.Failure == Never {
        self.subcriber.sectionIndexMinimumDisplayRowCount(publisher)
    }
    @inlinable public func sectionIndexColor(_ sectionIndexColor: UIColor?) -> LayoutDraft<View> {
        underlyingView.sectionIndexColor = sectionIndexColor
        return self
    }
    @inlinable public func sectionIndexColor<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIColor?, P.Failure == Never {
        self.subcriber.sectionIndexColor(publisher)
    }
    @inlinable public func sectionIndexBackgroundColor(_ sectionIndexBackgroundColor: UIColor?) -> LayoutDraft<View> {
        underlyingView.sectionIndexBackgroundColor = sectionIndexBackgroundColor
        return self
    }
    @inlinable public func sectionIndexBackgroundColor<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIColor?, P.Failure == Never {
        self.subcriber.sectionIndexBackgroundColor(publisher)
    }
    @inlinable public func sectionIndexTrackingBackgroundColor(_ sectionIndexTrackingBackgroundColor: UIColor?) -> LayoutDraft<View> {
        underlyingView.sectionIndexTrackingBackgroundColor = sectionIndexTrackingBackgroundColor
        return self
    }
    @inlinable public func sectionIndexTrackingBackgroundColor<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIColor?, P.Failure == Never {
        self.subcriber.sectionIndexTrackingBackgroundColor(publisher)
    }
    @inlinable public func separatorStyle(_ separatorStyle: UITableViewCell.SeparatorStyle) -> LayoutDraft<View> {
        underlyingView.separatorStyle = separatorStyle
        return self
    }
    @inlinable public func separatorStyle<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UITableViewCell.SeparatorStyle, P.Failure == Never {
        self.subcriber.separatorStyle(publisher)
    }
    @inlinable public func separatorColor(_ separatorColor: UIColor?) -> LayoutDraft<View> {
        underlyingView.separatorColor = separatorColor
        return self
    }
    @inlinable public func separatorColor<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIColor?, P.Failure == Never {
        self.subcriber.separatorColor(publisher)
    }
    @inlinable public func separatorEffect(_ separatorEffect: UIVisualEffect?) -> LayoutDraft<View> {
        underlyingView.separatorEffect = separatorEffect
        return self
    }
    @inlinable public func separatorEffect<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIVisualEffect?, P.Failure == Never {
        self.subcriber.separatorEffect(publisher)
    }
    @inlinable public func cellLayoutMarginsFollowReadableWidth(_ cellLayoutMarginsFollowReadableWidth: Bool) -> LayoutDraft<View> {
        underlyingView.cellLayoutMarginsFollowReadableWidth = cellLayoutMarginsFollowReadableWidth
        return self
    }
    @inlinable public func cellLayoutMarginsFollowReadableWidth<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.cellLayoutMarginsFollowReadableWidth(publisher)
    }
    @inlinable public func insetsContentViewsToSafeArea(_ insetsContentViewsToSafeArea: Bool) -> LayoutDraft<View> {
        underlyingView.insetsContentViewsToSafeArea = insetsContentViewsToSafeArea
        return self
    }
    @inlinable public func insetsContentViewsToSafeArea<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.insetsContentViewsToSafeArea(publisher)
    }
    @inlinable public func tableHeaderView(_ tableHeaderView: UIView?) -> LayoutDraft<View> {
        underlyingView.tableHeaderView = tableHeaderView
        return self
    }
    @inlinable public func tableHeaderView<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIView?, P.Failure == Never {
        self.subcriber.tableHeaderView(publisher)
    }
    @inlinable public func tableFooterView(_ tableFooterView: UIView?) -> LayoutDraft<View> {
        underlyingView.tableFooterView = tableFooterView
        return self
    }
    @inlinable public func tableFooterView<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIView?, P.Failure == Never {
        self.subcriber.tableFooterView(publisher)
    }
    @inlinable public func remembersLastFocusedIndexPath(_ remembersLastFocusedIndexPath: Bool) -> LayoutDraft<View> {
        underlyingView.remembersLastFocusedIndexPath = remembersLastFocusedIndexPath
        return self
    }
    @inlinable public func remembersLastFocusedIndexPath<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.remembersLastFocusedIndexPath(publisher)
    }
    @available(iOS 14.0, *)
    @inlinable public func selectionFollowsFocus(_ selectionFollowsFocus: Bool) -> LayoutDraft<View> {
        underlyingView.selectionFollowsFocus = selectionFollowsFocus
        return self
    }
    @available(iOS 14.0, *)
    @inlinable public func selectionFollowsFocus<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.selectionFollowsFocus(publisher)
    }
    @inlinable public func dragInteractionEnabled(_ dragInteractionEnabled: Bool) -> LayoutDraft<View> {
        underlyingView.dragInteractionEnabled = dragInteractionEnabled
        return self
    }
    @inlinable public func dragInteractionEnabled<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.dragInteractionEnabled(publisher)
    }
}
#endif
