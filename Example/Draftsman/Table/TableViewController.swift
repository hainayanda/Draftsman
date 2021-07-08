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

class TableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Table View"
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        tableView.register(TableCell.self, forCellReuseIdentifier: "TableCell")
        tableView.allowsSelection = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableCell = tableView.dequeueReusableCell(
            withIdentifier: "TableCell",
            for: indexPath) as? TableCell ?? TableCell()
        cell.titleLabel.text = "Cell\(indexPath.item)"
        cell.subtitleLabel.text = "Cell at index \(indexPath.item)"
        return cell
    }
}
