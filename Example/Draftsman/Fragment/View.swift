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
import Combine

class View: UIPlannedView {
    
    @Published var title: String?
    @Published var subtitle: String?
    
    var cancellables: Set<AnyCancellable> = .init()
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        HStacked(margins: UIEdgeInsets(insets: 12), spacing: 8) {
            UIImageView(image: UIImage(named: "icon_test")).drf
                .sized(CGSize(sides: 56))
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
