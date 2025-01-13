//
//  CoinHistory.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 13/01/2025.
//

import Foundation

struct CoinHistory: Decodable {
    let price: String
    let timestamp: TimeInterval
}

struct CoinHistoryAPIResponse: Decodable {
    struct History: Decodable {
        let history: [CoinHistory]
    }

    let data: History
}
