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
    private var selectedSortOption: SortOption = .marketCap
    private var sortDirection: SortDirection = .descending

    init(view: CoinsListView?, service: CoinsListServiceProtocol = CoinsListService(), store: FavouritesStoreProtocol = FavouritesStore.shared) {
        self.view = view
        self.service = service
        self.store = store
    }

    func viewDidAppear() async {
        coins = []
        currentPage = 1
        selectedSortOption = .marketCap
        sortDirection = .descending
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

    func sortCoins(by option: SortOption, direction: SortDirection) async {
        coins = []
        currentPage = 1
        selectedSortOption = option
        sortDirection = direction
        await fetchFavourites()
    }

    private func fetchFavourites() async {
        guard !isLoading, coins.count < CoinsListPresenter.maximumCoins else { return }

        let allFavourites = store.allFavourites()
        guard !allFavourites.isEmpty, coins.count < allFavourites.count else { return }

        isLoading = true
        view?.showLoading()

        let result = await service.fetchFavouriteCoins(uuids: allFavourites,
                                                       page: currentPage,
                                                       sortOption: selectedSortOption,
                                                       sortDirection: sortDirection)
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
