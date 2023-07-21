//
//  Tabled.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 21/7/23.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Combine

public final class Tabled: LayoutDraft<UITableView> {
    
    @inlinable public init<S: Sequence, Cell: UITableViewCell>(
        _ tableView: UITableView = UITableView(),
        forCell type: Cell.Type,
        using sequence: S,
        animation: UITableView.RowAnimation? = nil,
        applicator: @escaping (Cell, S.Element) -> Void) where S.Element: Hashable {
            super.init(view: tableView)
            renderCells(type, using: sequence, animation: animation, applicator: applicator)
        }
    
    @inlinable public init<S: Sequence>(
        _ tableView: UITableView = UITableView(),
        using sequence: S,
        animation: UITableView.RowAnimation? = nil,
        cellProvider: @escaping (S.Element) -> TableCellProvider) where S.Element: Hashable {
            super.init(view: tableView)
            renderCells(using: sequence, animation: animation, cellProvider: cellProvider)
    }
    
    @inlinable public init<P: Publisher, Cell: UITableViewCell>(
        _ tableView: UITableView = UITableView(),
        forCell type: Cell.Type,
        observing publisher: P,
        animation: UITableView.RowAnimation? = nil,
        applicator: @escaping (Cell, P.Output.Element) -> Void) where P.Output: Sequence, P.Output.Element: Hashable {
            super.init(view: tableView)
            renderCells(type, observing: publisher, animation: animation, applicator: applicator)
        }
    
    @inlinable public init<P: Publisher>(
        _ tableView: UITableView = UITableView(),
        observing publisher: P,
        animation: UITableView.RowAnimation? = nil,
        cellProvider: @escaping (P.Output.Element) -> TableCellProvider) where P.Output: Sequence, P.Output.Element: Hashable {
            super.init(view: tableView)
            renderCells(observing: publisher, animation: animation, cellProvider: cellProvider)
        }
    
    @inlinable public init<S: Sequence, Cell: UITableViewCell>(
        _ tableView: UITableView = UITableView(),
        forCell type: Cell.Type,
        using sequence: S,
        animation: UITableView.RowAnimation? = nil,
        applicator: @escaping (Cell, S.Element.Item) -> Void) where S.Element: SectionCompatible {
            super.init(view: tableView)
            renderSections(type, using: sequence, animation: animation, applicator: applicator)
        }
    
    @inlinable public init<S: Sequence>(
        _ tableView: UITableView = UITableView(),
        using sequence: S,
        animation: UITableView.RowAnimation? = nil,
        cellProvider: @escaping (S.Element.Item) -> TableCellProvider) where S.Element: SectionCompatible {
                super.init(view: tableView)
                renderSections(using: sequence, animation: animation, cellProvider: cellProvider)
        }
    
    @inlinable public init<P: Publisher, Cell: UITableViewCell>(
        _ tableView: UITableView = UITableView(),
        forCell type: Cell.Type,
        observing publisher: P,
        animation: UITableView.RowAnimation? = nil,
        applicator: @escaping (Cell, P.Output.Element.Item) -> Void) where P.Output: Sequence, P.Output.Element: SectionCompatible {
            super.init(view: tableView)
            renderSections(type, observing: publisher, animation: animation, applicator: applicator)
        }
    
    @inlinable public init<P: Publisher>(
        _ tableView: UITableView = UITableView(),
        observing publisher: P,
        animation: UITableView.RowAnimation? = nil,
        cellProvider: @escaping (P.Output.Element.Item) -> TableCellProvider) where P.Output: Sequence, P.Output.Element: SectionCompatible {
            super.init(view: tableView)
            renderSections(observing: publisher, animation: animation, cellProvider: cellProvider)
        }
}
#endif
