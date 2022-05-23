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

class TableCell: UITableDraftedCell {
    
    lazy var titleLabel: UILabel = builder(UILabel())
        .textAlignment(.left)
        .font(.boldSystemFont(ofSize: 14))
        .build()
    var subtitleLabel: UILabel = builder(UILabel())
        .textAlignment(.left)
        .font(.systemFont(ofSize: 12))
        .build()
    
    @LayoutDraft
    var contentViewDraft: ViewDraft {
        UIImageView(image: UIImage(named: "icon_test")).drf.builder
            .contentMode(.scaleAspectFit).drf
            .left.vertical.equal(with: .parent).offset(by: 12)
            .size.equal(with: CGSize(sides: 56))
        UIStackView(axis: .vertical, distribution: .fillEqually, spacing: 4).drf
            .right.vertical.equal(with: .parent).offset(by: 12)
            .left.equal(with: .right(of: .previous)).offset(by: 8)
            .insertStacked {
                stackDraft
            }
    }
    
    @LayoutDraft
    var stackDraft: ViewDraft {
        titleLabel
        subtitleLabel
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        applyDraft()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyDraft()
    }
}
