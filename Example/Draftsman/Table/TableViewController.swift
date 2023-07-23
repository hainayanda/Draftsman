//
//  TableViewController.swift
//  Draftsman_Example
//
//  Created by Nayanda Haberty on 08/07/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import Draftsman
import Combine

class TableViewController: UIPlannedController {
    
    @Published var cells: [Int] = []
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        Tabled(forCell: TableCell.self, observing: $cells, animation: .automatic) { cell, number in
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
        title = "Table View"
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
