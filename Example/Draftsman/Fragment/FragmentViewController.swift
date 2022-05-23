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

class FragmentViewController: UIDraftedController {
    
    lazy var scrollView: UIScrollView = UIScrollView()
    lazy var stackView: UIStackView = UIStackView(
        axis: .vertical,
        distribution: .equalSpacing,
        alignment: .fill
    )
    lazy var buttonAdd: UIButton = builder(UIButton())
        .layer.cornerRadius(8)
        .backgroundColor(.orange)
        .build()
    lazy var buttonRemove: UIButton = builder(UIButton())
        .layer.cornerRadius(8)
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
            applyDraft()
        }
    }
    var counter: Int = 0
    
    @LayoutDraft
    var viewDraft: ViewDraft {
        scrollView.drf
            .top.horizontal.equal(with: .safeArea)
            .bottom.equal(to: buttonStack.topAnchor).offset(by: 16)
            .insert {
                scrollContent
            }
        buttonStack.drf
            .bottom.horizontal.equal(with: .safeArea).offset(by: 16)
            .insertStacked {
                buttonAdd
                buttonRemove
            }
    }
    
    @LayoutDraft
    var scrollContent: ViewDraft {
        stackView.drf
            .width.equal(with: .parent)
            .edges.equal(with: .parent)
            .insertStacked {
                if fragments.isEmpty {
                    emptyContent
                }
                for fragment in fragments {
                    fragment
                }
            }
    }
    
    @LayoutDraft
    var emptyContent: ViewDraft {
        spacing
        UILabel().drf.builder
            .text("NO FRAGMENTS")
            .textAlignment(.center)
        spacing
    }
    
    @LayoutDraft
    var spacing: ViewDraft {
        UIView().drf
            .height.equal(to: 60)
            .builder.backgroundColor(.clear)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Fragment View"
        view.backgroundColor = .white
        applyDraft()
        
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
