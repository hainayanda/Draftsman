//
//  LayoutScheme.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 06/04/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

open class LayoutScheme<View: UIView>: ViewDraftBuilder, ViewScheme {
    public var underlyingView: View
    public var view: UIView { underlyingView }
    open override var insertableDrafts: [ViewScheme] { [self] }
    var stackDrafts: [ViewScheme] = []
    
    public init(view: View, drafts: [ViewScheme] = []) {
        self.underlyingView = view
        super.init(drafts: drafts)
    }
    
    open override func build(for view: UIView) -> [NSLayoutConstraint] {
        guard view === self.view else {
            fatalError("LayoutScheme can only be applied with its own view")
        }
        let currentConstraints = constraintBuilders.build(using: getContext(for: view))
        prepareBuild(for: view)
        let subviewConstraints = buildRegularSubview(for: getContext(for: view))
        let stackConstraints = buildStackSubview(for: getContext(for: view))
        return currentConstraints
            .added(withContentsOf: subviewConstraints)
            .added(withContentsOf: stackConstraints)
            .validUniques
    }
    
    @discardableResult
    open override func apply(to view: UIView) -> [NSLayoutConstraint] {
        guard view === self.view else {
            fatalError("LayoutScheme can only be applied with its own view")
        }
        let constraints = build(for: view)
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    public func insert(@LayoutDraft _ layouter: () -> ViewDraft) -> Self {
        let viewDraft = layouter()
        drafts.append(contentsOf: viewDraft.insertableDrafts)
        return self
    }
    
    func getContext(for view: UIView) -> DraftContext {
        let context = context ?? DraftContext(view: view)
        context.currentView = view
        return context
    }
    
    func removeAssociatedSubview(in view: UIView) {
        guard let root = context?.root else { return }
        view.subviews.forEach { subview in
            guard subview.isPartOf(drafted: root),
                  !drafts.contains(where: { $0.view == subview }),
                  !stackDrafts.contains(where: { $0.view == subview }) else { return }
            subview.removeFromSuperview()
            if let currentViewController = view.responderViewController,
                let subViewController = subview.responderViewController,
                subViewController != currentViewController {
                subViewController.removeFromParent()
            }
        }
    }
    
    func prepareBuild(for view: UIView) {
        removeAssociatedSubview(in: view)
        if shouldNotTranslatesAutoresizingMaskIntoConstraints(for: view) {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func buildRegularSubview(for context: DraftContext) -> [NSLayoutConstraint] {
        let view = context.currentView
        return buildSubview(drafts: drafts, for: context) {
            view.addSubview($0)
        }
    }
    
    func buildStackSubview(for context: DraftContext) -> [NSLayoutConstraint] {
        guard let stack = context.currentView as? UIStackView else { return [] }
        return buildSubview(drafts: stackDrafts, for: context) {
            stack.addArrangedSubview($0)
        }
    }
    
    func buildSubview(drafts: [ViewScheme], for context: DraftContext, doAdd: (UIView) -> Void) -> [NSLayoutConstraint] {
        let viewController = context.currentViewController
        return drafts.reduce([]) { partialResults, draft in
            if let root = context.root {
                draft.view.makeAssociated(with: root)
            }
            doAdd(draft.view)
            if let currentViewController = viewController,
               let subViewController = draft.view.responderViewController,
                subViewController != currentViewController {
                currentViewController.addChild(subViewController)
            }
            draft.context = context
            return partialResults.added(withContentsOf: draft.build())
        }
    }
    
    func shouldNotTranslatesAutoresizingMaskIntoConstraints(for view: UIView) -> Bool {
        if view is UITableViewCell || view is UICollectionViewCell {
            return false
        }
        guard let responder = view.next else {
            return false
        }
        if responder is UIViewController {
            return false
        } else if let cell = responder as? UITableViewCell, cell.contentView == view {
            return false
        } else if let cell = responder as? UICollectionViewCell, cell.contentView == view {
            return false
        } else {
            return true
        }
    }
}

extension LayoutScheme: StackScheme where View: UIStackView {
    
    convenience init(view: View, drafts: [ViewScheme] = [], stackDrafts: [ViewScheme]) {
        self.init(view: view, drafts: drafts)
        self.stackDrafts = stackDrafts
    }
    
    public func insertStacked(@LayoutDraft _ layouter: () -> ViewDraft) -> Self {
        let viewDraft = layouter()
        stackDrafts.append(contentsOf: viewDraft.insertableDrafts)
        return self
    }
}

#endif
