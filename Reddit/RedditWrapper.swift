//
//  RedditWrapper.swift
//  Reddit
//
//  Created by Andrew Carter on 8/30/19.
//  Copyright © 2019 AshleyCo. All rights reserved.
//

import Foundation

struct RedditWrapper<T: Decodable>: Decodable {
    let kind: String
    let data: T
}
