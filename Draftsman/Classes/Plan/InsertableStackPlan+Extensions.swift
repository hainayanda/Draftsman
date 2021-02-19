//
//  InsertableStackPlan+Extensions.swift
//  Draftsman
//
//  Created by Nayanda Haberty (ID) on 08/09/20.
//

import Foundation
#if canImport(UIKit)
import UIKit
import WebKit

extension InsertableViewPlan where View: UIStackView {
    func fitStackedAndCreateView<View: UIView>(thenAssignTo view: inout View?) -> LayoutPlaner<View> {
        let viewToFitStacked = view ?? .init()
        defer {
            view = viewToFitStacked
        }
        return fitStacked(viewToFitStacked)
    }
    
    //MARK: UIView
    @discardableResult
    public func fitStackedView(assignTo view: inout UIView?) -> LayoutPlaner<UIView> {
        fitStackedAndCreateView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitStackedView() -> LayoutPlaner<UIView> {
        fitStacked(UIView())
    }
    
    @available(iOS 11.0, *)
    public func fitSpace(by space: CGFloat) -> Bool {
        guard let viewBefore = view.arrangedSubviews.last else {
            return false
        }
        view.setCustomSpacing(space, after: viewBefore)
        return true
    }
    
    public func fitVSpace(by space: CGFloat) {
        let viewAsSpace = UIView()
        viewAsSpace.backgroundColor = .clear
        fitStacked(viewAsSpace)
            .height(.equalTo(space), priority: .required)
    }
    
    public func fitHSpace(by space: CGFloat) {
        let viewAsSpace = UIView()
        viewAsSpace.backgroundColor = .clear
        fitStacked(UIView())
            .width(.equalTo(space), priority: .required)
    }
    
    //MARK: UIActivityIndicatorView
    
    @discardableResult
    public func fitStackedActivityIndicator(assignTo view: inout UIActivityIndicatorView?) -> LayoutPlaner<UIActivityIndicatorView> {
        fitStackedAndCreateView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitStackedActivityIndicator() -> LayoutPlaner<UIActivityIndicatorView> {
        fitStacked(.init())
    }
    
    //MARK: UIButton
    
    @discardableResult
    public func fitStackedButton(assignTo view: inout UIButton?) -> LayoutPlaner<UIButton> {
        fitStackedAndCreateView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitStackedButton() -> LayoutPlaner<UIButton> {
        fitStacked(.init())
    }
    
    //MARK: UIDatePicker
    
    @discardableResult
    public func fitStackedDatePicker(assignTo view: inout UIDatePicker?) -> LayoutPlaner<UIDatePicker> {
        fitStackedAndCreateView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitStackedDatePicker() -> LayoutPlaner<UIDatePicker> {
        fitStacked(.init())
    }
    
    //MARK: UIPickerView
    
    @discardableResult
    public func fitStackedPicker(assignTo view: inout UIPickerView?) -> LayoutPlaner<UIPickerView> {
        fitStackedAndCreateView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitStackedPicker() -> LayoutPlaner<UIPickerView> {
        fitStacked(.init())
    }
    
    //MARK: UIImageView
    
    @discardableResult
    public func fitStackedImageView(assignTo view: inout UIImageView?) -> LayoutPlaner<UIImageView> {
        fitStackedAndCreateView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitStackedImageView() -> LayoutPlaner<UIImageView> {
        fitStacked(.init())
    }
    
    //MARK: UIPageControl
    
    @discardableResult
    public func fitStackedPageControl(assignTo view: inout UIPageControl?) -> LayoutPlaner<UIPageControl> {
        fitStackedAndCreateView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitStackedPageControl() -> LayoutPlaner<UIPageControl> {
        fitStacked(.init())
    }
    
    //MARK: UIProgressView
    
    @discardableResult
    public func fitStackedProgress(assignTo view: inout UIProgressView?) -> LayoutPlaner<UIProgressView> {
        fitStackedAndCreateView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitStackedProgress() -> LayoutPlaner<UIProgressView> {
        fitStacked(.init())
    }
    
    //MARK: UISearchBar
    
    @discardableResult
    public func fitStackedSearchBar(assignTo view: inout UISearchBar?) -> LayoutPlaner<UISearchBar> {
        fitStackedAndCreateView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitStackedSearchBar() -> LayoutPlaner<UISearchBar> {
        fitStacked(.init())
    }
    
    @available(iOS 13.0, *)
    @discardableResult
    public func fitStackedSearchField(assignTo view: inout UISearchTextField?) -> LayoutPlaner<UISearchTextField> {
        fitStackedAndCreateView(thenAssignTo: &view)
    }
    
    @available(iOS 13.0, *)
    @discardableResult
    public func fitStackedSearchField() -> LayoutPlaner<UISearchTextField> {
        fitStacked(.init())
    }
    
    //MARK: UISegmentedControl
    
    @discardableResult
    public func fitStackedSegmentedControl(assignTo view: inout UISegmentedControl?) -> LayoutPlaner<UISegmentedControl> {
        fitStackedAndCreateView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitStackedSegmentedControl() -> LayoutPlaner<UISegmentedControl> {
        fitStacked(.init())
    }
    
    //MARK: UISlider
    
    @discardableResult
    public func fitStackedSlider(assignTo view: inout UISlider?) -> LayoutPlaner<UISlider> {
        fitStackedAndCreateView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitStackedSlider() -> LayoutPlaner<UISlider> {
        fitStacked(.init())
    }
    
    //MARK: UIStackView
    
    @discardableResult
    public func fitStackedStack(assignTo view: inout UIStackView?) -> LayoutPlaner<UIStackView> {
        fitStackedAndCreateView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitStackedStack() -> LayoutPlaner<UIStackView> {
        fitStacked(.init())
    }
    
    @discardableResult
    public func fitStackedVStack(assignTo view: inout UIStackView?) -> LayoutPlaner<UIStackView> {
        let layout = fitStackedAndCreateView(thenAssignTo: &view)
        view?.axis = .vertical
        return layout
    }
    
    @discardableResult
    public func fitStackedVStack() -> LayoutPlaner<UIStackView> {
        let stack: UIStackView = .init()
        stack.axis = .vertical
        return fitStacked(stack)
    }
    
    @discardableResult
    public func fitStackedHStack(assignTo view: inout UIStackView?) -> LayoutPlaner<UIStackView> {
        let layout = fitStackedAndCreateView(thenAssignTo: &view)
        view?.axis = .horizontal
        return layout
    }
    
    @discardableResult
    public func fitStackedHStack() -> LayoutPlaner<UIStackView> {
        let stack: UIStackView = .init()
        stack.axis = .horizontal
        return fitStacked(stack)
    }
    
    //MARK: UIStepper
    
    @discardableResult
    public func fitStackedStepper(assignTo view: inout UIStepper?) -> LayoutPlaner<UIStepper> {
        fitStackedAndCreateView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitStackedStepper() -> LayoutPlaner<UIStepper> {
        fitStacked(.init())
    }
    
    //MARK: UISwitch
    
    @discardableResult
    public func fitStackedSwitch(assignTo view: inout UISwitch?) -> LayoutPlaner<UISwitch> {
        fitStackedAndCreateView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitStackedSwitch() -> LayoutPlaner<UISwitch> {
        fitStacked(.init())
    }
    
    //MARK: UITextField
    
    @discardableResult
    public func fitStackedTextField(assignTo view: inout UITextField?) -> LayoutPlaner<UITextField> {
        fitStackedAndCreateView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitStackedTextField() -> LayoutPlaner<UITextField> {
        fitStacked(.init())
    }
    
    //MARK: UITextView
    
    @discardableResult
    public func fitStackedTextView(assignTo view: inout UITextView?) -> LayoutPlaner<UITextView> {
        fitStackedAndCreateView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitStackedTextView() -> LayoutPlaner<UITextView> {
        fitStacked(.init())
    }
    
    //MARK: UIToolbar
    
    @discardableResult
    public func fitStackedToolbar(assignTo view: inout UIToolbar?) -> LayoutPlaner<UIToolbar> {
        fitStackedAndCreateView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitStackedToolbar() -> LayoutPlaner<UIToolbar> {
        fitStacked(.init())
    }
    
    //MARK: WKWebView
    
    @discardableResult
    public func fitStackedWebView(assignTo view: inout WKWebView?) -> LayoutPlaner<WKWebView> {
        fitStackedAndCreateView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitStackedWebView() -> LayoutPlaner<WKWebView> {
        fitStacked(.init())
    }
    
    //MARK: UIScrollView
    
    @discardableResult
    public func fitStackedScroll(assignTo view: inout UIScrollView?) -> LayoutPlaner<UIScrollView> {
        fitStackedAndCreateView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitStackedScroll() -> LayoutPlaner<UIScrollView> {
        fitStacked(.init())
    }
    
    //MARK: UITableView
    
    @discardableResult
    public func fitStackedTable(assignTo view: inout UITableView?) -> LayoutPlaner<UITableView> {
        fitStackedAndCreateView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitStackedTable() -> LayoutPlaner<UITableView> {
        fitStacked(.init())
    }
    
    //MARK: UICollectionView
    
    @discardableResult
    public func fitStackedCollection(assignTo view: inout UICollectionView?) -> LayoutPlaner<UICollectionView> {
        let collectionTofitStacked = view ?? .init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        defer {
            view = collectionTofitStacked
        }
        return fitStacked(collectionTofitStacked)
    }
    
    @discardableResult
    public func fitStackedCollection() -> LayoutPlaner<UICollectionView> {
        fitStacked(.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    }
    
    //MARK: UILabel
    
    @discardableResult
    public func fitStackedLabel(assignTo view: inout UILabel?) -> LayoutPlaner<UILabel> {
        fitStackedAndCreateView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitStackedLabel() -> LayoutPlaner<UILabel> {
        fitStacked(.init())
    }
    
    //MARK: UIVisualEffectView
    
    @discardableResult
    public func fitStackedVisualEffect(assignTo view: inout UIVisualEffectView?) -> LayoutPlaner<UIVisualEffectView> {
        fitStackedAndCreateView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitStackedVisualEffect() -> LayoutPlaner<UIVisualEffectView> {
        fitStacked(.init())
    }
    
    //MARK: UINavigationBar
    
    @discardableResult
    public func fitStackedNavigation(assignTo view: inout UINavigationBar?) -> LayoutPlaner<UINavigationBar> {
        fitStackedAndCreateView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitStackedNavigation() -> LayoutPlaner<UINavigationBar> {
        fitStacked(.init())
    }
    
    //MARK: UITabBar
    
    @discardableResult
    public func fitStackedTabBar(assignTo view: inout UITabBar?) -> LayoutPlaner<UITabBar> {
        fitStackedAndCreateView(thenAssignTo: &view)
    }
    
    @discardableResult
    public func fitStackedTabBar() -> LayoutPlaner<UITabBar> {
        fitStacked(.init())
    }
}
#endif
