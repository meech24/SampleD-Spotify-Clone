//
//  AuthResponse.swift
//  SampleD
//
//  Created by Demetrice Sims on 7/4/21.
//  Copyright © 2021 Demetrice Sims. All rights reserved.
//

import Foundation

struct AuthResponse: Codable{
    let access_token: String
    let expires_in: Int
    let refresh_token: String?
    let scope: String
    let token_type: String
}


