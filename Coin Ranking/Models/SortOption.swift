//
//  SortOption.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 12/01/2025.
//

import Foundation

enum SortDirection {
    case ascending
    case descending

    var apiValue: String {
        switch self {
        case .descending: return "desc"
        case .ascending: return "asc"
        }
    }
}

enum SortOption: CaseIterable, Equatable {
    case marketCap
    case price
    case volume
    case change

    var displayValue: String {
        switch self {
        case .price: return "Price"
        case .marketCap: return "Market Cap"
        case .volume: return "24H Volume"
        case .change: return "24h %"
        }
    }

    var apiValue: String {
        switch self {
        case .marketCap: return "marketCap"
        case .price: return "price"
        case .volume: return "24hVolume"
        case .change: return "change"
        }
    }
}
