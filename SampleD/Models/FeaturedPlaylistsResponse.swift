//
//  FeaturedPlayListResponse.swift
//  SampleD
//
//  Created by Demetrice Sims on 8/1/21.
//  Copyright © 2021 Demetrice Sims. All rights reserved.
//

import Foundation

struct FeaturedPlaylistsResponse: Codable{
    let playlists: PlaylistResponse
}

struct CategoryPlaylistsResponse: Codable{
    let playlists: PlaylistResponse
}

struct PlaylistResponse: Codable {
    let items: [Playlist]
}



struct User: Codable {
    let display_name: String
    let external_urls: [String: String]
    let id: String
    
}
