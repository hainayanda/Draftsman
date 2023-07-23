//
//  UICollectionView.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 23/7/23.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Combine

extension LayoutDraft where View: UICollectionView {
    
    @inlinable public func collectionViewLayout(_ collectionViewLayout: UICollectionViewLayout) -> LayoutDraft<View> {
        underlyingView.collectionViewLayout = collectionViewLayout
        return self
    }
    @inlinable public func collectionViewLayout<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UICollectionViewLayout, P.Failure == Never {
        self.subcriber.collectionViewLayout(publisher)
    }
    @inlinable public func delegate(_ delegate: UICollectionViewDelegate?) -> LayoutDraft<View> {
        underlyingView.delegate = delegate
        return self
    }
    @inlinable public func delegate<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UICollectionViewDelegate?, P.Failure == Never {
        self.subcriber.delegate(publisher)
    }
    @inlinable public func dataSource(_ dataSource: UICollectionViewDataSource?) -> LayoutDraft<View> {
        underlyingView.dataSource = dataSource
        return self
    }
    @inlinable public func dataSource<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UICollectionViewDataSource?, P.Failure == Never {
        self.subcriber.dataSource(publisher)
    }
    @inlinable public func prefetchDataSource(_ prefetchDataSource: UICollectionViewDataSourcePrefetching?) -> LayoutDraft<View> {
        underlyingView.prefetchDataSource = prefetchDataSource
        return self
    }
    @inlinable public func prefetchDataSource<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UICollectionViewDataSourcePrefetching?, P.Failure == Never {
        self.subcriber.prefetchDataSource(publisher)
    }
    @inlinable public func isPrefetchingEnabled(_ isPrefetchingEnabled: Bool) -> LayoutDraft<View> {
        underlyingView.isPrefetchingEnabled = isPrefetchingEnabled
        return self
    }
    @inlinable public func isPrefetchingEnabled<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isPrefetchingEnabled(publisher)
    }
    @inlinable public func dragDelegate(_ dragDelegate: UICollectionViewDragDelegate?) -> LayoutDraft<View> {
        underlyingView.dragDelegate = dragDelegate
        return self
    }
    @inlinable public func dragDelegate<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UICollectionViewDragDelegate?, P.Failure == Never {
        self.subcriber.dragDelegate(publisher)
    }
    @inlinable public func dropDelegate(_ dropDelegate: UICollectionViewDropDelegate?) -> LayoutDraft<View> {
        underlyingView.dropDelegate = dropDelegate
        return self
    }
    @inlinable public func dropDelegate<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UICollectionViewDropDelegate?, P.Failure == Never {
        self.subcriber.dropDelegate(publisher)
    }
    @inlinable public func dragInteractionEnabled(_ dragInteractionEnabled: Bool) -> LayoutDraft<View> {
        underlyingView.dragInteractionEnabled = dragInteractionEnabled
        return self
    }
    @inlinable public func dragInteractionEnabled<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.dragInteractionEnabled(publisher)
    }
    @inlinable public func backgroundView(_ backgroundView: UIView?) -> LayoutDraft<View> {
        underlyingView.backgroundView = backgroundView
        return self
    }
    @inlinable public func backgroundView<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == UIView?, P.Failure == Never {
        self.subcriber.backgroundView(publisher)
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
    @available(iOS 14.0, *)
    @inlinable public func isEditing(_ isEditing: Bool) -> LayoutDraft<View> {
        underlyingView.isEditing = isEditing
        return self
    }
    @available(iOS 14.0, *)
    @inlinable public func isEditing<P: Publisher>(assignedBy publisher: P) -> LayoutDraftSubscriber<View> where P.Output == Bool, P.Failure == Never {
        self.subcriber.isEditing(publisher)
    }
}
#endif
