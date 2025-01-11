//
//  Coin.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 11/01/2025.
//

import Foundation

struct Coin: Decodable {
    let id: String
    let symbol: String
    let marketCap: String
    let price: String
    let iconUrl: String
    let sparkline: [String]
}

struct CoinAPIResponse: Decodable {
    let coins: [Coin]
}
