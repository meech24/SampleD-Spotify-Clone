//
//  UserProfile.swift
//  SampleD
//
//  Created by Demetrice Sims on 6/10/21.
//  Copyright © 2021 Demetrice Sims. All rights reserved.
//

import Foundation

struct UserProfile: Codable {
    let country: String
    let display_name: String
    let email: String
    let explicit_content: [String: Bool]
    let external_urls: [String: String]
    let id: String
    let product: String
    let images: [APIImage]
    
}



