//
//  AlbumDataSource.swift
//  IvanZrvnarTest1
//
//  Created by Ivan Zrvnar on 2022-03-04.
//

import Foundation
import UIKit

// this is creating the diffable data source the table view
class AlbumDataSource: UITableViewDiffableDataSource<Section, Album>{
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            var snapshot = self.snapshot()
            let itemToDelete = snapshot.itemIdentifiers[indexPath.row]
            snapshot.deleteItems([itemToDelete])
            apply(snapshot)
        }
    }
}
