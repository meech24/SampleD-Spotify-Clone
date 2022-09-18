//
//  AudioTrack.swift
//  SampleD
//
//  Created by Demetrice Sims on 6/10/21.
//  Copyright © 2021 Demetrice Sims. All rights reserved.
//

import Foundation

struct AudioTrack: Codable {
    var album: Album?
    let artists: [Artist]
    let available_markets: [String]
    let disc_number: Int
    let duration_ms: Int
    let explicit: Bool
    let external_urls: [String: String]
    let id: String
    let name: String
    let preview_url: String?
}
