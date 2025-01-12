//
//  CoinsListViewController.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 11/01/2025.
//

import UIKit

class CoinsListViewController: UIViewController {
    private let tableview = UITableView(frame: .zero, style: .plain)

    private var presenter: CoinsListPresenter!
    private var coins: [Coin] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSubviews()

        presenter = CoinsListPresenter(view: self)
        
        Task {
            await presenter.fetchCoins()
        }
    }
}

extension CoinsListViewController: CoinsListView {
    func showLoading() {
        // TODO
    }
    
    func hideLoading() {
        // TODO
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

private extension CoinsListViewController {
    func setupNavigationBar() {
        navigationItem.title = "Coins List"
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

extension CoinsListViewController: UITableViewDataSource {
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

extension CoinsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let coin = coins[indexPath.row]

        let action = UIContextualAction(style: .normal, title: "") { [weak self] _, _, completion in
            self?.presenter.toggleFavourite(for: coin.uuid)
            completion(true)
        }

        if presenter.isFavourite(coin.uuid) {
            action.backgroundColor = .systemRed
            action.image = UIImage(named: "remove_favourite")?.withTintColor(.white, renderingMode: .alwaysTemplate)
        } else {
            action.backgroundColor = .systemGreen
            action.image = UIImage(named: "add_favourite")?.withTintColor(.white, renderingMode: .alwaysTemplate)
        }

        let configuration = UISwipeActionsConfiguration(actions: [action])
        configuration.performsFirstActionWithFullSwipe = false

        return configuration
    }
}
