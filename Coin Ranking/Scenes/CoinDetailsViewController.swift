//
//  CoinDetailsViewController.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 12/01/2025.
//

import UIKit

final class CoinDetailsViewController: UIViewController {
    private var coin: Coin

    init(coin: Coin) {
        self.coin = coin
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
    }
}
