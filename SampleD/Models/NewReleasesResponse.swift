//
//  NewReleasesResponse.swift
//  SampleD
//
//  Created by Demetrice Sims on 7/27/21.
//  Copyright © 2021 Demetrice Sims. All rights reserved.
//

import Foundation

struct NewReleasesResponse: Codable {
    let albums: AlbumsResponse
}

struct AlbumsResponse: Codable{
    let items: [Album]
}
struct Album: Codable {
    let album_type: String
    let available_markets: [String]
    let id: String
    var images:[APIImage]
    let name: String
    let release_date: String
    let total_tracks: Int
    let artists: [Artist]
    
}



