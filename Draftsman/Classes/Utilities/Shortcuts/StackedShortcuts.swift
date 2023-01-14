//
//  File.swift
//  
//
//  Created by Nayanda Haberty on 9/1/23.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: AxisStacked

public class AxisStacked: LayoutDraft<UIStackView> {
    
    public class var axis: NSLayoutConstraint.Axis { fatalError("Please override the axis") }
    
    public init(_ stack: UIStackView = UIStackView(), @LayoutPlan _ layouter: () -> ViewPlan) {
        stack.axis = Self.axis
        super.init(view: stack)
        insertStacked(layouter)
    }
}

extension AxisStacked {
    
    public convenience init(
        margins: UIEdgeInsets? = nil,
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill,
        spacing: CGFloat = .zero,
        @LayoutPlan _ layouter: () -> ViewPlan) {
            let stack = UIStackView(
                axis: Self.axis,
                margins: margins,
                distribution: distribution,
                alignment: alignment,
                spacing: spacing
            )
            self.init(stack, layouter)
        }
    
    public convenience init(
        margin: CGFloat,
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill,
        spacing: CGFloat = .zero,
        @LayoutPlan _ layouter: () -> ViewPlan) {
            let stack = UIStackView(
                axis: Self.axis,
                margins: UIEdgeInsets(insets: margin),
                distribution: distribution,
                alignment: alignment,
                spacing: spacing
            )
            self.init(stack, layouter)
        }
}

// MARK: HStacked

public final class HStacked: AxisStacked {
    public override class var axis: NSLayoutConstraint.Axis { .horizontal }
    
    public override init(_ stack: UIStackView = UIStackView(), @LayoutPlan _ layouter: () -> ViewPlan) {
        super.init(stack, layouter)
    }
}

// MARK: VStacked

public final class VStacked: AxisStacked {
    public override class var axis: NSLayoutConstraint.Axis { .vertical }
    
    public override init(_ stack: UIStackView, @LayoutPlan _ layouter: () -> ViewPlan) {
        super.init(stack, layouter)
    }
}

// MARK: AxisScrollableStacked

public class AxisScrollableStacked: LayoutDraft<ScrollableStackView> {
    
    class var axis: NSLayoutConstraint.Axis { fatalError("Please override the axis") }
    
    public init(_ stack: ScrollableStackView = ScrollableStackView(), @LayoutPlan _ layouter: () -> ViewPlan) {
        stack.axis = Self.axis
        super.init(view: stack)
        insertStacked(layouter)
    }
}

extension AxisScrollableStacked {
    
    public convenience init(
        margins: UIEdgeInsets? = nil,
        alignment: UIStackView.Alignment = .center,
        spacing: CGFloat = .zero,
        @LayoutPlan _ layouter: () -> ViewPlan) {
            let stack = ScrollableStackView(
                axis: Self.axis,
                margins: margins,
                alignment: alignment,
                spacing: spacing
            )
            self.init(stack, layouter)
        }
    
    public convenience init(
        margin: CGFloat,
        alignment: UIStackView.Alignment = .center,
        spacing: CGFloat = .zero,
        @LayoutPlan _ layouter: () -> ViewPlan) {
            let stack = ScrollableStackView(
                axis: Self.axis,
                margins: UIEdgeInsets(insets: margin),
                alignment: alignment,
                spacing: spacing
            )
            self.init(stack, layouter)
        }
}

// MARK: HScrollableStacked

public final class HScrollableStacked: AxisScrollableStacked {
    public override class var axis: NSLayoutConstraint.Axis { .horizontal }
    
    public override init(_ stack: ScrollableStackView = ScrollableStackView(), @LayoutPlan _ layouter: () -> ViewPlan) {
        super.init(stack, layouter)
    }
}

// MARK: VScrollableStacked

public final class VScrollableStacked: AxisScrollableStacked {
    public override class var axis: NSLayoutConstraint.Axis { .vertical }
    
    public override init(_ stack: ScrollableStackView = ScrollableStackView(), @LayoutPlan _ layouter: () -> ViewPlan) {
        super.init(stack, layouter)
    }
}
#endif
