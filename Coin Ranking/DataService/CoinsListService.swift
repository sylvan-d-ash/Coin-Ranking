//
//  CoinsListService.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 11/01/2025.
//

import Foundation

enum CoinsListEndpoint: APIEndpoint {
    case getCoins(page: Int)

    var path: String { return "/coins" }

    var parameters: [String : Any]? {
        switch self {
        case .getCoins(let page):
            return [
                "offset": page,
                "limit": 20
            ]
        }
    }
}

protocol CoinsListServiceProtocol: AnyObject {
    func fetchCoins(page: Int) async -> Result<CoinAPIResponse, Error>
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
}
