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

class CollectionCell: UICollectionDraftedCell {
    
    lazy var titleLabel: UILabel = builder(UILabel())
        .textAlignment(.center)
        .font(.boldSystemFont(ofSize: 14))
        .build()
    var subtitleLabel: UILabel = builder(UILabel())
        .textAlignment(.center)
        .font(.systemFont(ofSize: 12))
        .build()
    
    @LayoutDraft
    var contentViewDraft: ViewDraft {
        UIImageView(image: UIImage(named: "icon_test")).drf.builder
            .contentMode(.scaleAspectFit).drf
            .top.horizontal.equal(with: .parent).offset(by: 12)
            .width.equal(with: .height(of: .mySelf))
        UIStackView(axis: .vertical, distribution: .fillEqually, spacing: 4).drf
            .bottom.horizontal.equal(with: .parent).offset(by: 12)
            .top.equal(with: .bottom(of: .previous)).offset(by: 8)
            .insertStacked {
                stackDraft
            }
    }
    
    @LayoutDraft
    var stackDraft: ViewDraft {
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
