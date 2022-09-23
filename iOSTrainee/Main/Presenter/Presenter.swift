//
//  Presenter.swift
//  iOSTrainee
//
//  Created by Nikita Yashchenko on 23.09.2022.
//

import Foundation

protocol PresenterProtocol {
    func viewDidLoad()
}

final class Presenter: PresenterProtocol {

    var view: MainViewControllerInput?

    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func viewDidLoad() {

        networkService.loadPosts(completion: { result in
            switch result {
            case .success(let posts):
                DispatchQueue.main.async {
                    self.view?.showPosts(posts: posts)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }

}
