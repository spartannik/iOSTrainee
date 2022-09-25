//
//  NetworkManager.swift
//  iOSTrainee
//
//  Created by Nikita Yashchenko on 22.09.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func loadPosts(completion: @escaping PostsCompletion)
    func loadPostDetail(postId: String, completion: @escaping PostDetailCompletion)
}

final class NetworkService: NetworkServiceProtocol {

    func loadPosts(completion: @escaping PostsCompletion) {
        getRequest(URLString: basePostsURL) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                do {
                    let jsonData = try? JSONDecoder().decode(PostsModel.self, from: data)
                    completion(.success(jsonData!)) // fix
                }
            }
        }
    }

    func loadPostDetail(postId: String, completion: @escaping PostDetailCompletion) {
        getRequest(URLString: "https://raw.githubusercontent.com/anton-natife/jsons/master/api/posts/\(postId).json") { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                do {
                    let jsonData = try? JSONDecoder().decode(SinglePostModel.self, from: data)
                    completion(.success(jsonData!)) // fix
                }
            }
        }
    }

    private func getRequest(URLString: String, completion: @escaping ResultCompletion) {
        guard let url = URL(string: URLString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
    }
}
