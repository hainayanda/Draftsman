//
//  InsertablePlan+Extension.swift
//  Draftsman
//
//  Created by Nayanda Haberty (ID) on 03/09/20.
//

import Foundation
#if canImport(UIKit)
import UIKit
import WebKit

extension InsertablePlan {
    func fitNewView<View: UIView>(thenAssignTo view: inout View?) -> LayoutPlaner<View> {
        let viewToPut = view ?? .init()
        defer {
            view = viewToPut
        }
        return fit(viewToPut)
    }
    
    //MARK: UIView
    
    @discardableResult
    public func fitView(assignTo view: inout UIView?) -> LayoutPlaner<UIView> {
        fitNewView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitView() -> LayoutPlaner<UIView> {
        fit(UIView())
    }
    
    //MARK: UIStackView
    
    @discardableResult
    public func fitStack(assignTo view: inout UIStackView?) -> LayoutPlaner<UIStackView> {
        fitNewView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitStack() -> LayoutPlaner<UIStackView> {
        fit(.init())
    }
    
    @discardableResult
    public func fitVStack(assignTo view: inout UIStackView?) -> LayoutPlaner<UIStackView> {
        let layout = fitNewView(thenAssignTo: &view)
        view?.axis = .vertical
        return layout
    }
    
    @discardableResult
    public func fitVStack() -> LayoutPlaner<UIStackView> {
        let stack: UIStackView = .init()
        stack.axis = .vertical
        return fit(stack)
    }
    
    @discardableResult
    public func fitHStack(assignTo view: inout UIStackView?) -> LayoutPlaner<UIStackView> {
        let layout = fitNewView(thenAssignTo: &view)
        view?.axis = .horizontal
        return layout
    }
    
    @discardableResult
    public func fitHStack() -> LayoutPlaner<UIStackView> {
        let stack: UIStackView = .init()
        stack.axis = .horizontal
        return fit(stack)
    }
    
    //MARK: UIScrollView
    
    @discardableResult
    public func fitScroll(assignTo view: inout UIScrollView?) -> LayoutPlaner<UIScrollView> {
        fitNewView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitScroll() -> LayoutPlaner<UIScrollView> {
        fit(.init())
    }
}
#endif
