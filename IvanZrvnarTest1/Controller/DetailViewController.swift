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
    
    //MARK: -OUTLETS
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var appleMusicLabel: WKWebView!
    
    // adding to playlist
    @IBAction func addToPlaylistButton(_ sender: Any) {
        if let album = album {
            if !playlist.mainPlaylist.contains(album){
                playlist.mainPlaylist.append(album)
                // add show alert function
                showAlert(with: "🎸Added🤟", withMessage: "\(album.collectionName) has been added to your Playlist")
                
            } else {
                showAlert(with: "Already Added", withMessage: "\(album.collectionName) is already in your playlist")
            }
        }
    }
    //MARK: -Show Alert Method
    func showAlert(with title: String, withMessage message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default){
            [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    
    

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
    
   
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
