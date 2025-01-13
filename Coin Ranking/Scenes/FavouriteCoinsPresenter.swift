//
//  FavouriteCoinsPresenter.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 12/01/2025.
//

import Foundation

@MainActor
final class FavouriteCoinsPresenter {
    private weak var view: CoinsListView?
    private let service: CoinsListServiceProtocol
    private let store: FavouritesStoreProtocol

    private var coins = [Coin]()
    private var isLoading = false
    private var currentPage = 1

    init(view: CoinsListView?, service: CoinsListServiceProtocol = CoinsListService(), store: FavouritesStoreProtocol = FavouritesStore.shared) {
        self.view = view
        self.service = service
        self.store = store
    }

    func viewDidAppear() async {
        coins = []
        guard !store.allFavourites().isEmpty else { return }
        await fetchFavourites()
    }

    func loadMore() async {
        currentPage += 1
        await fetchFavourites()
    }

    func removeFavourite(_ uuid: String) {
        store.removeFavourite(uuid)
        coins.removeAll { $0.uuid == uuid }
        view?.display(coins)
    }

    private func fetchFavourites() async {
        guard !isLoading, coins.count < CoinsListPresenter.maximumCoins else { return }

        let allFavourites = store.allFavourites()
        guard coins.count < allFavourites.count else { return }
        isLoading = true
        view?.showLoading()

        let result = await service.fetchFavouriteCoins(with: allFavourites, page: currentPage)
        switch result {
        case .failure(let error):
            view?.display(error.localizedDescription)
        case .success(let response):
            coins.append(contentsOf: response.data.coins)
            view?.display(coins)
        }

        isLoading = false
        view?.hideLoading()
    }
}
