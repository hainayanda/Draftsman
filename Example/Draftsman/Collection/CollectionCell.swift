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
import Combine

class CollectionCell: UICollectionPlannedCell {
    
    @Published var image: UIImage? = UIImage(named: "icon_test")
    @Published var title: String?
    @Published var subtitle: String?
    
    var cancellables: Set<AnyCancellable> = .init()
    
    @LayoutPlan
    var contentViewPlan: ViewPlan {
        VStacked(margins: UIEdgeInsets(insets: 12), spacing: 8) {
            Margined(by: UIEdgeInsets(insets: 8)) {
                UIImageView().drf.builder
                    .contentMode(.scaleAspectFit).drf
                    .widthMatchHeight()
                    .builder.contentMode(.scaleAspectFit)
                    .subscriber.image(to: $image)
                    .storeAll(in: &cancellables)
            }
            VStacked(distribution: .fillEqually, spacing: 4) {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyPlan()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyPlan()
    }
}
