//
//  PlaylistDetailsResponse.swift
//  SampleD
//
//  Created by Demetrice Sims on 5/1/22.
//  Copyright © 2022 Demetrice Sims. All rights reserved.
//

import Foundation

struct PlaylistDetailsResponse: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let tracks: PlaylistTracksResponse
}

struct PlaylistTracksResponse: Codable {
    let items: [PlaylistItem]
}

struct PlaylistItem: Codable {
    let track: AudioTrack
}
