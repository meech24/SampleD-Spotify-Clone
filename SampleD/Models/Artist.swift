//
//  Artist.swift
//  SampleD
//
//  Created by Demetrice Sims on 6/10/21.
//  Copyright © 2021 Demetrice Sims. All rights reserved.
//

import Foundation

struct Artist: Codable{
    let id: String
    let name: String
    let type: String
    let images: [APIImage]?
    let external_urls: [String: String]
    
}
