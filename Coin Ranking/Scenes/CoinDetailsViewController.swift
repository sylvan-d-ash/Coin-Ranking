//
//  CoinDetailsViewController.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 12/01/2025.
//

import UIKit
import SwiftUI

final class CoinDetailsViewController: UIViewController {
    private var coin: Coin
    private let viewModel: CoinDetailsViewModel

    init(coin: Coin) {
        self.coin = coin
        viewModel = CoinDetailsViewModel(coin: coin)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSubviews()
    }
}

private extension CoinDetailsViewController {
    func setupNavigationBar() {
        navigationItem.title = coin.symbol
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func setupSubviews() {
        view.backgroundColor = .appBlack

        let detailsView = CoinDetailsView(viewModel: self.viewModel)
        let hostingController = UIHostingController(rootView: detailsView)
        addChild(hostingController)
        view.addSubview(hostingController.view)

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        hostingController.didMove(toParent: self)
    }
}
