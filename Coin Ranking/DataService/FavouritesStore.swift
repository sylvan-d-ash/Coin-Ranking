//
//  FavouritesStore.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 12/01/2025.
//

import Foundation

protocol FavouritesStoreProtocol: AnyObject {
    func addFavourite(_ uuid: String)
    func removeFavourite(_ uuid: String)
    func isFavourite(_ uuid: String) -> Bool
    func allFavourites() -> [String]
}

final class FavouritesStore: FavouritesStoreProtocol {
    static let shared = FavouritesStore()
    private init() {}

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
