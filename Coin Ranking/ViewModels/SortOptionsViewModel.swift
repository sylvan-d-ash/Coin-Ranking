//
//  SortOptionsViewModel.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 12/01/2025.
//

import Foundation

final class SortOptionsViewModel: ObservableObject {
    @Published var selectedOption: SortOption? = .marketCap
    @Published var sortDirection: SortDirection = .descending

    func selectedOption(_ option: SortOption) {
        if option == selectedOption {
            sortDirection = (sortDirection == .descending) ? .ascending : .descending
        } else {
            sortDirection = .descending
        }
        selectedOption = option
    }
}
