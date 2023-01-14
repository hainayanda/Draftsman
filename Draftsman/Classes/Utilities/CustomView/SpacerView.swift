//
//  SpacerView.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 11/1/23.
//

import Foundation
#if canImport(UIKit)
import UIKit

public class SpacerView: UIView {
    
    let dimension: CGFloat?
    var spaceConstraint: NSLayoutConstraint?
    
    public init(_ dimension: CGFloat) {
        self.dimension = dimension
        super.init(frame: .zero)
        self.backgroundColor = .clear
    }
    
    public init() {
        self.dimension = nil
        super.init(frame: .zero)
        self.backgroundColor = .clear
    }
    
    func apply(axis: NSLayoutConstraint.Axis) {
        spaceConstraint?.isActive = false
        guard let dimension else {
            super.setContentCompressionResistancePriority(.defaultLow, for: axis)
            super.setContentHuggingPriority(.defaultLow, for: axis)
            super.setContentCompressionResistancePriority(
                defaultContentCompressionResistancePriority(for: axis.crossAxis),
                for: axis.crossAxis
            )
            super.setContentHuggingPriority(
                defaultContentHuggingPriority(for: axis.crossAxis),
                for: axis.crossAxis
            )
            return
        }
        switch axis {
        case .horizontal:
            spaceConstraint = widthAnchor.constraint(greaterThanOrEqualToConstant: dimension)
            spaceConstraint?.isActive = true
        case .vertical:
            spaceConstraint = heightAnchor.constraint(greaterThanOrEqualToConstant: dimension)
            spaceConstraint?.isActive = true
        @unknown default:
            break
        }
    }
    
    required init?(coder: NSCoder) {
        self.dimension = nil
        super.init(coder: coder)
        self.backgroundColor = .clear
    }
    
    private var userContentHuggingPriority: [NSLayoutConstraint.Axis: UILayoutPriority] = [:]
    public override func setContentHuggingPriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) {
        super.setContentHuggingPriority(priority, for: axis)
        userContentHuggingPriority[axis] = priority
    }
    
    private var userContentCompressionResistancePriority: [NSLayoutConstraint.Axis: UILayoutPriority] = [:]
    public override func setContentCompressionResistancePriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) {
        super.setContentCompressionResistancePriority(priority, for: axis)
        userContentCompressionResistancePriority[axis] = priority
    }
    
    private func defaultContentHuggingPriority(for axis: NSLayoutConstraint.Axis) -> UILayoutPriority {
        userContentHuggingPriority[axis.crossAxis] ?? UILayoutPriority(250)
    }
    
    private func defaultContentCompressionResistancePriority(for axis: NSLayoutConstraint.Axis) -> UILayoutPriority {
        userContentCompressionResistancePriority[axis.crossAxis] ?? UILayoutPriority(750)
    }
    
}

extension NSLayoutConstraint.Axis {
    var crossAxis: NSLayoutConstraint.Axis {
        switch self {
        case .horizontal:
            return .vertical
        case .vertical:
            return .horizontal
        @unknown default:
            return self
        }
    }
}
#endif
