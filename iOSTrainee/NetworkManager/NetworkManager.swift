//
//  NetworkManager.swift
//  iOSTrainee
//
//  Created by Nikita Yashchenko on 22.09.2022.
//

import Foundation

class NetworkManager {
    func fetchData<T: Codable>(url: URL?, type: T.Type, completionHandler: @escaping (T) -> Void) {
        guard let url = url else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error ?? "Error")
                return
            }
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(type.self, from: data)
                completionHandler(result)
            }
            catch let error {
                print(error)
            }
        }
        dataTask.resume()
    }
}
