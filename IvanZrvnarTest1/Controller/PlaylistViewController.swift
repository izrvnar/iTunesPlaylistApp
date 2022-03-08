//
//  PlaylistViewController.swift
//  IvanZrvnarTest1
//
//  Created by Ivan Zrvnar on 2022-03-06.
//

import UIKit


class PlaylistViewController: UIViewController{
    let itemsPerRow: CGFloat = 2
    let interItemSpacing: CGFloat = 1

    
    //MARK: -Properties
    var mainPlaylist: Playlist!
    var album: Album?
    private lazy var dataSource = UICollectionViewDiffableDataSource<Section, Album>(collectionView: collectionView){
        collectionView, indexPath, album in
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaylistCell", for: indexPath) as! AlbumCollectionViewCell
        
        cell.collectionNameLabel.text = album.collectionName
        cell.genreLabel.text = album.primaryGenreName
        
        if album.collectionExplicitness == "notExplicit"{
            cell.explicitLabel.image = UIImage(systemName: "speaker.wave.3")
        } else {
            cell.explicitLabel.image = UIImage(systemName: "speaker.badge.exclamationmark")
        }
        
        
        
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

}//: PLaylist View Controller

extension PlaylistViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpacing
    }
    
    
    // adding the ability to delete
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let album = mainPlaylist.mainPlaylist[indexPath.item]

        let ac = UIAlertController(title: "Delete Album?", message: "Do you want to delete \(album.collectionName)? from your playlist", preferredStyle: .alert)

        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.mainPlaylist.mainPlaylist.remove(at: indexPath.item)
            self?.createSnapshot(with: (self?.mainPlaylist.mainPlaylist)!)

            

        })


present(ac,animated: true)


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






