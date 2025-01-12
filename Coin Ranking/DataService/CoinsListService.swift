//
//  CoinsListService.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 11/01/2025.
//

import Foundation

enum CoinsListEndpoint: APIEndpoint {
    case getCoins(page: Int)
    case getFavourites(uuids: [String], page: Int)

    var path: String { return "/coins" }

    var parameters: [String : Any]? {
        let limit = 20

        switch self {
        case .getCoins(let page):
            return [
                "offset": (page - 1) * limit,
                "limit": limit
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
    func fetchCoins(page: Int) async -> Result<CoinAPIResponse, Error>
    func fetchFavouriteCoins(with uuids: [String], page: Int) async -> Result<CoinAPIResponse, Error>
}

class CoinsListService: CoinsListServiceProtocol {
    let apiClient: APIClient

    init(apiClient: APIClient = URLSessionAPIClient()) {
        self.apiClient = apiClient
    }

    func fetchCoins(page: Int) async -> Result<CoinAPIResponse, Error> {
        let endpoint = CoinsListEndpoint.getCoins(page: page)
        return await apiClient.request(endpoint)
    }

    func fetchFavouriteCoins(with uuids: [String], page: Int) async -> Result<CoinAPIResponse, Error> {
        let endpoint = CoinsListEndpoint.getFavourites(uuids: uuids, page: page)
        return await apiClient.request(endpoint)
    }
}
