//
//  PlaylistViewController.swift
//  IvanZrvnarTest1
//
//  Created by Ivan Zrvnar on 2022-03-06.
//

import UIKit

let itemsPerRow: CGFloat = 2
let interItemSpacing: CGFloat = 1

class PlaylistViewController: UIViewController{
    
    //MARK: -Properties
    var mainPlaylist: Playlist!
    private lazy var dataSource = UICollectionViewDiffableDataSource<Section, Album>(collectionView: collectionView){
        collectionView, indexPath, album in
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaylistCell", for: indexPath) as! AlbumCollectionViewCell
        
        cell.collectionNameLabel.text = album.collectionName
        cell.genreLabel.text = album.primaryGenreName
        
        
        
        
        
        return cell
    }
        
    //MARK: -Outlets
    @IBOutlet weak var collectionView: UICollectionView!

    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        collectionView.delegate = self

       
    }//: View did load
    override func viewWillAppear(_ animated: Bool) {
        createSnapshot(with: mainPlaylist.mainPlaylist)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    //MARK: -Methods
    
    func createSnapshot(with album: [Album]){
        var snapShot = NSDiffableDataSourceSnapshot<Section, Album>()
        snapShot.appendSections([.main])
        snapShot.appendItems(album, toSection: .main)
        dataSource.apply(snapShot)
        
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    
    

}//: PLaylist View Controller

extension PlaylistViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpacing
    }
    
}

extension PlaylistViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let phoneWidth = view.safeAreaLayoutGuide.layoutFrame.width
        let totalSpacing = itemsPerRow * interItemSpacing
        
        let itemWidth = (phoneWidth - totalSpacing) / itemsPerRow

        //keeps aspect ratio for height
        return CGSize(width: itemWidth, height: itemWidth * 3 / 2)
    }
}






