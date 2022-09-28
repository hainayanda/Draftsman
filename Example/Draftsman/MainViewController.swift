//
//  MainViewController.swift
//  Draftsman
//
//  Created by Nayanda on 02/19/2021.
//  Copyright (c) 2021 24823437. All rights reserved.
//

import UIKit
import Draftsman
import Builder

class MainViewController: UIPlannedController {
    
    lazy var buttonToTable: UIButton = builder(UIButton())
        .layer.cornerRadius(8)
        .backgroundColor(.orange)
        .build()
    
    lazy var buttonToCollection: UIButton = builder(UIButton())
        .layer.cornerRadius(8)
        .backgroundColor(.orange)
        .build()
    
    lazy var buttonToField: UIButton = builder(UIButton())
        .layer.cornerRadius(8)
        .backgroundColor(.orange)
        .build()
    
    lazy var buttonToFragment: UIButton = builder(UIButton())
        .layer.cornerRadius(8)
        .backgroundColor(.orange)
        .build()
    
    lazy var stackView: UIStackView = VStackView(spacing: 32)
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        stackView.drf
            .center.equal(with: .parent)
            .horizontal.equal(with: .safeArea).offset(by: 16)
            .vertical.moreThan(with: .safeArea).offset(by: 16)
            .resistVerticalExpansion(.required)
            .insertStacked {
                stackPlan
            }
    }
    
    @LayoutPlan
    var stackPlan: ViewPlan {
        buttonToTable
        buttonToCollection
        buttonToField
        buttonToFragment
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Main View"
        applyPlan()
        
        buttonToTable.setTitle("Go to table view controller", for: .normal)
        buttonToTable.addTarget(self, action: #selector(goToTable(_:)), for: .touchUpInside)
        
        buttonToCollection.setTitle("Go to collection view controller", for: .normal)
        buttonToCollection.addTarget(self, action: #selector(goToCollection(_:)), for: .touchUpInside)
        
        buttonToField.setTitle("Go to keyboard controller", for: .normal)
        buttonToField.addTarget(self, action: #selector(goToKeyboard(_:)), for: .touchUpInside)
        
        buttonToFragment.setTitle("Go to fragment controller", for: .normal)
        buttonToFragment.addTarget(self, action: #selector(goToFragment(_:)), for: .touchUpInside)
    }
    
    @objc func goToTable(_ sender: Any) {
        navigationController?.pushViewController(TableViewController(), animated: true)
    }
    
    @objc func goToCollection(_ sender: Any) {
        navigationController?.pushViewController(CollectionViewController(), animated: true)
    }
    
    @objc func goToKeyboard(_ sender: Any) {
        navigationController?.pushViewController(FieldViewController(), animated: true)
    }
    
    @objc func goToFragment(_ sender: Any) {
        navigationController?.pushViewController(FragmentViewController(), animated: true)
    }
    
}
