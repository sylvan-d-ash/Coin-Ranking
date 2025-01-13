//
//  CoinDetailsService.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 13/01/2025.
//

import Foundation

enum CoinDetailsEndpoint: APIEndpoint {
    case details(uuid: String)
    case history(uuid: String)

    var path: String {
        switch self {
        case .details(let uuid): return "/coin/\(uuid)"
        case .history(let uuid): return "/coin/\(uuid)/history"
        }
    }

    var parameters: [String : Any]? { return nil }
}

protocol CoinDetailsServiceProtocol: AnyObject {
    func fetchDetails(for uuid: String) async -> Result<CoinDetailsAPIResponse, Error>
    func fetchHistory(for uuid: String) async -> Result<CoinHistoryAPIResponse, Error>
}

final class CoinDetailsService: CoinDetailsServiceProtocol {
    private let apiClient: APIClient

    init(apiClient: APIClient = URLSessionAPIClient()) {
        self.apiClient = apiClient
    }

    func fetchDetails(for uuid: String) async -> Result<CoinDetailsAPIResponse, Error> {
        return await apiClient.request(CoinDetailsEndpoint.details(uuid: uuid))
    }
    
    func fetchHistory(for uuid: String) async -> Result<CoinHistoryAPIResponse, Error> {
        return await apiClient.request(CoinDetailsEndpoint.history(uuid: uuid))
    }
}
