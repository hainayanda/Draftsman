//
//  Collectioned.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 21/7/23.
//

import Foundation
import UIKit
import Combine

public class Collectioned: LayoutDraft<UICollectionView> {
    
    @inlinable public init<S: Sequence, Cell: UICollectionViewCell>(
        _ collectionViewLayout: UICollectionViewLayout,
        forCell type: Cell.Type,
        using sequence: S,
        applicator: @escaping (Cell, S.Element) -> Void) where S.Element: Hashable {
            super.init(view: UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout))
            renderCells(type, using: sequence, applicator: applicator)
        }
    
    @inlinable public init<S: Sequence, Cell: UICollectionViewCell>(
        _ collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
        forCell type: Cell.Type,
        using sequence: S,
        applicator: @escaping (Cell, S.Element) -> Void) where S.Element: Hashable {
            super.init(view: collectionView)
            renderCells(type, using: sequence, applicator: applicator)
        }
    
    @inlinable public init<S: Sequence>(
        _ collectionViewLayout: UICollectionViewLayout,
        using sequence: S,
        cellProvider: @escaping (S.Element) -> CollectionCellProvider) where S.Element: Hashable {
            super.init(view: UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout))
            renderCells(using: sequence, cellProvider: cellProvider)
        }
    
    @inlinable public init<S: Sequence>(
        _ collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
        using sequence: S,
        cellProvider: @escaping (S.Element) -> CollectionCellProvider) where S.Element: Hashable {
            super.init(view: collectionView)
            renderCells(using: sequence, cellProvider: cellProvider)
        }
    
    @inlinable public init<P: Publisher, Cell: UICollectionViewCell>(
        _ collectionViewLayout: UICollectionViewLayout,
        forCell type: Cell.Type,
        observing publisher: P,
        applicator: @escaping (Cell, P.Output.Element) -> Void) where P.Output: Sequence, P.Output.Element: Hashable {
            super.init(view: UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout))
            renderCells(type, observing: publisher, applicator: applicator)
        }
    
    @inlinable public init<P: Publisher, Cell: UICollectionViewCell>(
        _ collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
        forCell type: Cell.Type,
        observing publisher: P,
        applicator: @escaping (Cell, P.Output.Element) -> Void) where P.Output: Sequence, P.Output.Element: Hashable {
            super.init(view: collectionView)
            renderCells(type, observing: publisher, applicator: applicator)
        }
    
    @inlinable public init<P: Publisher>(
        _ collectionViewLayout: UICollectionViewLayout,
        observing publisher: P,
        cellProvider: @escaping (P.Output.Element) -> CollectionCellProvider) where P.Output: Sequence, P.Output.Element: Hashable {
            super.init(view: UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout))
            renderCells(observing: publisher, cellProvider: cellProvider)
        }
    
    @inlinable public init<P: Publisher>(
        _ collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
        observing publisher: P,
        cellProvider: @escaping (P.Output.Element) -> CollectionCellProvider) where P.Output: Sequence, P.Output.Element: Hashable {
            super.init(view: collectionView)
            renderCells(observing: publisher, cellProvider: cellProvider)
        }
    
    @inlinable public init<S: Sequence, Cell: UICollectionViewCell>(
        _ collectionViewLayout: UICollectionViewLayout,
        forCell type: Cell.Type,
        using sequence: S,
        applicator: @escaping (Cell, S.Element.Item) -> Void) where S.Element: SectionCompatible {
            super.init(view: UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout))
            renderSections(type, using: sequence, applicator: applicator)
        }
    
    @inlinable public init<S: Sequence, Cell: UICollectionViewCell>(
        _ collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
        forCell type: Cell.Type,
        using sequence: S,
        applicator: @escaping (Cell, S.Element.Item) -> Void) where S.Element: SectionCompatible {
            super.init(view: collectionView)
            renderSections(type, using: sequence, applicator: applicator)
        }
    
    @inlinable public init<S: Sequence>(
        _ collectionViewLayout: UICollectionViewLayout,
        using sequence: S,
        cellProvider: @escaping (S.Element.Item) -> CollectionCellProvider) where S.Element: SectionCompatible {
            super.init(view: UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout))
            renderSections(using: sequence, cellProvider: cellProvider)
        }
    
    @inlinable public init<S: Sequence>(
        _ collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
        using sequence: S,
        cellProvider: @escaping (S.Element.Item) -> CollectionCellProvider) where S.Element: SectionCompatible {
            super.init(view: collectionView)
            renderSections(using: sequence, cellProvider: cellProvider)
        }
    
    @inlinable public init<P: Publisher, Cell: UICollectionViewCell>(
        _ collectionViewLayout: UICollectionViewLayout,
        forCell type: Cell.Type,
        observing publisher: P,
        applicator: @escaping (Cell, P.Output.Element.Item) -> Void) where P.Output: Sequence, P.Output.Element: SectionCompatible {
            super.init(view: UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout))
            renderSections(type, observing: publisher, applicator: applicator)
        }
    
    @inlinable public init<P: Publisher, Cell: UICollectionViewCell>(
        _ collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
        forCell type: Cell.Type,
        observing publisher: P,
        applicator: @escaping (Cell, P.Output.Element.Item) -> Void) where P.Output: Sequence, P.Output.Element: SectionCompatible {
            super.init(view: collectionView)
            renderSections(type, observing: publisher, applicator: applicator)
        }
    
    @inlinable public init<P: Publisher>(
        _ collectionViewLayout: UICollectionViewLayout,
        observing publisher: P,
        cellProvider: @escaping (P.Output.Element.Item) -> CollectionCellProvider) where P.Output: Sequence, P.Output.Element: SectionCompatible {
            super.init(view: UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout))
            renderSections(observing: publisher, cellProvider: cellProvider)
        }
    
    @inlinable public init<P: Publisher>(
        _ collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
        observing publisher: P,
        cellProvider: @escaping (P.Output.Element.Item) -> CollectionCellProvider) where P.Output: Sequence, P.Output.Element: SectionCompatible {
            super.init(view: collectionView)
            renderSections(observing: publisher, cellProvider: cellProvider)
        }
}
