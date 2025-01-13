//
//  CoinDetails.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 13/01/2025.
//

import Foundation

struct CoinDetails: Decodable {
    struct Supply: Decodable {
        let max: String?
        let total: String
        let circulating: String
    }

    struct AllTimeHigh: Decodable {
        let price: String
    }

    let uuid: String
    let name: String
    let symbol: String
    let rank: Int
    let price: String
    let change: String
    let marketCap: String
    let volume: String // 24hVolume
    let fullyDilutedMarketCap: String
    let description: String
    let numberOfMarkets: Int
    let numberOfExchanges: Int
    let supply: Supply
    let allTimeHigh: AllTimeHigh

    private enum CodingKeys: String, CodingKey {
        case uuid, name, symbol, rank, price, change
        case marketCap, fullyDilutedMarketCap, description
        case numberOfMarkets, numberOfExchanges, supply, allTimeHigh
        case volume = "24hVolume"
    }
}

struct CoinDetailsAPIResponse: Decodable {
    struct CoinData: Decodable {
        let coin: CoinDetails
    }

    let data: CoinData
}
