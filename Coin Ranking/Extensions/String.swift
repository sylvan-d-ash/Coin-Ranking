//
//  String.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 12/01/2025.
//

import Foundation

extension String {
    func formatMarketCap() -> String {
        guard let number = Double(self) else { return "" }

        switch number {
        case 1_000_000_000_000...:
            return String(format: "%.2fT", number / 1_000_000_000_000)
        case 1_000_000_000...:
            return String(format: "%.2fB", number / 1_000_000_000)
        case 1_000_000...:
            return String(format: "%.2fM", number / 1_000_000)
        default:
            return String(format: "%.0f", number) // No suffix for numbers below 1M
        }
    }

    func formatPrice(maxFractionDigits: Int = 2) -> String {
        guard let number = Double(self) else { return "" }

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = maxFractionDigits
        formatter.minimumFractionDigits = 0

        return formatter.string(from: NSNumber(value: number)) ?? self
    }
}
