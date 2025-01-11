//
//  CoinsListPresenter.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 11/01/2025.
//

import Foundation

protocol CoinsListView: AnyObject {
    func showLoading()
    func hideLoading()
    func display(_ coins: [Coin])
    func display(_ error: String)
}

@MainActor
final class CoinsListPresenter {
    private weak var view: CoinsListView?
    private let service: CoinsListServiceProtocol
    
    private var coins = [Coin]()
    private var isLoading = false
    private var currentPage = 1

    init(view: CoinsListView?, service: CoinsListServiceProtocol = CoinsListService()) {
        self.view = view
        self.service = service
    }

    func fetchCoins() async {
        guard !isLoading else { return }
        isLoading = true
        view?.showLoading()

        let result = await service.fetchCoins(page: currentPage)
        switch result {
        case .failure(let error):
            view?.display(error.localizedDescription)
        case .success(let response):
            coins.append(contentsOf: response.data.coins)
            view?.display(coins)
        }

        isLoading = false
    }

    func loadMore() async {
        currentPage += 1
        await fetchCoins()
    }
}
