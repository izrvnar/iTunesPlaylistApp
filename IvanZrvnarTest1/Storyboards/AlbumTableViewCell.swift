//
//  AlbumTableViewCell.swift
//  IvanZrvnarTest1
//
//  Created by Ivan Zrvnar on 2022-03-04.
//

import Foundation
import UIKit


// creating a cell for the table view to use 
class AlbumTableViewCell: UITableViewCell{
    //MARK: -Outlets
    
    // cell outlets
    @IBOutlet weak var collectionNameOutlet: UILabel!
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    
    // initalize the cell code
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    // Configure the view for selected state
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
}
