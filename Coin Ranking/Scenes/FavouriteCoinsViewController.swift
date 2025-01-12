//
//  FavouriteCoinsViewController.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 11/01/2025.
//

import UIKit

final class FavouriteCoinsViewController: UIViewController {
    private let tableview = UITableView(frame: .zero, style: .plain)
    private let loadingIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        return activityIndicator
    }()

    private var presenter: FavouriteCoinsPresenter!
    private var coins: [Coin] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSubviews()

        presenter = FavouriteCoinsPresenter(view: self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        Task {
            await presenter.viewDidAppear()
        }
    }
}

private extension FavouriteCoinsViewController {
    func setupNavigationBar() {
        navigationItem.title = "Favourites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func setupSubviews() {
        view.backgroundColor = .appBlack

        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
        tableview.backgroundColor = .appBlack
        tableview.dataSource = self
        tableview.delegate = self
        view.addSubview(tableview)

        tableview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension FavouriteCoinsViewController: CoinsListView {
    func showLoading() {
        tableview.tableFooterView = loadingIndicator
    }

    func hideLoading() {
        tableview.tableFooterView = UIView()
    }

    func display(_ coins: [Coin]) {
        self.coins = coins
        tableview.reloadData()
    }

    func display(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension FavouriteCoinsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(UITableViewCell.self)", for: indexPath)

        let coin = coins[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = coin.symbol
        content.secondaryText = "$\(coin.marketCap)"
        content.imageProperties.tintColor = .systemYellow

        cell.contentConfiguration = content

        return cell
    }
}

extension FavouriteCoinsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let coin = coins[indexPath.row]
        let action = UIContextualAction(style: .destructive, title: "Remove") { [weak self] _, _, completionHandler in
            self?.presenter.removeFavourite(coin.uuid)
            completionHandler(true)
        }
        action.backgroundColor = .systemRed
        action.image = UIImage(named: "remove_favourite")?.withTintColor(.white, renderingMode: .alwaysTemplate)

        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
}
