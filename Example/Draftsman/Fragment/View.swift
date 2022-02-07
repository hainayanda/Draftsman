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

class View: FragmentView {
    lazy var titleLabel: UILabel = builder(UILabel())
        .textAlignment(.left)
        .font(.boldSystemFont(ofSize: 14))
        .build()
    var subtitleLabel: UILabel = builder(UILabel())
        .textAlignment(.left)
        .font(.systemFont(ofSize: 12))
        .build()
    
    @LayoutPlan
    override var viewPlan: ViewPlan {
        UIImageView(image: UIImage(named: "icon_test")).plan
            .builder.contentMode(.scaleAspectFit)
            .plan.at(.fullLeft, .equalTo(12), to: .parent)
            .size(.equalTo(CGSize(sides: 56)))
        UIStackView(axis: .vertical, distribution: .fillEqually, spacing: 4).plan
            .at(.fullRight, .equalTo(12), to: .parent)
            .left(.equalTo(8), to: .right(of: .previous))
            .insertStacked {
                stackPlan
        }
    }
    
    @LayoutPlan
    var stackPlan: ViewPlan {
        titleLabel
        subtitleLabel
    }
}