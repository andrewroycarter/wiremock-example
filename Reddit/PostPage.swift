//
//  PostPage.swift
//  Reddit
//
//  Created by Andrew Carter on 8/30/19.
//  Copyright © 2019 AshleyCo. All rights reserved.
//

import Foundation

struct PostPage<T: Decodable>: Decodable {
    let after: String?
    let before: String?
    let children: [RedditWrapper<T>]
}
