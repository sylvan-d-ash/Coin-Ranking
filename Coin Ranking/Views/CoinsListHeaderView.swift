//
//  CoinsListHeaderView.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 13/01/2025.
//

import SwiftUI

struct CoinsListHeaderView: View {
    private typealias Dimensions = CoinRowView.Dimensions
    
    var body: some View {
        HStack {
            Text("#")
                .frame(width: Dimensions.rank, alignment: .leading)

            Text("Market Cap")

            Spacer()

            Text("Price")
                .frame(width: Dimensions.price, alignment: .trailing)

            Text("24H")
                .frame(width: Dimensions.change)
                .padding(.leading, Dimensions.padding)
        }
        .font(.headline)
        .bold()
        .padding(.horizontal, Dimensions.padding)
        .padding(.vertical, 8)
        .background(Color("AppBlack"))
        .foregroundStyle(Color.white)
    }
}

#Preview {
    CoinsListHeaderView()
}
