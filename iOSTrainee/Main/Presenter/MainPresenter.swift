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

final class MainPresenter: PresenterProtocol {

    var view: MainViewControllerInput?

    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func viewDidLoad() {

        networkService.loadPosts(completion: { result in
            switch result {
            case .success(let posts):
                self.configurePosts(model: posts)
            case .failure(let error):
                self.view?.showAlertWith(text: error.localizedDescription)
            }
        })
    }

    private func configurePosts(model: PostsModel) {

        let data = model.posts.map { PostEntity(postID: $0.postID,
                                                timeshamp: $0.timeshamp,
                                                likesCount: $0.likesCount,
                                                title: $0.title,
                                                previewText: $0.previewText) }

        DispatchQueue.main.async {
            self.view?.showPosts(posts: data)
        }

    }

}
