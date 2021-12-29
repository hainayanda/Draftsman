//
//  FragmentViewController.swift
//  Draftsman_Example
//
//  Created by Nayanda Haberty on 28/12/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import Draftsman
import Builder

class FragmentViewController: UIViewController, Planned {
    
    lazy var scrollView: UIScrollView = UIScrollView()
    lazy var stackView: UIStackView = UIStackView(
        axis: .vertical,
        distribution: .equalSpacing,
        alignment: .fill
    )
    lazy var buttonAdd: UIButton = builder(UIButton())
        .cornerRadius(8)
        .backgroundColor(.orange)
        .build()
    lazy var buttonRemove: UIButton = builder(UIButton())
        .cornerRadius(8)
        .backgroundColor(.orange)
        .build()
    lazy var buttonStack: UIStackView = UIStackView(
        axis: .vertical,
        distribution: .fillEqually,
        alignment: .fill,
        spacing: 16
    )
    var fragments: [View] = [] {
        didSet {
            applyPlan()
        }
    }
    var counter: Int = 0
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        scrollView.plan
            .at(.fullTop, .equal, to: .safeArea)
            .bottom(.equalTo(16), to: buttonStack.topAnchor)
            .insert {
                scrollContent
            }
        buttonStack.plan
            .horizontal(.equalTo(16), to: .safeArea)
            .bottom(.equal, to: .safeArea)
            .insertStacked {
                buttonAdd
                buttonRemove
            }
    }
    
    @LayoutPlan
    var scrollContent: ViewPlan {
        stackView.plan
            .width(.equalTo(.parent))
            .edges(.equal, to: .parent)
            .insertStacked {
                if fragments.isEmpty {
                    emptyContent
                }
                for fragment in fragments {
                    fragment
                }
            }
    }
    
    @LayoutPlan
    var emptyContent: ViewPlan {
        spacing
        UILabel().plan.builder
            .text("NO FRAGMENTS")
            .textAlignment(.center)
        spacing
    }
    
    @LayoutPlan
    var spacing: ViewPlan {
        UIView().plan
            .height(.equalTo(60))
            .builder.backgroundColor(.clear)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Fragment View"
        view.backgroundColor = .white
        applyPlan()
        
        buttonAdd.setTitle("Add fragment", for: .normal)
        buttonAdd.addTarget(self, action: #selector(addFragment(_:)), for: .touchUpInside)
        
        buttonRemove.setTitle("Remove fragment", for: .normal)
        buttonRemove.addTarget(self, action: #selector(removeFragment(_:)), for: .touchUpInside)
    }
    
    @objc func addFragment(_ sender: Any) {
        let fragment = View()
        fragment.titleLabel.text = "Added"
        fragment.subtitleLabel.text = "New fragment with index of: \(counter)"
        fragments.append(fragment)
        counter += 1
    }
    
    @objc func removeFragment(_ sender: Any) {
        guard !fragments.isEmpty else { return }
        fragments.removeLast()
    }
}
