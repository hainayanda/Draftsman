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

class CollectionViewController: UIViewController, Planned {
    
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
    lazy var collectionView: UICollectionView = builder(
        UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionLayout
        )
    )
        .backgroundColor(.white)
        .allowsSelection(false)
        .dataSource(self)
        .build()
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        collectionView.drf
            .horizontal.equal(with: .safeArea)
            .vertical.equal(with: .parent)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Collection View"
        view.backgroundColor = .white
        applyPlan()
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: "CollectionCell")
        collectionView.reloadData()
    }
    
}

extension CollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CollectionCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CollectionCell",
            for: indexPath) as? CollectionCell ?? CollectionCell()
        cell.titleLabel.text = "Cell\(indexPath.item)"
        cell.subtitleLabel.text = "Cell at index \(indexPath.item)"
        return cell
    }
}
