//
//  ViewController.swift
//  IvanZrvnarTest1
//
//  Created by Ivan Zrvnar on 2022-03-04.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: -Data Source
    private lazy var dataSource = AlbumDataSource(tableView: tableView){ [self]
        tableView, indexPath, album in
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as! AlbumTableViewCell
        cell.collectionNameOutlet?.text = album.collectionName
        cell.artistNameLabel?.text = album.artistName
        cell.genreLabel?.text = album.primaryGenreName
        cell.priceLabel?.text = ("\(album.collectionPrice)")
        
        
        if let albumArtPath = album.artworkUrl100{
            self.fetchImage(for: albumArtPath, in: cell)
        } else {
            cell.albumImageView.image = UIImage(named: "noRecord.png")
        }
        
        return cell
    }
    
    
    
    
    //MARK: - Properties
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var playlist: Playlist!

    

    
    //MARK: -VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchBar.delegate = self
        tableView.delegate = self
        
        
        
    }//: View did load
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndex = tableView.indexPathForSelectedRow else {return}
        
        let destinationVC = segue.destination as! DetailViewController
        
        let albumToPass = dataSource.itemIdentifier(for: selectedIndex)
        destinationVC.album = albumToPass
        destinationVC.playlist = playlist

    }
    
    //MARK: -Snapshot Method
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section,Album>
    func createSnapshot(with albums:[Album]){
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(albums, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    
    // MARK: - Data Fetch
    // create the URL that will fetch the album
    func createAlbumURL(from album: String) -> URL? {
        guard let cleanURL = album.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            fatalError("You can't make an album with: \(album)")
        }
        var urlString = "https://itunes.apple.com/search"
        urlString = urlString.appending("?term=\(cleanURL)&entity=album")
        print(urlString)
        
        return URL(string: urlString)
    }
    
    // fetching the album
    func fetchAlbum(from url: URL){
        let albumTask = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            if let dataError = error{
                print("Could not fetch album: \(dataError.localizedDescription)")
            } else {
                do {
                    guard let someData = data else {
                        return
                    }
                    
                    let jsonDecoder = JSONDecoder()
                    let downloadedResults = try jsonDecoder.decode(Albums.self, from: someData)
                    let albumResults = downloadedResults.results
                    
                    
                    DispatchQueue.main.async {
                        self.createSnapshot(with: albumResults)
                    }
                    
                }
                catch DecodingError.keyNotFound(let key, let context){
                    print("Error with key - \(key): \(context)")
                } catch DecodingError.valueNotFound(let value, let context){
                    print("Missing value - \(value): \(context)")
                } catch let error {
                    print("Problem decoding: \(error.localizedDescription)")
                }
            }
        }
        
        albumTask.resume()
        
    
        
    }//: fetchAlbum()
    
    //MARK: - Fetching Image
    //fetching Image Method
    
    func fetchImage(for path: String, in cell: AlbumTableViewCell){
        //let pathString = "https://is2-ssl.mzstatic.com/image"
        
        let albumPath = path
        
        guard let imageUrl = URL(string: albumPath) else {
            return
        }
        
        let imageFetchTask = URLSession.shared.downloadTask(with: imageUrl){
            url, response, error in
            if error == nil, let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data){
                
                DispatchQueue.main.async {
                    cell.albumImageView.image = image
                }
            }

        }
        imageFetchTask.resume()
        
    }
    
    
    
    
    
    


}//: View controller

//MARK: - Table View Delegation Method
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove Album"
    
}
}

//MARK: - Search Bar Delegate Method
extension ViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //mark sure there is text
        guard let searchText = searchBar.text else { return }
        
        if let albumURL = createAlbumURL(from: searchText){
            fetchAlbum(from: albumURL)
        }
        searchBar.resignFirstResponder()
    }
}
