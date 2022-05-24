//
//  LayoutWithAnchors.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 23/04/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

public protocol LayoutWithAnchors {
    var topAnchor: NSLayoutYAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
}

extension UIView: LayoutWithAnchors { }
extension UILayoutGuide: LayoutWithAnchors { }
#endif
