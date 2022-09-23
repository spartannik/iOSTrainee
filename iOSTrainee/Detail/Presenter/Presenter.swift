//
//  Presenter.swift
//  iOSTrainee
//
//  Created by Nikita Yashchenko on 23.09.2022.
//

import Foundation

protocol DetailsPresenterProtocol {
    func viewDidLoad()
}

final class DetailsPresenter: DetailsPresenterProtocol {
    
    var view: DetailsViewControllerInput?
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func viewDidLoad() {
        
        loadPostDetail(postId: String, completion: { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                do {
                    let jsonData = try? JSONDecoder().decode(SinglePostModel.self, from: data)
                    completion(.success(jsonData!)) // fix
                }
            })
        }
    }
}
