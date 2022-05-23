//
//  View.swift
//  Draftsman_Example
//
//  Created by Nayanda Haberty on 28/12/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import Draftsman
import Builder

class View: UIDraftedView {
    lazy var titleLabel: UILabel = builder(UILabel())
        .textAlignment(.left)
        .font(.boldSystemFont(ofSize: 14))
        .build()
    var subtitleLabel: UILabel = builder(UILabel())
        .textAlignment(.left)
        .font(.systemFont(ofSize: 12))
        .build()
    
    lazy var imageView: UIImageView = UIImageView(image: UIImage(named: "icon_test"))
    lazy var stackView: UIStackView = UIStackView(axis: .vertical, distribution: .fillEqually, spacing: 4)
    
    @LayoutDraft
    var viewDraft: ViewDraft {
        imageView.drf.builder
            .contentMode(.scaleAspectFit).drf
            .left.vertical.equal(with: .parent).offset(by: 12)
            .size.equal(with: CGSize(sides: 56))
        stackView.drf
            .right.vertical.equal(with: .parent).offset(by: 12)
            .left.equal(with: .right(of: .previous)).offset(by: 8)
            .insertStacked {
                stackPlan
            }
    }
    
    @LayoutDraft
    var stackPlan: ViewDraft {
        titleLabel
        subtitleLabel
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyDraft()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyDraft()
    }
}
