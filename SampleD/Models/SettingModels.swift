//
//  SettingModels.swift
//  SampleD
//
//  Created by Demetrice Sims on 7/14/21.
//  Copyright © 2021 Demetrice Sims. All rights reserved.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}
struct Option {
    let title: String
    let handler: () -> Void 
}
