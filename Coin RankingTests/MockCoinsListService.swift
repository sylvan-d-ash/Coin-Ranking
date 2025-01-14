//
//  MockCoinsListService.swift
//  Coin RankingTests
//
//  Created by Sylvan Ash on 14/01/2025.
//

import XCTest
@testable import Coin_Ranking

final class MockCoinsListService: CoinsListServiceProtocol {
    var shouldReturnError = false
    var fetchedPage: Int?
    var fetchedSortOption: SortOption?
    var fetchedSortDirection: SortDirection?
    var fetchedUuids: [String]?

    func fetchCoins(page: Int, sortOption: SortOption, sortDirection: SortDirection) async -> Result<CoinAPIResponse, Error> {
        fetchedPage = page
        fetchedSortOption = sortOption
        fetchedSortDirection = sortDirection

        if shouldReturnError {
            return .failure(NSError(domain: "TestError", code: 0, userInfo: nil))
        }

        let mockResponse = CoinAPIResponse(data: CoinAPIResponse.CoinData(coins: [
            Coin(uuid: "1", rank: 1, symbol: "BTC", marketCap: "1T", price: "50000", iconUrl: "", change: "1.5"),
            Coin(uuid: "2", rank: 2, symbol: "ETH", marketCap: "500B", price: "3000", iconUrl: "", change: "-0.5"),
        ]))
        return .success(mockResponse)
    }

    func fetchFavouriteCoins(uuids: [String], page: Int, sortOption: SortOption, sortDirection: SortDirection) async -> Result<CoinAPIResponse, Error> {
        fetchedUuids = uuids
        fetchedPage = page
        fetchedSortOption = sortOption
        fetchedSortDirection = sortDirection

        if shouldReturnError {
            return .failure(NSError(domain: "TestError", code: 0, userInfo: nil))
        }

        let mockResponse = CoinAPIResponse(data: CoinAPIResponse.CoinData(coins: [
            Coin(uuid: "1", rank: 1, symbol: "BTC", marketCap: "1T", price: "50000", iconUrl: "", change: "1.5"),
            Coin(uuid: "2", rank: 2, symbol: "ETH", marketCap: "500B", price: "3000", iconUrl: "", change: "-0.5"),
        ]))
        return .success(mockResponse)
    }
}
