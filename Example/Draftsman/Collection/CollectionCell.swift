//
//  CollectionCell.swift
//  Draftsman_Example
//
//  Created by Nayanda Haberty on 08/07/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import Draftsman
import Builder

class CollectionCell: CollectionFragmentCell {
    
    lazy var titleLabel: UILabel = builder(UILabel())
        .textAlignment(.center)
        .font(.boldSystemFont(ofSize: 14))
        .build()
    var subtitleLabel: UILabel = builder(UILabel())
        .textAlignment(.center)
        .font(.systemFont(ofSize: 12))
        .build()
    
    @LayoutPlan
    override var viewPlan: ViewPlan {
        UIImageView(image: UIImage(named: "icon_test")).plan
            .contentMode(.scaleAspectFit)
            .at(.fullTop, .equalTo(12), to: .parent)
            .width(.equalTo(.height(of: .myself)))
        UIStackView(axis: .vertical, distribution: .fillEqually, spacing: 4).plan
            .at(.fullBottom, .equalTo(12), to: .parent)
            .top(.equalTo(8), to: .bottom(of: .previous))
            .insertStacked {
                titleLabel
                subtitleLabel
        }
    }
}
