//
//  SearchResult.swift
//  SampleD
//
//  Created by Demetrice Sims on 7/18/22.
//  Copyright © 2022 Demetrice Sims. All rights reserved.
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case album (model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
