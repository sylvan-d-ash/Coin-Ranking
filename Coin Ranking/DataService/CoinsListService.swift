//
//  CoinsListService.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 11/01/2025.
//

import Foundation

enum CoinsListEndpoint: APIEndpoint {
    case getCoins(page: Int, sortOption: SortOption, sortDirection: SortDirection)
    case getFavourites(uuids: [String], page: Int)

    var path: String { return "/coins" }

    var parameters: [String : Any]? {
        let limit = 20

        switch self {
        case .getCoins(let page, let sortOption, let sortDirection):
            return [
                "offset": (page - 1) * limit,
                "limit": limit,
                "orderBy": sortOption.apiValue,
                "orderDirection": sortDirection.apiValue
            ]
        case .getFavourites(let uuids, let page):
            return [
                "offset": (page - 1) * limit,
                "limit": limit,
                "uuids[]": uuids
            ]
        }
    }
}

protocol CoinsListServiceProtocol: AnyObject {
    func fetchCoins(page: Int, sortOption: SortOption, sortDirection: SortDirection) async -> Result<CoinAPIResponse, Error>
    func fetchFavouriteCoins(uuids: [String], page: Int, sortOption: SortOption, sortDirection: SortDirection) async -> Result<CoinAPIResponse, Error>
}

final class CoinsListService: CoinsListServiceProtocol {
    let apiClient: APIClient

    init(apiClient: APIClient = URLSessionAPIClient()) {
        self.apiClient = apiClient
    }

    func fetchCoins(page: Int, sortOption: SortOption, sortDirection: SortDirection) async -> Result<CoinAPIResponse, Error> {
        let endpoint = CoinsListEndpoint.getCoins(page: page, sortOption: sortOption, sortDirection: sortDirection)
        return await apiClient.request(endpoint)
    }

    func fetchFavouriteCoins(uuids: [String], page: Int, sortOption: SortOption, sortDirection: SortDirection) async -> Result<CoinAPIResponse, Error> {
        let endpoint = CoinsListEndpoint.getFavourites(uuids: uuids, page: page)
        return await apiClient.request(endpoint)
    }
}
