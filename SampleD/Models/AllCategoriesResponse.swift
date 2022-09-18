//
//  AllCategoriesResponse.swift
//  SampleD
//
//  Created by Demetrice Sims on 6/21/22.
//  Copyright © 2022 Demetrice Sims. All rights reserved.
//

import Foundation

struct AllCategoriesResponse: Codable{
    let categories: Categories
 
}
struct Categories: Codable{
    let items:[Category]
}
struct Category: Codable{
    let id: String
    let name: String
    let icons: [APIImage]
}
