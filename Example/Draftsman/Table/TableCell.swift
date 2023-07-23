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
                .contentMode(.scaleAspectFit)
                .image(assignedBy: $image)
                .storeAll(in: &cancellables)
                .widthMatchHeight()
            VStacked(margins: UIEdgeInsets(insets: 8), distribution: .fillEqually) {
                UILabel().drf
                    .textAlignment(.left)
                    .font(.boldSystemFont(ofSize: 14))
                    .text(assignedBy: $title)
                    .storeAll(in: &cancellables)
                UILabel().drf
                    .textAlignment(.left)
                    .font(.systemFont(ofSize: 12))
                    .text(assignedBy: $subtitle)
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
