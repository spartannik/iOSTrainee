//
//  DetailsViewController.swift
//  iOSTrainee
//
//  Created by Nikita Yashchenko on 22.09.2022.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    var singlePostUrl: URL?
    
    //MARK: - UI
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private let scrollView = UIScrollView()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .blue
        contentView.frame.size = CGSize(width: scrollView.contentSize.width, height: scrollView.contentSize.height)
        return contentView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        configureScrollView()
        layout()
        activityIndicator.startAnimating()

     // в презентер
//        networkManager.fetchData(url: singlePostUrl, type: SinglePostModel.self) { singlePost in
//            DispatchQueue.main.async { [weak self] in
//                self?.updateDetailsViewController(with: singlePost)
//                self?.activityIndicator.stopAnimating()
//            }
//        }
    }
    
    //MARK: - NavigationBar
    private func configureNavigationBar() {
        navigationItem.title = "Natife"
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2274509804, green: 0.3254901961, blue: 0.3647058824, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20) ,
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2274509804, green: 0.3254901961, blue: 0.3647058824, alpha: 1)]
    }
    
    //MARK: - ScrollView
    private func configureScrollView() {
        scrollView.backgroundColor = .white
        scrollView.frame = view.frame
        scrollView.contentSize.height = contentView.bounds.height
        scrollView.contentSize.width = view.bounds.width
    }
    
    private func updateDetailsViewController(with p: SinglePostModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        let timeInterval = Date(timeIntervalSince1970: TimeInterval(p.post.timeshamp))
        let date = dateFormatter.string(from: timeInterval)
        
        guard let imageUrl = URL(string: p.post.postImage) else { return }
        guard let imageData = try? Data(contentsOf: imageUrl) else { return }
        
        titleLabel.text = p.post.title
        descriptionLabel.text = p.post.text
        likesLabel.text = "❤️ \(p.post.likesCount)"
        dateLabel.text = date
        imageView.image = UIImage(data: imageData)
        
    }
    
    //MARK: - Layout
    private func layout() {
        view.addSubview(scrollView)
        view.addSubview(activityIndicator)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(likesLabel)
        contentView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            likesLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            likesLabel.heightAnchor.constraint(equalToConstant: 20),
            
            dateLabel.topAnchor.constraint(equalTo: likesLabel.topAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
