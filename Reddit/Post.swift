//
//  Post.swift
//  Reddit
//
//  Created by Andrew Carter on 8/30/19.
//  Copyright © 2019 AshleyCo. All rights reserved.
//

import Foundation

typealias PostResult = Result<RedditWrapper<PostPage<Post>>, Error>

struct Post: Decodable {
    
    let title: String
    let url: String
    
}
