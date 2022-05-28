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
    func addArrangedSubview(_ view: UIView)
    func removeArrangedSubview(_ view: UIView)
    func insertArrangedSubview(_ view: UIView, at stackIndex: Int)
    @available(iOS 11.0, *)
    func setCustomSpacing(_ spacing: CGFloat, after arrangedSubview: UIView)
    @available(iOS 11.0, *)
    func customSpacing(after arrangedSubview: UIView) -> CGFloat
}

extension UIStackView: StackCompatible { }
#endif
