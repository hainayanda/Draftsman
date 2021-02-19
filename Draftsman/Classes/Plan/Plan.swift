//
//  Plan.swift
//  Draftsman
//
//  Created by Nayanda Haberty (ID) on 27/08/20.
//

import Foundation
#if canImport(UIKit)
import UIKit

public protocol Plan: class {
    var plannedConstraints: [NSLayoutConstraint] { get set }
}

public protocol Planer: Plan {
    associatedtype View: UIView
    var view: View { get }
    var context: PlanContext { get }
    @discardableResult
    func planContent(_ planer: (LayoutPlan<View>) -> Void) -> Self
    @discardableResult
    func top(_ relation: LayoutRelation<CGFloat>, to anchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> Self
    @discardableResult
    func bottom(_ relation: LayoutRelation<CGFloat>, to anchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> Self
    @discardableResult
    func left(_ relation: LayoutRelation<CGFloat>, to anchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> Self
    @discardableResult
    func right(_ relation: LayoutRelation<CGFloat>, to anchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> Self
    @discardableResult
    func top(_ relation: LayoutRelation<CGFloat>, to anchor: AnonymousRelation, priority: UILayoutPriority) -> Self
    @discardableResult
    func bottom(_ relation: LayoutRelation<CGFloat>, to anchor: AnonymousRelation, priority: UILayoutPriority) -> Self
    @discardableResult
    func left(_ relation: LayoutRelation<CGFloat>, to anchor: AnonymousRelation, priority: UILayoutPriority) -> Self
    @discardableResult
    func right(_ relation: LayoutRelation<CGFloat>, to anchor: AnonymousRelation, priority: UILayoutPriority) -> Self
    @discardableResult
    func centerX(_ relation: LayoutRelation<CGFloat>, to anchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> Self
    @discardableResult
    func centerY(_ relation: LayoutRelation<CGFloat>, to anchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> Self
    @discardableResult
    func centerX(_ relation: LayoutRelation<CGFloat>, to anchor: AnonymousRelation, priority: UILayoutPriority) -> Self
    @discardableResult
    func centerY(_ relation: LayoutRelation<CGFloat>, to anchor: AnonymousRelation, priority: UILayoutPriority) -> Self
    @discardableResult
    func height(_ relation: InterRelation<AnonymousRelation>, _ dimension: LayoutDimension, multiplyBy multipier: CGFloat, constant: CGFloat, priority: UILayoutPriority) -> Self
    @discardableResult
    func width(_ relation: InterRelation<AnonymousRelation>, _ dimension: LayoutDimension, multiplyBy multipier: CGFloat, constant: CGFloat, priority: UILayoutPriority) -> Self
    @discardableResult
    func height(_ relation: InterRelation<NSLayoutDimension>, multiplyBy multipier: CGFloat, constant: CGFloat, priority: UILayoutPriority) -> Self
    @discardableResult
    func width(_ relation: InterRelation<NSLayoutDimension>, multiplyBy multipier: CGFloat, constant: CGFloat, priority: UILayoutPriority) -> Self
    @discardableResult
    func height(_ relation: InterRelation<CGFloat>, priority: UILayoutPriority) -> Self
    @discardableResult
    func width(_ relation: InterRelation<CGFloat>, priority: UILayoutPriority) -> Self
    @discardableResult
    func height(_ relation: InterRelation<AnonymousRelation>, multiplyBy multipier: CGFloat, constant: CGFloat, priority: UILayoutPriority) -> Self
    @discardableResult
    func width(_ relation: InterRelation<AnonymousRelation>, multiplyBy multipier: CGFloat, constant: CGFloat, priority: UILayoutPriority) -> Self
}
#endif
