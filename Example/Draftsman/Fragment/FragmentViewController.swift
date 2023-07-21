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

class FragmentViewController: UIPlannedController {
    
    lazy var buttonAdd: UIButton = builder(UIButton())
        .layer.cornerRadius(8)
        .backgroundColor(.orange)
        .build()
    lazy var buttonRemove: UIButton = builder(UIButton())
        .layer.cornerRadius(8)
        .backgroundColor(.orange)
        .build()
    
    var fragments: [View] = [] {
        didSet {
            applyPlan()
        }
    }
    
    var counter: Int = 0
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        VStacked(spacing: 16) {
            VScrollableStacked(alignment: .fill) {
                fragments.isEmpty ? emptyContent: fragments
            }
            VStacked(margins: UIEdgeInsets(insets: 16), distribution: .fillEqually, spacing: 16) {
                buttonAdd
                buttonRemove
            }
        }
        .fillParent()
    }
    
    @LayoutPlan
    var emptyContent: ViewPlan {
        SpacerView(60)
        UILabel().drf.builder
            .text("NO FRAGMENTS")
            .textAlignment(.center)
        SpacerView(60)
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
        fragment.title = "Added"
        fragment.subtitle = "New fragment with index of: \(counter)"
        fragments.append(fragment)
        counter += 1
    }
    
    @objc func removeFragment(_ sender: Any) {
        guard !fragments.isEmpty else { return }
        fragments.removeLast()
    }
}
