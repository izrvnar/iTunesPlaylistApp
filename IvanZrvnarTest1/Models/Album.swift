//
//  Album.swift
//  IvanZrvnarTest1
//
//  Created by Ivan Zrvnar on 2022-03-04.
//

import Foundation
// enum to use for diffable data source
enum Section: CaseIterable{
    case main
}


// creating an array of albums
struct Albums: Codable {
    var results: [Album]
}

// creating a struct to match the json from itunes API

struct Album: Codable, Hashable{
    var collectionId: Int
    var artistName: String
    var collectionName: String
    var copyright: String
    var primaryGenreName: String
    var collectionPrice: Double
    var collectionViewUrl: String
    var artworkUrl100: String?
    var collectionExplicitness: String
}

extension Album{
    var imageReplacement: String {
        return artworkUrl100 ?? "Image not availible"
    }
}


