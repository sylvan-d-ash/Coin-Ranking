//
//  FavouriteCoinsPresenter.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 12/01/2025.
//

import Foundation

final class FavouriteCoinsPresenter {
    private weak var view: CoinsListView?
    private let store: FavouritesStoreProtocol
    private var coins: [Coin] = []

    init(view: CoinsListView?, store: FavouritesStoreProtocol = FavouritesStore.shared) {
        self.view = view
        self.store = store
    }

    func fetchFavourites() {
        //
    }

    func removeFavourite(_ uuid: String) {
        store.removeFavourite(uuid)
        coins.removeAll { $0.uuid == uuid }
        view?.display(coins)
    }
}
