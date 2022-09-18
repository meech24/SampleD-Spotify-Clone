//
//  SearchResults.swift
//  SampleD
//
//  Created by Demetrice Sims on 7/14/22.
//  Copyright © 2022 Demetrice Sims. All rights reserved.
//

import Foundation

struct SearchResultsResponse: Codable {
    let albums: SearchAlbumResponse
    let artists:SearchArtistsResponse
    let playlists:SearchPlaylistsResponse
    let tracks:SearchTracksResponse

    
 
}

struct SearchAlbumResponse: Codable {
    let items:[Album]
}

struct SearchArtistsResponse: Codable {
    let items: [Artist]
}


struct SearchPlaylistsResponse: Codable {
    let items: [Playlist]
}

struct SearchTracksResponse: Codable {
    let items: [AudioTrack]
}
