//
//  MainViewController.swift
//  Draftsman
//
//  Created by Nayanda on 02/19/2021.
//  Copyright (c) 2021 24823437. All rights reserved.
//

import UIKit
import Draftsman

class MainViewController: UIViewController, Planned {
    
    lazy var buttonToTable: UIButton = builder(UIButton.self)
        .cornerRadius(8)
        .backgroundColor(.orange)
        .build()
    
    lazy var buttonToCollection: UIButton = builder(UIButton.self)
        .cornerRadius(8)
        .backgroundColor(.orange)
        .build()
    
    lazy var buttonToField: UIButton = builder(UIButton.self)
        .cornerRadius(8)
        .backgroundColor(.orange)
        .build()
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        UIStackView(axis: .vertical, spacing: 32).plan
            .center(.equal, to: .parent)
            .horizontal(.equalTo(16), to: .safeArea)
            .vertical(.moreThanTo(16), to: .safeArea)
            .insertStacked {
                buttonToTable
                buttonToCollection
                buttonToField
            }
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

}

