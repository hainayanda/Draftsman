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
    
    //MARK: UIActivityIndicatorView
    
    @discardableResult
    public func fitActivityIndicator(assignTo view: inout UIActivityIndicatorView?) -> LayoutPlaner<UIActivityIndicatorView> {
        fitNewView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitActivityIndicator() -> LayoutPlaner<UIActivityIndicatorView> {
        fit(.init())
    }
    
    //MARK: UIButton
    
    @discardableResult
    public func fitButton(assignTo view: inout UIButton?) -> LayoutPlaner<UIButton> {
        fitNewView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitButton() -> LayoutPlaner<UIButton> {
        fit(.init())
    }
    
    //MARK: UIDatePicker
    
    @discardableResult
    public func fitDatePicker(assignTo view: inout UIDatePicker?) -> LayoutPlaner<UIDatePicker> {
        fitNewView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitDatePicker() -> LayoutPlaner<UIDatePicker> {
        fit(.init())
    }
    
    //MARK: UIPickerView
    
    @discardableResult
    public func fitPicker(assignTo view: inout UIPickerView?) -> LayoutPlaner<UIPickerView> {
        fitNewView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitPicker() -> LayoutPlaner<UIPickerView> {
        fit(.init())
    }
    
    //MARK: UIImageView
    
    @discardableResult
    public func fitImageView(assignTo view: inout UIImageView?) -> LayoutPlaner<UIImageView> {
        fitNewView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitImageView() -> LayoutPlaner<UIImageView> {
        fit(.init())
    }
    
    //MARK: UIPageControl
    
    @discardableResult
    public func fitPageControl(assignTo view: inout UIPageControl?) -> LayoutPlaner<UIPageControl> {
        fitNewView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitPageControl() -> LayoutPlaner<UIPageControl> {
        fit(.init())
    }
    
    //MARK: UIProgressView
    
    @discardableResult
    public func fitProgress(assignTo view: inout UIProgressView?) -> LayoutPlaner<UIProgressView> {
        fitNewView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitProgress() -> LayoutPlaner<UIProgressView> {
        fit(.init())
    }
    
    //MARK: UISearchBar
    
    @discardableResult
    public func fitSearchBar(assignTo view: inout UISearchBar?) -> LayoutPlaner<UISearchBar> {
        fitNewView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitSearchBar() -> LayoutPlaner<UISearchBar> {
        fit(.init())
    }
    
    @available(iOS 13.0, *)
    @discardableResult
    public func fitSearchField(assignTo view: inout UISearchTextField?) -> LayoutPlaner<UISearchTextField> {
        fitNewView(thenAssignTo: &view)
    }
    
    @available(iOS 13.0, *)
    @discardableResult
    public func fitSearchField() -> LayoutPlaner<UISearchTextField> {
        fit(.init())
    }
    
    //MARK: UISegmentedControl
    
    @discardableResult
    public func fitSegmentedControl(assignTo view: inout UISegmentedControl?) -> LayoutPlaner<UISegmentedControl> {
        fitNewView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitSegmentedControl() -> LayoutPlaner<UISegmentedControl> {
        fit(.init())
    }
    
    //MARK: UISlider
    
    @discardableResult
    public func fitSlider(assignTo view: inout UISlider?) -> LayoutPlaner<UISlider> {
        fitNewView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitSlider() -> LayoutPlaner<UISlider> {
        fit(.init())
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
    
    //MARK: UIStepper
    
    @discardableResult
    public func fitStepper(assignTo view: inout UIStepper?) -> LayoutPlaner<UIStepper> {
        fitNewView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitStepper() -> LayoutPlaner<UIStepper> {
        fit(.init())
    }
    
    //MARK: UISwitch
    
    @discardableResult
    public func fitSwitch(assignTo view: inout UISwitch?) -> LayoutPlaner<UISwitch> {
        fitNewView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitSwitch() -> LayoutPlaner<UISwitch> {
        fit(.init())
    }
    
    //MARK: UITextField
    
    @discardableResult
    public func fitTextField(assignTo view: inout UITextField?) -> LayoutPlaner<UITextField> {
        fitNewView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitTextField() -> LayoutPlaner<UITextField> {
        fit(.init())
    }
    
    //MARK: UITextView
    
    @discardableResult
    public func fitTextView(assignTo view: inout UITextView?) -> LayoutPlaner<UITextView> {
        fitNewView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitTextView() -> LayoutPlaner<UITextView> {
        fit(.init())
    }
    
    //MARK: UIToolbar
    
    @discardableResult
    public func fitToolbar(assignTo view: inout UIToolbar?) -> LayoutPlaner<UIToolbar> {
        fitNewView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitToolbar() -> LayoutPlaner<UIToolbar> {
        fit(.init())
    }
    
    //MARK: WKWebView
    
    @discardableResult
    public func fitWebView(assignTo view: inout WKWebView?) -> LayoutPlaner<WKWebView> {
        fitNewView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitWebView() -> LayoutPlaner<WKWebView> {
        fit(.init())
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
    
    //MARK: UITableView
    
    @discardableResult
    public func fitTable(assignTo view: inout UITableView?) -> LayoutPlaner<UITableView> {
        fitNewView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitTable() -> LayoutPlaner<UITableView> {
        fit(.init())
    }
    
    //MARK: UICollectionView
    
    @discardableResult
    public func fitCollection(assignTo view: inout UICollectionView?) -> LayoutPlaner<UICollectionView> {
        let collectionToPut = view ?? .init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        defer {
            view = collectionToPut
        }
        return fit(collectionToPut)
    }
    
    @discardableResult
    public func fitCollection() -> LayoutPlaner<UICollectionView> {
        fit(.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    }
    
    //MARK: UILabel
    
    @discardableResult
    public func fitLabel(assignTo view: inout UILabel?) -> LayoutPlaner<UILabel> {
        fitNewView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitLabel() -> LayoutPlaner<UILabel> {
        fit(.init())
    }
    
    //MARK: UIVisualEffectView
    
    @discardableResult
    public func fitVisualEffect(assignTo view: inout UIVisualEffectView?) -> LayoutPlaner<UIVisualEffectView> {
        fitNewView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitVisualEffect() -> LayoutPlaner<UIVisualEffectView> {
        fit(.init())
    }
    
    //MARK: UINavigationBar
    
    @discardableResult
    public func fitNavigation(assignTo view: inout UINavigationBar?) -> LayoutPlaner<UINavigationBar> {
        fitNewView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitNavigation() -> LayoutPlaner<UINavigationBar> {
        fit(.init())
    }
    
    //MARK: UITabBar
    
    @discardableResult
    public func fitTabBar(assignTo view: inout UITabBar?) -> LayoutPlaner<UITabBar> {
        fitNewView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitTabBar() -> LayoutPlaner<UITabBar> {
        fit(.init())
    }
}
#endif
