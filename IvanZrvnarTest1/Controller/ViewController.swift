//
//  ViewController.swift
//  IvanZrvnarTest1
//
//  Created by Ivan Zrvnar on 2022-03-04.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: -Data Source
    private lazy var dataSource = AlbumDataSource(tableView: tableView){
        tableView, indexPath, album in
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
        
        
        
        return cell
    }
    
    
    
    
    //MARK: - Properties
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    

    
    //MARK: -VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }//: View did load


}//: View controller

