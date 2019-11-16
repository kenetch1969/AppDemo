//
//  Posts.swift
//  AppDemos
//
//  Created by Juan Gerardo Cruz on 11/15/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import Foundation

struct Posts: Codable {
    let posts: [Post]
    
    init(posts: [Post]) {
        self.posts = posts
    }
}

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
    init(userId: Int, id: Int,  title: String, body: String) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
}
