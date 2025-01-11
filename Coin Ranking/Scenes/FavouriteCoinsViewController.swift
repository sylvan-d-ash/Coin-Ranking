//
//  FavouriteCoinsViewController.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 11/01/2025.
//

import UIKit

final class FavouriteCoinsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSubviews()
    }
}

private extension FavouriteCoinsViewController {
    func setupNavigationBar() {
        navigationItem.title = "Favourites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func setupSubviews() {
        view.backgroundColor = .appBlack
    }
}
