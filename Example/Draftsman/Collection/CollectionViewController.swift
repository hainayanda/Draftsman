//
//  CollectionViewController.swift
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

class CollectionViewController: UIPlannedController {
    
    @Published var cells: [Int] = []
    
    var cellWidth: CGFloat {
        if #available(iOS 11.0, *) {
            return min(
                view.safeAreaLayoutGuide.layoutFrame.width,
                view.safeAreaLayoutGuide.layoutFrame.height
            ) / 2
        } else {
            return min(
                view.frame.width - view.layoutMargins.horizontal.total,
                view.frame.height - view.layoutMargins.vertical.total
            ) / 2
        }
    }
    
    lazy var collectionLayout: UICollectionViewFlowLayout = builder(UICollectionViewFlowLayout())
        .minimumLineSpacing(.zero)
        .minimumInteritemSpacing(.zero)
        .itemSize(CGSize(width: cellWidth, height: cellWidth * 1.2))
        .build()
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        Collectioned(collectionLayout, forCell: CollectionCell.self, observing: $cells) { cell, number in
            cell.title = "Cell\(number)"
            cell.subtitle = "Cell at index \(number)"
        }
        .backgroundColor(.white)
        .allowsSelection(false)
        .matchSafeAreaH()
        .matchParentV()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Collection View"
        view.backgroundColor = .white
        applyPlan()
        cells = (0..<10).map { $0 }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.cells = (0..<10).shuffled() + (10..<20).shuffled()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { [weak self] in
            self?.cells = (0..<100).map { $0 }
        }
    }
}
