//
//  DetailViewController.swift
//  IvanZrvnarTest1
//
//  Created by Ivan Zrvnar on 2022-03-04.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKUIDelegate {
    //MARK: -Properties
    var album: Album?
    var playlist: Playlist!
    
    var webView: WKWebView!
   
    
    //MARK: -OUTLETS
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var appleMusicLabel: WKWebView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let album = album {
            collectionNameLabel.text = album.collectionName
            copyrightLabel.text = album.copyright
            
            let albumURL = URL(string: "\(album.collectionViewUrl)")
            let request = URLRequest(url: albumURL!)
            appleMusicLabel.load(request)
            
            
        }

      
    }//: View did load
    
    //loading the apple music webview
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
