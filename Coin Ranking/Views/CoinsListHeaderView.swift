//
//  CoinsListHeaderView.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 13/01/2025.
//

import SwiftUI

struct CoinsListHeaderView: View {
    private typealias Dimensions = CoinRowView.Dimensions
    @StateObject var viewModel: SortOptionsViewModel

    var body: some View {
        HStack {
            Text("#")
                .frame(width: Dimensions.rank, alignment: .leading)

            SortButton(title: "Market Cap",
                       isSelected: viewModel.selectedOption == .marketCap,
                       sortDirection: viewModel.sortDirection,
                       indicatorPosition: .suffix,
                       action: { viewModel.selectedOption(.marketCap) })

            Spacer()

            SortButton(title: "Price",
                       isSelected: viewModel.selectedOption == .price,
                       sortDirection: viewModel.sortDirection,
                       indicatorPosition: .prefix,
                       action: { viewModel.selectedOption(.price) })
            .frame(width: Dimensions.price, alignment: .trailing)

            SortButton(title: "24h %",
                       isSelected: viewModel.selectedOption == .change,
                       sortDirection: viewModel.sortDirection,
                       indicatorPosition: .prefix,
                       action: { viewModel.selectedOption(.change) })
            .frame(width: Dimensions.change, alignment: .trailing)
            .padding(.leading, Dimensions.padding)
        }
        .font(.headline)
        .bold()
        .padding(.horizontal, Dimensions.padding)
        .padding(.vertical, 8)
        .frame(height: 40)
        .background(Color("AppBlack"))
        .foregroundStyle(Color.white)
    }

    private func tappedOption(_ option: SortOption) {
        viewModel.selectedOption(option)
    }
}

#Preview {
    CoinsListHeaderView(viewModel: SortOptionsViewModel())
}
