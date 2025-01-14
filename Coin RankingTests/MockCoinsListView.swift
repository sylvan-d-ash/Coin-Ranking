//
//  MockCoinsListView.swift
//  Coin RankingTests
//
//  Created by Sylvan Ash on 14/01/2025.
//

import Foundation
@testable import Coin_Ranking

final class MockCoinsListView: CoinsListView {
    var showLoadingCalled = false
    var hideLoadingCalled = false
    var displayedCoins: [Coin]?
    var displayedError: String?

    func showLoading() {
        showLoadingCalled = true
    }

    func hideLoading() {
        hideLoadingCalled = true
    }

    func display(_ coins: [Coin]) {
        displayedCoins = coins
    }

    func display(_ error: String) {
        displayedError = error
    }
}
