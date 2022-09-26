//
//  SinglePostModel.swift
//  iOSTrainee
//
//  Created by Nikita Yashchenko on 22.09.2022.
//

import Foundation

struct SinglePostModel: Codable {
    let post: SinglePost
}

struct SinglePost: Codable {
    let postID, timeshamp, likesCount: Int
    let title, text, postImage: String
    
    enum CodingKeys: String, CodingKey {
        case timeshamp, title, text, postImage
        case postID = "postId"
        case likesCount = "likes_count"
    }
}
