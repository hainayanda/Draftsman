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

class TableViewController: UIPlannedController {
    
    @Published var cells: [Int] = []
    
    @LayoutPlan
    var viewPlan: ViewPlan {
        UITableView().drf
            .builder.backgroundColor(.white)
            .allowsSelection(false)
            .drf.renderCells(observing: $cells, animation: .automatic) { number in
                render(TableCell.self) { cell in
                    cell.titleLabel.text = "Cell\(number)"
                    cell.subtitleLabel.text = "Cell at index \(number)"
                }
            }
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
