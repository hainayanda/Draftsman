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

class CollectionCell: UICollectionPlannedCell {
    
    lazy var titleLabel: UILabel = builder(UILabel())
        .textAlignment(.center)
        .font(.boldSystemFont(ofSize: 14))
        .build()
    var subtitleLabel: UILabel = builder(UILabel())
        .textAlignment(.center)
        .font(.systemFont(ofSize: 12))
        .build()
    
    @LayoutPlan
    var contentViewPlan: ViewPlan {
        VStacked(margins: UIEdgeInsets(insets: 12), spacing: 8) {
            Margined(by: UIEdgeInsets(insets: 8)) {
                UIImageView(image: UIImage(named: "icon_test")).drf.builder
                    .contentMode(.scaleAspectFit).drf
                    .widthMatchHeight()
            }
            VStacked(distribution: .fillEqually, spacing: 4) {
                titleLabel
                subtitleLabel
            }
        }
        .fillParent()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyPlan()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyPlan()
    }
}
