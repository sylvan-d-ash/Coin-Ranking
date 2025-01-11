//
//  Coin.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 11/01/2025.
//

import Foundation

struct Coin: Decodable {
    let id: String
    let rank: Int
    let symbol: String
    let marketCap: String
    let price: String
    let iconUrl: String
    //let sparkline: [Double]

    private enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case rank, symbol, marketCap, price, iconUrl//, sparkline
    }
}

struct CoinAPIResponse: Decodable {
    struct CoinData: Decodable {
        let coins: [Coin]
    }

    let data: CoinData
}
