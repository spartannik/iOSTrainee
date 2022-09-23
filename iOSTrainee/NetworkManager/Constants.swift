//
//  Constants.swift
//  iOSTrainee
//
//  Created by Nikita Yashchenko on 23.09.2022.
//

import Foundation

typealias ResultCompletion = (Result<Data, Error>) -> ()
typealias PostsCompletion = (Result<PostsModel, Error>) -> ()
typealias PostDetailCompletion = (Result<SinglePostModel, Error>) -> ()

let basePostsURL = "https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json"
