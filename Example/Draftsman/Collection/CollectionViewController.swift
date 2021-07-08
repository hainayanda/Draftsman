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

class CollectionViewController: UIViewController, Planned {
    
    lazy var collectionLayout: UICollectionViewFlowLayout = builder(UICollectionViewFlowLayout())
        .minimumLineSpacing(.zero)
        .minimumInteritemSpacing(.zero)
        .itemSize(CGSize(width: view.frame.width / 2, height: view.frame.width * 0.6))
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
        collectionView.plan.edges(.equal, to: .parent)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Collection View"
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
