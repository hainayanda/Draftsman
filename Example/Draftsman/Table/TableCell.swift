//
//  TableCell.swift
//  Draftsman_Example
//
//  Created by Nayanda Haberty on 08/07/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import Draftsman
import Builder

class TableCell: UITablePlannedCell {
    
    lazy var titleLabel: UILabel = builder(UILabel())
        .textAlignment(.left)
        .font(.boldSystemFont(ofSize: 14))
        .build()
    var subtitleLabel: UILabel = builder(UILabel())
        .textAlignment(.left)
        .font(.systemFont(ofSize: 12))
        .build()
    
    @LayoutPlan
    var contentViewPlan: ViewPlan {
        HStacked(margins: UIEdgeInsets(insets: 12), spacing: 8) {
            UIImageView(image: UIImage(named: "icon_test")).drf
                .widthMatchHeight()
                .builder.contentMode(.scaleAspectFit).drf
            VStacked(margins: UIEdgeInsets(insets: 8), distribution: .fillEqually) {
                titleLabel
                subtitleLabel
            }
        }
        .fillParent()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        applyPlan()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyPlan()
    }
}
