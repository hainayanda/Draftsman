//
//  UITableView.swift
//  Builder
//
//  Created by Nayanda Haberty on 20/7/23.
//

import Foundation
import UIKit
import Combine

// MARK: TableCellProvider

public protocol TableCellProvider {
    func applicator(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell?
}

public func render<Cell: UITableViewCell>(_ cellType: Cell.Type, applicator: @escaping (Cell) -> Void) -> TableCellProvider {
    TableCellApplicator<Cell>(applicator: applicator)
}

struct TableCellApplicator<Cell: UITableViewCell>: TableCellProvider {
    
    let applicator: (Cell) -> Void
    
    @inlinable init(applicator: @escaping (Cell) -> Void) {
        self.applicator = applicator
    }
    
    @inlinable func applicator(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
        tableView.registerIfNeeded(cell: Cell.self)
        guard let cell = tableView.dequeue(cell: Cell.self, for: indexPath) else { return nil }
        applicator(cell)
        return cell
    }
}

// MARK: LayoutDraft + CellProvider

extension LayoutDraft where View: UITableView {
    
    @discardableResult
    @inlinable public func renderCells<S: Sequence, Cell: UITableViewCell>(
        _ type: Cell.Type,
        using sequence: S,
        animation: UITableView.RowAnimation? = nil,
        applicator: @escaping (Cell, S.Element) -> Void) -> Self where S.Element: Hashable {
            renderCells(using: sequence, animation: animation) { item in
                render(Cell.self) { cell in
                    applicator(cell, item)
                }
            }
        }
    
    @discardableResult
    public func renderCells<S: Sequence>(
        using sequence: S,
        animation: UITableView.RowAnimation? = nil,
        cellProvider: @escaping (S.Element) -> TableCellProvider) -> Self where S.Element: Hashable {
            let dataSource = prepareDataSource(for: Int.self, cellProvider: cellProvider)
            let newSnapshot = dataSource.snapshot().snapshot(fromItems: sequence)
            dataSource.apply(newSnapshot, animation: animation)
            return self
        }
    
    @discardableResult
    @inlinable public func renderCells<P: Publisher, Cell: UITableViewCell>(
        _ type: Cell.Type,
        observing publisher: P,
        animation: UITableView.RowAnimation? = nil,
        applicator: @escaping (Cell, P.Output.Element) -> Void) -> Self where P.Output: Sequence, P.Output.Element: Hashable {
            renderCells(observing: publisher, animation: animation) { item in
                render(Cell.self) { cell in
                    applicator(cell, item)
                }
            }
        }
    
    @discardableResult
    public func renderCells<P: Publisher>(
        observing publisher: P,
        animation: UITableView.RowAnimation? = nil,
        cellProvider: @escaping (P.Output.Element) -> TableCellProvider) -> Self where P.Output: Sequence, P.Output.Element: Hashable {
            let dataSource = prepareDataSource(for: Int.self, cellProvider: cellProvider)
            listenChange(for: dataSource, publisher: publisher, animation: animation)
            return self
        }
    
    @discardableResult
    @inlinable public func renderSections<S: Sequence, Cell: UITableViewCell>(
        _ type: Cell.Type,
        using sequence: S,
        animation: UITableView.RowAnimation? = nil,
        applicator: @escaping (Cell, S.Element.Item) -> Void) -> Self where S.Element: SectionCompatible {
            renderSections(using: sequence, animation: animation) { item in
                render(Cell.self) { cell in
                    applicator(cell, item)
                }
            }
        }
    
    @discardableResult
    public func renderSections<S: Sequence>(
        using sequence: S,
        animation: UITableView.RowAnimation? = nil,
        cellProvider: @escaping (S.Element.Item) -> TableCellProvider) -> Self where S.Element: SectionCompatible {
            let dataSource = prepareDataSource(for: S.Element.Identifier.self, cellProvider: cellProvider)
            let newSnapshot = dataSource.snapshot().snapshot(fromSections: sequence)
            dataSource.apply(newSnapshot, animation: animation)
            return self
        }
    
    @discardableResult
    @inlinable public func renderSections<P: Publisher, Cell: UITableViewCell>(
        _ type: Cell.Type,
        observing publisher: P,
        animation: UITableView.RowAnimation? = nil,
        applicator: @escaping (Cell, P.Output.Element.Item) -> Void) -> Self where P.Output: Sequence, P.Output.Element: SectionCompatible {
            renderSections(observing: publisher, animation: animation) { item in
                render(Cell.self) { cell in
                    applicator(cell, item)
                }
            }
        }
    
    @discardableResult
    public func renderSections<P: Publisher>(
        observing publisher: P,
        animation: UITableView.RowAnimation? = nil,
        cellProvider: @escaping (P.Output.Element.Item) -> TableCellProvider) -> Self where P.Output: Sequence, P.Output.Element: SectionCompatible {
            let dataSource = prepareDataSource(for: P.Output.Element.Identifier.self, cellProvider: cellProvider)
            listenChange(for: dataSource, publisher: publisher, animation: animation)
            return self
        }
    
    // MARK: Internal methods
    
    func listenChange<Item: Hashable, P: Publisher>(
        for dataSource: UITableViewDiffableDataSource<Int, Item>,
        publisher: P,
        animation: UITableView.RowAnimation?) where P.Output: Sequence, P.Output.Element == Item {
            let cancellable = publisher
                .receive(on: RunLoop.main)
                .sink {  _ in } receiveValue: { [weak dataSource] items in
                    guard let dataSource else { return }
                    let newSnapshot = dataSource.snapshot().snapshot(fromItems: items)
                    dataSource.apply(newSnapshot, animation: animation)
                }
            underlyingView.retain(cancellable: cancellable)
        }
    
    func listenChange<Section: Hashable, Item: Hashable, P: Publisher>(
        for dataSource: UITableViewDiffableDataSource<Section, Item>,
        publisher: P,
        animation: UITableView.RowAnimation?) where P.Output: Sequence, P.Output.Element: SectionCompatible, P.Output.Element.Identifier == Section, P.Output.Element.Item == Item {
            let cancellable = publisher
                .receive(on: RunLoop.main)
                .sink {  _ in } receiveValue: { [weak dataSource] items in
                    guard let dataSource else { return }
                    let newSnapshot = dataSource.snapshot().snapshot(fromSections: items)
                    dataSource.apply(newSnapshot, animation: animation)
                }
            underlyingView.retain(cancellable: cancellable)
        }
    
    func prepareDataSource<Section: Hashable, Item: Hashable>(
        for section: Section.Type,
        cellProvider: @escaping (Item) -> TableCellProvider) -> UITableViewDiffableDataSource<Section, Item> {
            let dataSource = underlyingView
                .getRetainedDiffableDataSource(
                    sectionType: Section.self,
                    itemType: Item.self) { tableView, indexPath, item in
                        return cellProvider(item).applicator(tableView, indexPath: indexPath)
                    }
            underlyingView.dataSource = dataSource
            return dataSource
        }
}

// MARK: Private helper extensions

// MARK: UITableView + Extensions

private var dataSourceKey = "Draftsman_dataSourceKey"
private var cancellableKey = "Draftsman_cancellableKey"
private var registeredCellsKey = "Draftsman_registeredCellsKey"

private extension UITableView {
    
    func dequeue<Cell: UITableViewCell>(cell type: Cell.Type, for indexPath: IndexPath) -> Cell? {
        return dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as? Cell
    }
    
    func registerIfNeeded<Cell: UITableViewCell>(cell type: Cell.Type) {
        let identifier = String(describing: type)
        var cells = objc_getAssociatedObject(self, &registeredCellsKey) as? [String] ?? []
        guard !cells.contains(identifier) else { return }
        register(Cell.self, forCellReuseIdentifier: identifier)
        cells.append(identifier)
        objc_setAssociatedObject(self, &registeredCellsKey, cells, .OBJC_ASSOCIATION_RETAIN)
    }
    
    func getRetainedDiffableDataSource<Section: Hashable, Item: Hashable>(
        sectionType: Section.Type,
        itemType: Item.Type,
        cellProvider: @escaping (UITableView, IndexPath, Item) -> UITableViewCell?) -> UITableViewDiffableDataSource<Section, Item> {
            let newDataSource = UITableViewDiffableDataSource<Section, Item>(tableView: self, cellProvider: cellProvider)
            retain(dataSource: newDataSource)
            return newDataSource
        }
    
    func retain(dataSource: UITableViewDataSource) {
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

// MARK: UITableViewDiffableDataSource + Extensions

extension UITableViewDiffableDataSource {
    @inlinable func apply(_ snapshot: NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType>, animation: UITableView.RowAnimation?) {
        guard let animation else {
            apply(snapshot, animatingDifferences: false)
            return
        }
        defaultRowAnimation = animation
        apply(snapshot, animatingDifferences: true)
    }
}
