//
//  TestView.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 12/01/2025.
//

import SwiftUI

struct TestView: View {
    @StateObject private var filtersViewModel = FiltersViewModel()

    var body: some View {
        VStack {
            FiltersView(filters: FilterOption.allCases, viewModel: filtersViewModel)
        }
    }
}

#Preview {
    TestView()
}
