//
//  DetailsPresenter.swift
//  iOSTrainee
//
//  Created by Nikita Yashchenko on 23.09.2022.
//

import Foundation

protocol DetailsPresenterProtocol {
    func viewDidLoad(postId: String)
}

final class DetailsPresenter: DetailsPresenterProtocol {
    
    var view: DetailsViewControllerInput?
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func viewDidLoad(postId: String) {

        networkService.loadPostDetail(postId: postId) { result in
            switch result {
            case .success(let post):
                DispatchQueue.main.async {
                    self.view?.showPost(post: post)
                }
            case .failure(let error):
                self.view?.showAlertWith(text: error.localizedDescription)
            }
        }

    }

}
