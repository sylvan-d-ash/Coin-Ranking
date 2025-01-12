//
//  FilterOption.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 12/01/2025.
//

import Foundation

enum FilterDirection {
    case ascending
    case descending
}

enum FilterOption: String, CaseIterable, Equatable {
    case marketCap
    case price
    case volume
}

extension FilterOption {
    var displayValue: String {
        switch self {
        case .price: return "Price"
        case .marketCap: return "Market Cap"
        case .volume: return "24H Volume"
        }
    }
}
