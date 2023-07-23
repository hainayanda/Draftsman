//
//  StackCompatible.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 29/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

public protocol StackCompatible where Self: UIView {
    var arrangedSubviews: [UIView] { get }
    var axis: NSLayoutConstraint.Axis { get set }
    var layoutMargins: UIEdgeInsets { get set }
    var isLayoutMarginsRelativeArrangement: Bool { get set }
    func addArrangedSubview(_ view: UIView)
    func removeArrangedSubview(_ view: UIView)
    func insertArrangedSubview(_ view: UIView, at stackIndex: Int)
    func setCustomSpacing(_ spacing: CGFloat, after arrangedSubview: UIView)
    func customSpacing(after arrangedSubview: UIView) -> CGFloat
}

extension UIStackView: StackCompatible { }
#endif
