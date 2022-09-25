//
//  File.swift
//  iOSTrainee
//
//  Created by Nikita Yashchenko on 22.09.2022.
//

import Foundation

struct PostsModel: Codable {
    let posts: [Post]
}

struct Post: Codable {
    let postID, timeshamp, likesCount: Int
    let title, previewText: String

    enum CodingKeys: String, CodingKey {
        case timeshamp, title
        case postID = "postId"
        case previewText = "preview_text"
        case likesCount = "likes_count"
    }

}

struct PostEntity {

    var postID: Int
    var    timeshamp: Int
    var likesCount: Int
    var title: String
    var previewText: String

    var timestampValue: String

    init(postID: Int, timeshamp: Int, likesCount: Int, title: String, previewText: String) {
        self.postID = postID
        self.timeshamp = timeshamp
        self.likesCount = likesCount
        self.title = title
        self.previewText = previewText
        self.timestampValue = ""
        self.timestampValue = formatter(timeshamp: timeshamp)
     }

    mutating func formatter(timeshamp: Int) -> String {

        let startDate = Date()
        let endDateTimeInterval = TimeInterval(timeshamp)
        let endDate = Date(timeIntervalSince1970: endDateTimeInterval)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let endDateString = dateFormatter.string(from: endDate)

        if let endDate = dateFormatter.date(from: endDateString) {
            let components = Calendar.current.dateComponents([.day], from: endDate, to: startDate)
            return "\(components.day!) days ago"
        }
        return ""
    }


}
