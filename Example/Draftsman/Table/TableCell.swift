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
import Combine

class TableCell: UITablePlannedCell {
    
    @Published var image: UIImage? = UIImage(named: "icon_test")
    @Published var title: String?
    @Published var subtitle: String?
    
    var cancellables: Set<AnyCancellable> = .init()
    
    @LayoutPlan
    var contentViewPlan: ViewPlan {
        HStacked(margins: UIEdgeInsets(insets: 12), spacing: 8) {
            UIImageView().drf
                .widthMatchHeight()
                .builder.contentMode(.scaleAspectFit)
                .subscriber.image(to: $image)
                .storeAll(in: &cancellables)
            VStacked(margins: UIEdgeInsets(insets: 8), distribution: .fillEqually) {
                UILabel().drf.builder
                    .textAlignment(.left)
                    .font(.boldSystemFont(ofSize: 14))
                    .subscriber.text(to: $title)
                    .storeAll(in: &cancellables)
                UILabel().drf.builder
                    .textAlignment(.left)
                    .font(.systemFont(ofSize: 12))
                    .subscriber.text(to: $subtitle)
                    .storeAll(in: &cancellables)
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
