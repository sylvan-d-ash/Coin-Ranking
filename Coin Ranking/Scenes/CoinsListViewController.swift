//
//  CoinsListViewController.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 11/01/2025.
//

import UIKit
import SwiftUI
import Combine

class CoinsListViewController: UIViewController {
    private let tableview = UITableView(frame: .zero, style: .plain)
    private let loadingIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        return activityIndicator
    }()

    private var presenter: CoinsListPresenter!
    private var coins: [Coin] = []

    private var selectedFilter: FilterOption?
    private var filtersViewModel = FiltersViewModel()
    private var cancellables = Set<AnyCancellable>()

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

private extension CoinsListViewController {
    func setupNavigationBar() {
        navigationItem.title = "Coins List"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func setupSubviews() {
        view.backgroundColor = .appBlack

        let filtersView = FiltersView(filters: FilterOption.allCases, viewModel: filtersViewModel)
        filtersViewModel.$selectedFilter.sink { [weak self] filter in
            guard let self = self else { return }

            if filter == .marketCap {
                print("Can be equated")
            }
        }.store(in: &cancellables)
        
        let hostingController = UIHostingController(rootView: filtersView)
        addChild(hostingController)
        view.addSubview(hostingController.view)

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        hostingController.didMove(toParent: self)

        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
        tableview.backgroundColor = .appBlack
        tableview.dataSource = self
        tableview.delegate = self
        view.addSubview(tableview)

        tableview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
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
        content.secondaryText = "$" + coin.marketCap.formatCurrency()
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
