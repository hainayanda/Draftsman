//
//  Drafted.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 06/04/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

public protocol Drafted: AnyObject {
    var draftedIdentifier: ObjectIdentifier { get }
    var appliedConstraints: [NSLayoutConstraint] { get }
    var viewDraftApplied: Bool { get }
    @LayoutDraft
    var viewDraft: ViewDraft { get }
    @discardableResult
    func applyDraft() -> [NSLayoutConstraint]
}

public typealias UIDraftedController = UIViewController & Drafted
public typealias UIDraftedView = UIView & Drafted

var appliedConstraintsKey: String = "appliedConstraintsKey"
var viewDraftAppliedKey: String = "viewDraftAppliedKey"

extension Drafted {
    public var draftedIdentifier: ObjectIdentifier {
        ObjectIdentifier(self)
    }
    
    public internal(set) var appliedConstraints: [NSLayoutConstraint] {
        get {
            objc_getAssociatedObject(self, &appliedConstraintsKey) as? [NSLayoutConstraint] ?? []
        }
        set {
            objc_setAssociatedObject(self, &appliedConstraintsKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    public internal(set) var viewDraftApplied: Bool {
        get {
            objc_getAssociatedObject(self, &viewDraftAppliedKey) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &viewDraftAppliedKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}

public protocol DraftedCell: Drafted {
    @LayoutDraft
    var contentViewDraft: ViewDraft { get }
}

public typealias UITableDraftedCell = UITableViewCell & DraftedCell
public typealias UICollectionDraftedCell = UICollectionViewCell & DraftedCell

extension DraftedCell where Self: UITableViewCell {
    @LayoutDraft
    public var viewDraft: ViewDraft {
        contentView.drf.insert {
            contentViewDraft
        }
    }
}

extension DraftedCell where Self: UICollectionViewCell {
    @LayoutDraft
    public var viewDraft: ViewDraft {
        contentView.drf.insert {
            contentViewDraft
        }
    }
}

public protocol DraftedStack: Drafted {
    @LayoutDraft
    var stackViewDraft: ViewDraft { get }
}

public typealias UIDraftedStack = UIStackView & DraftedStack

extension DraftedStack where Self: UIStackView {
    @LayoutDraft
    public var viewDraft: ViewDraft {
        drf.insertStacked {
            stackViewDraft
        }
    }
}

extension Drafted where Self: UIView {
    
    @discardableResult
    public func applyDraft() -> [NSLayoutConstraint] {
        let appliedConstraints = DraftedScheme(root: self, view: self, drafts: viewDraft.insertableDrafts)
            .apply()
        self.appliedConstraints = appliedConstraints
        self.viewDraftApplied = true
        return appliedConstraints
    }
}

extension Drafted where Self: UIViewController {
    
    @discardableResult
    public func applyDraft() -> [NSLayoutConstraint] {
        let appliedConstraints = DraftedScheme(root: self, view: self.view, drafts: viewDraft.insertableDrafts)
            .apply()
        self.appliedConstraints = appliedConstraints
        self.viewDraftApplied = true
        return appliedConstraints
    }
}
#endif
