//
//  Coin.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 11/01/2025.
//

import Foundation

struct Coin: Decodable {
    let uuid: String
    let rank: Int
    let symbol: String
    let marketCap: String
    let price: String
    let iconUrl: String
    let change: String
    //let sparkline: [Double]
}

struct CoinAPIResponse: Decodable {
    struct CoinData: Decodable {
        let coins: [Coin]
    }

    let data: CoinData
}
