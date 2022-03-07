//
//  PlaylistViewController.swift
//  IvanZrvnarTest1
//
//  Created by Ivan Zrvnar on 2022-03-06.
//

import UIKit

let itemsPerRow: CGFloat = 2
let interItemSpacing: CGFloat = 0

class PlaylistViewController: UIViewController{
    
    //MARK: -Properties
    var mainPlaylist: Playlist!
    
    
    
    
    
    
    //MARK: -Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    



    override func viewDidLoad() {
        super.viewDidLoad()
       

       
    }//: View did load
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}//: View Controller

extension ViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpacing
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let phoneWidth = view.safeAreaLayoutGuide.layoutFrame.width
        let totalSpacing = itemsPerRow * interItemSpacing
        
        let itemWidth = (phoneWidth - totalSpacing) / itemsPerRow

        //keeps aspect ratio for height
        return CGSize(width: itemWidth, height: itemWidth * 3 / 2)
    }
}






