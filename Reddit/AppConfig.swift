//
//  AppConfig.swift
//  Reddit
//
//  Created by Andrew Carter on 3/4/20.
//  Copyright © 2020 AshleyCo. All rights reserved.
//

import Foundation

struct AppConfig: Decodable {
    
    static var shared: AppConfig = {
        let configFileName = Bundle.main.infoDictionary?["AppConfigFile"] as! String
        let url = Bundle.main.url(forResource: configFileName, withExtension: "plist")!

        let data = try! Data(contentsOf: url)
        return try! PropertyListDecoder().decode(AppConfig.self, from: data)
    }()
    
    let apiHost: String
    let apiPort: Int
    
}
