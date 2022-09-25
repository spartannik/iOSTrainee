//
//  MainViewController.swift
//  iOSTrainee
//
//  Created by Nikita Yashchenko on 22.09.2022.
//

import UIKit

protocol MainViewControllerInput {
    func showPosts(posts: [PostEntity])
    func showAlertWith(text: String)
}

final class MainViewController: UIViewController {

    private var posts: [PostEntity]?

    var presenter: PresenterProtocol?

    //MARK: - TableView
    private var mainTableView: UITableView!
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    //MARK: - ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        configureActivityIndicator()

        presenter?.viewDidLoad()
    }
    
    //MARK: - TableView
    func configureTableView() {
        mainTableView = UITableView()
        mainTableView.separatorStyle = .none
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.estimatedRowHeight = 200
        mainTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.id)
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainTableView)
        
        mainTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    //MARK: - ActivityIndicator
    private func configureActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
    }
    
    //MARK: - NavigationBar configuration
    private func configureNavigationBar() {
        navigationItem.title = "Natife"
        
        let items = UIMenu(title: "More", options: .displayInline, children: [
            UIAction(title: "Sorting by date", image: UIImage(systemName: "calendar.badge.clock"), handler: { [unowned self] _ in
                self.posts?.sort(by: { $0.timeshamp > $1.timeshamp })
                self.mainTableView.reloadData()
                self.scrollToTop()
            }),
            UIAction(title: "Sorting by likes", image: UIImage(systemName: "heart"), handler: { [unowned self] _ in
                self.posts?.sort(by: { $0.likesCount > $1.likesCount })
                self.mainTableView.reloadData()
                self.scrollToTop()
            }),
            
            UIAction(title: "Sorting by default", image: UIImage(systemName: "heart"), handler: { [unowned self] _ in
                self.posts?.sort(by: { $0.postID > $1.postID })
                self.mainTableView.reloadData()
                self.scrollToTop()
            }),
            
        ])
        
        let menu = UIMenu(title: "Select a sorting method", children: [items])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", image: UIImage(named: "filterbutton"), primaryAction: nil, menu: menu)
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20) ,
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)]
    }
    
    //MARK: - TableView Scroll To Top
    private func scrollToTop() {
        let topRow = IndexPath(row: 0, section: 0)
        mainTableView.scrollToRow(at: topRow, at: .top, animated: true)
    }
}

//MARK: - TableView Delegate & DataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.id)
                as? CustomTableViewCell else { return UITableViewCell() }

        guard let post = posts?[indexPath.row] else {
            return UITableViewCell()
        }

        cell.setupCell(with: post)

        cell.handleState = {
            tableView.beginUpdates()
            tableView.endUpdates()
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = posts?[indexPath.row].postID else { return }
        let details = assemblyDetailsViewCotroller(postId: "\(id)")
        navigationController?.pushViewController(details, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

extension MainViewController {

    private func assemblyDetailsViewCotroller(postId: String) -> UIViewController {
        let networkService = NetworkService()
        let presenter = DetailsPresenter(networkService: networkService)

        let detailsViewController = DetailsViewController()

        detailsViewController.presenter = presenter
        detailsViewController.postId = postId

        presenter.view = detailsViewController

        return detailsViewController
    }
}

extension MainViewController: MainViewControllerInput {

    func showPosts(posts: [PostEntity]) {
        self.posts = posts
        self.configureTableView()
        self.activityIndicator.stopAnimating()
    }

    func showAlertWith(text: String) {
         let alertController = UIAlertController(title: nil, message: text, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)

        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
}
