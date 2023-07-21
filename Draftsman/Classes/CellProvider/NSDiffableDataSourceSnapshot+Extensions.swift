//
//  NSDiffableDataSourceSnapshot+Extensions.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 21/7/23.
//

import Foundation

extension NSDiffableDataSourceSnapshot where SectionIdentifierType == Int {
    @inlinable func snapshot<S: Sequence>(
        fromItems sequence: S) -> NSDiffableDataSourceSnapshot where S.Element == ItemIdentifierType {
        let currentSnapshot = self
        var snapshot = NSDiffableDataSourceSnapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(Array(sequence))
        let intersection = snapshot.itemIdentifiers.intersection(with: currentSnapshot.itemIdentifiers)
        if !intersection.isEmpty {
            snapshot.reloadItems(intersection)
        }
        return snapshot
    }
}

extension NSDiffableDataSourceSnapshot {
    @inlinable func snapshot<S: Sequence>(
        fromSections sequence: S) -> NSDiffableDataSourceSnapshot where S.Element: SectionCompatible, S.Element.Identifier == SectionIdentifierType, S.Element.Item == ItemIdentifierType {
        let currentSnapshot = self
        var snapshot = NSDiffableDataSourceSnapshot()
        let sections = sequence.map { $0.identifier }
        snapshot.appendSections(sections)
        for section in sequence {
            snapshot.appendItems(section.items, toSection: section.identifier)
        }
        let intersection = snapshot.itemIdentifiers.intersection(with: currentSnapshot.itemIdentifiers)
        if !intersection.isEmpty {
            snapshot.reloadItems(intersection)
        }
        return snapshot
    }
}

// MARK: Sequence + Extensions

extension Sequence where Element: Hashable {
    @inlinable func intersection<S: Sequence>(with sequence: S) -> [Element] where S.Element == Element {
        var present: [S.Element: Void] = [:]
        var result: [S.Element] = []
        forEach { mine in
            guard present[mine] == nil else { return }
            for their in sequence where their == mine {
                present[mine] = ()
                result.append(mine)
                break
            }
        }
        return result
    }
}
