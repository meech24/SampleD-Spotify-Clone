//
//  PlayList.swift
//  SampleD
//
//  Created by Demetrice Sims on 6/10/21.
//  Copyright © 2021 Demetrice Sims. All rights reserved.
//

import Foundation

struct Playlist: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
    
}
