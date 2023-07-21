//
//  UICollectionView+Provider.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 21/7/23.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Combine

// MARK: CollectionCellProvider

public protocol CollectionCellProvider {
    func applicator(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell?
}

public func render<Cell: UICollectionViewCell>(_ cellType: Cell.Type, applicator: @escaping (Cell) -> Void) -> CollectionCellProvider {
    CollectionCellApplicator<Cell>(applicator: applicator)
}

struct CollectionCellApplicator<Cell: UICollectionViewCell>: CollectionCellProvider {
    
    let applicator: (Cell) -> Void
    
    @inlinable init(applicator: @escaping (Cell) -> Void) {
        self.applicator = applicator
    }
    
    @inlinable func applicator(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell? {
        collectionView.registerIfNeeded(cell: Cell.self)
        guard let cell = collectionView.dequeue(cell: Cell.self, for: indexPath) else { return nil }
        applicator(cell)
        return cell
    }
}

// MARK: LayoutDraft + CellProvider

extension LayoutDraft where View: UICollectionView {
    
    @discardableResult
    @inlinable public func renderCells<S: Sequence, Cell: UICollectionViewCell>(
        _ type: Cell.Type,
        using sequence: S,
        applicator: @escaping (Cell, S.Element) -> Void) -> Self where S.Element: Hashable {
            renderCells(using: sequence) { item in
                render(Cell.self) { cell in
                    applicator(cell, item)
                }
            }
        }
    
    @discardableResult
    public func renderCells<S: Sequence>(
        using sequence: S,
        cellProvider: @escaping (S.Element) -> CollectionCellProvider) -> Self where S.Element: Hashable {
            let dataSource = prepareDataSource(for: Int.self, cellProvider: cellProvider)
            let newSnapshot = dataSource.snapshot().snapshot(fromItems: sequence)
            dataSource.apply(newSnapshot)
            return self
        }
    
    @discardableResult
    @inlinable public func renderCells<P: Publisher, Cell: UICollectionViewCell>(
        _ type: Cell.Type,
        observing publisher: P,
        applicator: @escaping (Cell, P.Output.Element) -> Void) -> Self where P.Output: Sequence, P.Output.Element: Hashable {
            renderCells(observing: publisher) { item in
                render(Cell.self) { cell in
                    applicator(cell, item)
                }
            }
        }
    
    @discardableResult
    public func renderCells<P: Publisher>(
        observing publisher: P,
        cellProvider: @escaping (P.Output.Element) -> CollectionCellProvider) -> Self where P.Output: Sequence, P.Output.Element: Hashable {
            let dataSource = prepareDataSource(for: Int.self, cellProvider: cellProvider)
            listenChange(for: dataSource, publisher: publisher)
            return self
        }
    
    @discardableResult
    @inlinable public func renderSections<S: Sequence, Cell: UICollectionViewCell>(
        _ type: Cell.Type,
        using sequence: S,
        applicator: @escaping (Cell, S.Element.Item) -> Void) -> Self where S.Element: SectionCompatible {
            renderSections(using: sequence) { item in
                render(Cell.self) { cell in
                    applicator(cell, item)
                }
            }
        }
    
    @discardableResult
    public func renderSections<S: Sequence>(
        using sequence: S,
        cellProvider: @escaping (S.Element.Item) -> CollectionCellProvider) -> Self where S.Element: SectionCompatible {
            let dataSource = prepareDataSource(for: S.Element.Identifier.self, cellProvider: cellProvider)
            let newSnapshot = dataSource.snapshot().snapshot(fromSections: sequence)
            dataSource.apply(newSnapshot)
            return self
        }
    
    @discardableResult
    @inlinable public func renderSections<P: Publisher, Cell: UICollectionViewCell>(
        _ type: Cell.Type,
        observing publisher: P,
        applicator: @escaping (Cell, P.Output.Element.Item) -> Void) -> Self where P.Output: Sequence, P.Output.Element: SectionCompatible {
            renderSections(observing: publisher) { item in
                render(Cell.self) { cell in
                    applicator(cell, item)
                }
            }
        }
    
    @discardableResult
    public func renderSections<P: Publisher>(
        observing publisher: P,
        cellProvider: @escaping (P.Output.Element.Item) -> CollectionCellProvider) -> Self where P.Output: Sequence, P.Output.Element: SectionCompatible {
            let dataSource = prepareDataSource(for: P.Output.Element.Identifier.self, cellProvider: cellProvider)
            listenChange(for: dataSource, publisher: publisher)
            return self
        }
    
    // MARK: Internal methods
    
    private func listenChange<Item: Hashable, P: Publisher>(
        for dataSource: UICollectionViewDiffableDataSource<Int, Item>,
        publisher: P) where P.Output: Sequence, P.Output.Element == Item {
            let cancellable = publisher
                .receive(on: RunLoop.main)
                .sink {  _ in } receiveValue: { [weak dataSource] items in
                    guard let dataSource else { return }
                    let newSnapshot = dataSource.snapshot().snapshot(fromItems: items)
                    dataSource.apply(newSnapshot)
                }
            underlyingView.retain(cancellable: cancellable)
        }
    
    private func listenChange<Section: Hashable, Item: Hashable, P: Publisher>(
        for dataSource: UICollectionViewDiffableDataSource<Section, Item>,
        publisher: P) where P.Output: Sequence, P.Output.Element: SectionCompatible, P.Output.Element.Identifier == Section, P.Output.Element.Item == Item {
            let cancellable = publisher
                .receive(on: RunLoop.main)
                .sink {  _ in } receiveValue: { [weak dataSource] items in
                    guard let dataSource else { return }
                    let newSnapshot = dataSource.snapshot().snapshot(fromSections: items)
                    dataSource.apply(newSnapshot)
                }
            underlyingView.retain(cancellable: cancellable)
        }
    
    private func prepareDataSource<Section: Hashable, Item: Hashable>(
        for section: Section.Type,
        cellProvider: @escaping (Item) -> CollectionCellProvider) -> UICollectionViewDiffableDataSource<Section, Item> {
            let dataSource = underlyingView
                .getRetainedDiffableDataSource(
                    sectionType: Section.self,
                    itemType: Item.self) { collectionView, indexPath, item in
                        return cellProvider(item).applicator(collectionView, indexPath: indexPath)
                    }
            underlyingView.dataSource = dataSource
            return dataSource
        }
}

// MARK: Private helper extensions

// MARK: UICollectionView + Extensions

private var dataSourceKey = "Draftsman_dataSourceKey"
private var cancellableKey = "Draftsman_cancellableKey"
private var registeredCellsKey = "Draftsman_registeredCellsKey"

private extension UICollectionView {
    
    func dequeue<Cell: UICollectionViewCell>(cell type: Cell.Type, for indexPath: IndexPath) -> Cell? {
        return dequeueReusableCell(withReuseIdentifier: String(describing: type), for: indexPath) as? Cell
    }
    
    func registerIfNeeded<Cell: UICollectionViewCell>(cell type: Cell.Type) {
        let identifier = String(describing: type)
        var cells = objc_getAssociatedObject(self, &registeredCellsKey) as? [String] ?? []
        guard !cells.contains(identifier) else { return }
        register(Cell.self, forCellWithReuseIdentifier: identifier)
        cells.append(identifier)
        objc_setAssociatedObject(self, &registeredCellsKey, cells, .OBJC_ASSOCIATION_RETAIN)
    }
    
    func getRetainedDiffableDataSource<Section: Hashable, Item: Hashable>(
        sectionType: Section.Type,
        itemType: Item.Type,
        cellProvider: @escaping (UICollectionView, IndexPath, Item) -> UICollectionViewCell?) -> UICollectionViewDiffableDataSource<Section, Item> {
            let newDataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: self, cellProvider: cellProvider)
            retain(dataSource: newDataSource)
            return newDataSource
        }
    
    func retain(dataSource: UICollectionViewDataSource) {
        releaseRetainedDataSource()
        objc_setAssociatedObject(self, &dataSourceKey, dataSource, .OBJC_ASSOCIATION_RETAIN)
    }
    
    func releaseRetainedDataSource() {
        objc_setAssociatedObject(self, &dataSourceKey, nil, .OBJC_ASSOCIATION_RETAIN)
    }
    
    func retain(cancellable: AnyCancellable) {
        releaseCancellable()
        objc_setAssociatedObject(self, &cancellableKey, cancellable, .OBJC_ASSOCIATION_RETAIN)
    }
    
    func releaseCancellable() {
        objc_setAssociatedObject(self, &cancellableKey, nil, .OBJC_ASSOCIATION_RETAIN)
    }
}
#endif
