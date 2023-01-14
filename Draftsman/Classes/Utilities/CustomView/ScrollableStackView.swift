//
//  File.swift
//  
//
//  Created by Nayanda Haberty on 9/1/23.
//

import Foundation
#if canImport(UIKit)
import UIKit

public class ScrollableStackView: UIScrollView, Planned {
    let alignment: UIStackView.Alignment
    let spacing: CGFloat
    public var axis: NSLayoutConstraint.Axis {
        didSet {
            stackView.axis = axis
        }
    }
    
    lazy var stackView: UIStackView = UIStackView(
        axis: axis,
        distribution: .equalSpacing,
        alignment: alignment,
        spacing: spacing
    )
    
    public override var subviews: [UIView] {
        var allSubviews = super.subviews
        allSubviews.append(contentsOf: stackView.subviews)
        return allSubviews
    }
    
    @LayoutPlan
    public var viewPlan: ViewPlan {
        if axis == .vertical {
            stackView.drf
                .width.equal(with: .parent)
                .edges.equal(with: .parent)
        } else {
            stackView.drf
                .height.equal(with: .parent)
                .edges.equal(with: .parent)
        }
    }
    
    public override init(frame: CGRect) {
        self.alignment = .center
        self.spacing = .zero
        self.axis = .vertical
        super.init(frame: frame)
    }
    
    public init(
        frame: CGRect = .zero,
        axis: NSLayoutConstraint.Axis,
        margins: UIEdgeInsets? = nil,
        alignment: UIStackView.Alignment = .center,
        spacing: CGFloat = .zero) {
            self.axis = axis
            self.alignment = alignment
            self.spacing = spacing
            super.init(frame: frame)
            if let margins = margins {
                self.stackView.layoutMargins = margins
                self.stackView.isLayoutMarginsRelativeArrangement = true
            }
            applyPlan()
        }
    
    required init?(coder: NSCoder) {
        self.axis = .vertical
        self.alignment = .center
        self.spacing = .zero
        super.init(coder: coder)
        applyPlan()
    }
}

extension ScrollableStackView: StackCompatible {
    
    public override var layoutMargins: UIEdgeInsets {
        get {
            stackView.layoutMargins
        }
        set {
            stackView.layoutMargins = newValue
        }
    }
    
    public var isLayoutMarginsRelativeArrangement: Bool {
        get {
            stackView.isLayoutMarginsRelativeArrangement
        }
        set {
            stackView.isLayoutMarginsRelativeArrangement = newValue
        }
    }
    
    public var arrangedSubviews: [UIView] {
        stackView.arrangedSubviews
    }
    
    public func addArrangedSubview(_ view: UIView) {
        stackView.addArrangedSubview(view)
    }
    
    public func removeArrangedSubview(_ view: UIView) {
        stackView.removeArrangedSubview(view)
    }
    
    public func insertArrangedSubview(_ view: UIView, at stackIndex: Int) {
        stackView.insertArrangedSubview(view, at: stackIndex)
    }
    
    @available(iOS 11.0, *)
    public func setCustomSpacing(_ spacing: CGFloat, after arrangedSubview: UIView) {
        stackView.setCustomSpacing(spacing, after: arrangedSubview)
    }
    
    @available(iOS 11.0, *)
    public func customSpacing(after arrangedSubview: UIView) -> CGFloat {
        stackView.customSpacing(after: arrangedSubview)
    }
}
#endif
