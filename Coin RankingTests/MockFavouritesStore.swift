//
//  MockFavouritesStore.swift
//  Coin RankingTests
//
//  Created by Sylvan Ash on 14/01/2025.
//

import Foundation
@testable import Coin_Ranking

final class MockFavouritesStore: FavouritesStoreProtocol {
    private var favourites = Set<String>()

    func addFavourite(_ uuid: String) {
        favourites.insert(uuid)
    }

    func removeFavourite(_ uuid: String) {
        favourites.remove(uuid)
    }

    func isFavourite(_ uuid: String) -> Bool {
        return favourites.contains(uuid)
    }

    func allFavourites() -> [String] {
        return Array(favourites)
    }
}
