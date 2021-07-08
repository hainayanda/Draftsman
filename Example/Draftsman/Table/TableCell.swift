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

class TableCell: TableFragmentCell {
    
    lazy var titleLabel: UILabel = builder(UILabel.self)
        .textAlignment(.left)
        .font(.boldSystemFont(ofSize: 14))
        .build()
    var subtitleLabel: UILabel = builder(UILabel.self)
        .textAlignment(.left)
        .font(.systemFont(ofSize: 12))
        .build()
    
    @LayoutPlan
    override var viewPlan: ViewPlan {
        UIImageView().plan
            .image(UIImage(named: "icon_test"))
            .contentMode(.scaleAspectFit)
            .at(.fullLeft, .equalTo(12), to: .parent)
            .width(.equalTo(.height(of: .myself)))
        UIStackView(axis: .vertical, distribution: .fillEqually, spacing: 4).plan
            .at(.fullRight, .equalTo(12), to: .parent)
            .left(.equalTo(8), to: .right(of: .previous))
            .insertStacked {
                titleLabel
                subtitleLabel
        }
    }
    
    override func calculatedCellHeight(for cellWidth: CGFloat) -> CGFloat {
        80
    }
}
