//
//  CoinDetailsViewModel.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 13/01/2025.
//

import Foundation

@MainActor
final class CoinDetailsViewModel: ObservableObject {
    @Published private(set) var isLoadingDetails = false
    @Published private(set) var isLoadingHistory = false
    @Published private(set) var details: CoinDetails?
    @Published private(set) var history = [CoinHistory]()
    @Published var errorMessage: String?

    private let coin: Coin
    private let service: CoinDetailsServiceProtocol

    init(coin: Coin, service: CoinDetailsServiceProtocol = CoinDetailsService()) {
        self.coin = coin
        self.service = service
    }

    func fetchDetails() async {
        isLoadingDetails = true

        let results = await service.fetchDetails(for: coin.uuid)

        switch results {
        case .failure(let error):
            errorMessage = "Failed to fetch coin details: \(error.localizedDescription)"
        case .success(let response):
            details = response.data.coin
        }

        isLoadingDetails = false

        await fetchHistory()
    }

    func fetchHistory() async {
        isLoadingHistory = true

        let results = await service.fetchHistory(for: coin.uuid)

        switch results {
        case .failure(let error):
            errorMessage = "Failed to fetch price history: \(error.localizedDescription)"
        case .success(let response):
            history = response.data.history
        }

        isLoadingHistory = false
    }
}
