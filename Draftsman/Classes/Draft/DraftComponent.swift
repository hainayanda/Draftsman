//
//  DraftComponent.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 06/04/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

public protocol DraftComponent {
    var insertableDrafts: [ViewScheme] { get }
}

extension UIView: DraftComponent { }

extension UIViewController: DraftComponent { }

extension DraftComponent where Self: UIView {
    
    public var insertableDrafts: [ViewScheme] { drf.insertableDrafts }
    
    public var drf: LayoutScheme<Self> {
        LayoutScheme(view: self)
    }
    
    public func draftContent(@LayoutDraft _ layouter: () -> ViewDraft) -> LayoutScheme<Self> {
        drf.insert(layouter)
    }
}

extension DraftComponent where Self: UIStackView {
    
    public func draftStackContent(@LayoutDraft _ layouter: () -> ViewDraft) -> LayoutScheme<Self> {
        drf.insertStacked(layouter)
    }
}

extension DraftComponent where Self: UIViewController {
    
    public var insertableDrafts: [ViewScheme] { drf.insertableDrafts }
    
    public var drf: LayoutScheme<UIView> {
        LayoutScheme(view: self.view)
    }
    
    public func draftContent(@LayoutDraft _ layouter: () -> ViewDraft) -> LayoutScheme<UIView> {
        drf.insert(layouter)
    }
}
#endif
