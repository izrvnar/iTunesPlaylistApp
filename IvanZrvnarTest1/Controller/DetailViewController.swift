//
//  DetailViewController.swift
//  IvanZrvnarTest1
//
//  Created by Ivan Zrvnar on 2022-03-04.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    //MARK: -Properties
    var album: Album?
    var playlist: Playlist!
    
    //MARK: -OUTLETS
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var appleMusicLabel: WKWebView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let album = album {
            collectionNameLabel.text = album.collectionName
            
            
        }

      
    }//: View did load
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
